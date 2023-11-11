//
//  AuthManager.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation
import Security

class AuthManager {
    static let shared = AuthManager()
    
    private let keychainService = "com.travio"
    
    func saveToken(_ token: String, accountIdentifier: String) {
        if let data = token.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: keychainService,
                kSecAttrAccount as String: accountIdentifier,
                kSecValueData as String: data
            ]

            var existingItem: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &existingItem)

            if status == errSecSuccess {
                let attributesToUpdate: [String: Any] = [
                    kSecValueData as String: data
                ]

                let updateStatus = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

                if updateStatus != errSecSuccess {
                    print("Error updating token in Keychain: \(updateStatus)")
                }
            } else if status == errSecItemNotFound {
                let newItem: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrService as String: keychainService,
                    kSecAttrAccount as String: accountIdentifier,
                    kSecValueData as String: data
                ]

                let addStatus = SecItemAdd(newItem as CFDictionary, nil)

                if addStatus != errSecSuccess {
                    print("Error adding token to Keychain: \(addStatus)")
                }
            } else {
                print("Error accessing Keychain: \(status)")
            }
        }
    }
    
    func getToken(accountIdentifier: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: accountIdentifier,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecSuccess, let data = item as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        } else {
            return nil
        }
    }
    
    func deleteToken(accountIdentifier: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: accountIdentifier,
            kSecAttrService as String: keychainService
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            print("Error deleting access token from Keychain: \(status)")
        }
    }
}
