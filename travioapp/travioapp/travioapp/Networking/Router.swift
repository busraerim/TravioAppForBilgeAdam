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
    case getNew
    case getPopularWith(params:Parameters)
    case getNewPlacesWith(params:Parameters)
    case getAllPlacesMap
    case me
    case editProfile(param:Parameters)
    case changePassword(param:Parameters)
    case postAPlace(param:Parameters)
    case getAllPlacesforUser
    case getAllVisits
    


    
    var baseURL:String {
        return "https://ios-class-2f9672c5c549.herokuapp.com"
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
        case .getNewPlacesWith, .getNew:
            return "/v1/places/last"
        case .getAllPlacesMap:
            return "/v1/places"
        case .me:
            return "/v1/me"
        case .changePassword:
            return "/v1/change-password"
        case .editProfile:
            return "/v1/edit-profile"
        case .postAPlace:
            return "/v1/places"
        case .getAllPlacesforUser:
            return "/v1/places/user"
        case .getAllVisits:
            return "/v1/visits"
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .login, .register, .refresh, .postAPlace:
            return .post
        case .visits, .getPopular ,.getPopularWith, .getNewPlacesWith, .getNew, .getAllPlacesMap, .me ,.getAllPlacesforUser, .getAllVisits:
            return .get
        case .editProfile, .changePassword:
            return .put
        }
    
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .login, .register, .refresh, .getPopular, .getPopularWith, .getNewPlacesWith, .getNew, .getAllPlacesMap:
            return [:]
        case .visits, .me, .changePassword, .editProfile, .postAPlace, .getAllPlacesforUser, .getAllVisits:
            guard let token = AuthManager.shared.getAccessToken() else { return [:] }
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    var parameters:Parameters? {
        switch self {
        case .login(let params), .register(let params), .refresh(let params), .getPopularWith(let params), .getNewPlacesWith(let params), .editProfile(let params), .changePassword(let params), .postAPlace(let params):
            return params
        case .visits, .getPopular, .getNew, .getAllPlacesMap, .me, .getAllPlacesforUser, .getAllVisits:
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
            case .post, .put:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    
    
}


