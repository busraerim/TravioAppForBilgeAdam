//
//  LoginNetworkingHelper.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import Foundation
import Alamofire

class GenericNetworkingHelper {

    static let shared = GenericNetworkingHelper()
    
    typealias Callback<T:Codable> = (Result<T,Error>)->Void
    
    public func getDataFromRemote<T:Codable>(urlRequest:Router, callback:@escaping Callback<T>) {
        DispatchQueue.global(qos: .background).async {
            AF.request(urlRequest).validate().responseDecodable(of:T.self) { response in
                switch response.result {
                case .success(let success):
                    callback(.success(success))
                case .failure(let failure):
                    callback(.failure(failure))
                }
            }
        }
    }
   
    public func uploadImage<T: Decodable>(urlRequest: Router, responseType: T.Type, callback: @escaping Callback<T>) {
        AF.upload(multipartFormData: urlRequest.multipartFormData, with: urlRequest).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                callback(.success(success))
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
        
    }
    
    
    

}
