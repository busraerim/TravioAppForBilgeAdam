//
//  UploadViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 9.11.2023.
//

import Foundation

struct UploadViewModel {
    
//    func uploadFile(){
//
//        let params = []
//
//        GenericNetworkingHelper.shared.createMultipartFormDataBody(parameters: params, fileURL: <#T##URL#>, fieldName: <#T##String#>, fileName: <#T##String#>, mimeType: <#T##String#>)(urlRequest: .editProfile(param: params), callback: { (result:Result<UploadResponse, Error>) in
//            switch result {
//            case .success(let success):
//                print(success.message ?? "A")
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        })
//    }
    func uploadImage(imageData: Data, completion: @escaping (Result<[String], Error>) -> Void) {
        let url = URL(string: "https://your-api-endpoint.com/upload")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Oluşturulan veriyi doğrudan istekle ayarlayın.
//        request.httpBody = createMultipartFormDataBody(imageData: imageData)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let messageType = json["messageType"] as? String,
                       let message = json["message"] as? String,
                       let urls = json["urls"] as? [String] {
                        if messageType == "S" {
                            completion(.success(urls))
                        } else {
                            completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: message])))
                        }
                    } else {
                        completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
        }

        task.resume()
    }

    
}
