//
//  LoginRouter.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import Foundation
import Alamofire

enum Router {
    
    case login(param: Parameters)
  
    
    var baseURL:String {
        return "https://api.iosclass.live"
    }
    
    var path:String {
        switch self {
        case .login:
            return "/v1/auth/login"
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .login:
            return [:]
        }
    }
    
    var parameters:Parameters? {
        switch self {
        case .login(let params):
            return params
        }
    }
    
    
}

extension Router:URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        
        let encoding:ParameterEncoding = {
            switch method {
            case .post:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    
    
}


