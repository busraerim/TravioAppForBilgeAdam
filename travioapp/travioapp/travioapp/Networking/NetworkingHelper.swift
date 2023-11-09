//
//  LoginNetworkingHelper.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import Foundation
import Alamofire

class GenericNetworkingHelper {
    
    // test
    
    
    static let shared = GenericNetworkingHelper()
    
    typealias Callback<T:Codable> = (Result<T,Error>)->Void
    
    public func getDataFromRemote<T:Codable>(urlRequest:Router, callback:@escaping Callback<T>) {
        
        AF.request(urlRequest).validate().responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let success):
                callback(.success(success))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
    func createMultipartFormDataBody(parameters: [String: String], fileURL: URL, fieldName: String, fileName: String, mimeType: String) -> Data {
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()

        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)

        do {
            body.append(try Data(contentsOf: fileURL))
        } catch {
            print("Failed to read file data: \(error)")
        }

        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }
}
