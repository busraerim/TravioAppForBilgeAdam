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
    case register(param: Parameters)
    case refresh(param: Parameters)
    case visits
    case getPopular
    case getPopularWith(params:Parameters)
    
    var baseURL:String {
        return "https://api.iosclass.live"
    }

    var path:String {
        switch self {
        case .login:
            return "/v1/auth/login"
        case .register:
            return "/v1/auth/register"
        case .refresh:
            return "/v1/auth/refresh"
        case .visits:
            return "/v1/visits"
        case .getPopular, .getPopularWith:
            return "/v1/places/popular"
            
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .login, .register, .refresh:
            return .post
        case .visits, .getPopular ,.getPopularWith:
            return .get
        }
    
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .login, .register, .refresh, .getPopular, .getPopularWith:
            return [:]
        case .visits:
            guard let data = KeychainHelper.shared.read(service: "access-token", account: "travio") else { return [:] }
            let token = String(data: data, encoding: .utf8)!
            return ["access-token":token]
       
        }
    }
    
    var parameters:Parameters? {
        switch self {
        case .login(let params), .register(let params), .refresh(let params), .getPopularWith(let params):
            return params
        case .visits, .getPopular:
            return nil

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


