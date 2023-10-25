//
//  LoginNetworkingHelper.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import Foundation
import Alamofire

class NetworkingHelper {
    
    
    
    static let shared = NetworkingHelper()
    
    typealias Callback<T:Codable> = (Result<T,Error>)->Void
    
    public func postData<T:Codable>(urlRequest:Router, callback:@escaping Callback<T>) {
        
        AF.request(urlRequest).validate().responseJSON(completionHandler: { response in
            
            
            switch response.result {
            case .success(let object):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: object)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
                
                
                
            case .failure(let err):
                callback(.failure(err))
            }
        })
    }
}
