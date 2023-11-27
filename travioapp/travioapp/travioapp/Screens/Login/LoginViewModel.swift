//
//  LoginViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import Foundation
import Alamofire


class LoginViewModel{
<<<<<<< HEAD
    
     
    var kisiler:[User] = [] {
        didSet {
            self.transferData?()
        }
    }
=======
>>>>>>> Sprint6/Refactor2
    
    var onSuccessLogin: (() -> ())?
    var onError: ((String, String) -> ())?

    func loginControl(email: String, password: String) {
        if !email.isEmpty && !password.isEmpty {
            postData(email: email, password: password)
        } else {
            onError?("Hata", "Email veya şifre boş olamaz.")
        }
    }

    func postData(email: String, password: String) {
        let params = ["email": email, "password": password]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .login(param: params), callback: { [weak self] (result: Result<UserToken, Error>) in
            switch result {
            case .success(let user):
                if let accessToken = user.accessToken {
                    AuthManager.shared.saveToken(accessToken, accountIdentifier: "access-token")
<<<<<<< HEAD
                    self.onSuccessLogin?()
                    info.email = email
                    info.password = password
=======
                    self?.onSuccessLogin?()
>>>>>>> Sprint6/Refactor2
                } else {
                    self?.onError?("Hata", "Access token bulunamadı.")
                }

                if let refreshToken = user.refreshToken {
                    AuthManager.shared.saveToken(refreshToken, accountIdentifier: "refresh-token")
                } else {
                    self?.onError?("Error", "Refresh token bulunamadı.")
                }

            case .failure(let failure):
                if failure.localizedDescription == "Response status code was unacceptable: 401."{
                    self?.onError?("Hata", "Geçersiz kullanıcı adı veya şifre.")
                } else {
                    self?.onError?("Hata", "Kullanıcı bulunamadı.")
                }
            }
        })
    }
}
