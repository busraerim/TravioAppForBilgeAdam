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
    case upload(imageData: [Data])
    case getAllGallerybyPlaceID(id:String)
    case postAGallery(param: Parameters)
    case postAVisit(param:Parameters)
    case deleteAVisitByPlaceID(id:String)
    case checkVisitByPlaceID(id:String)
    



    
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
        case .upload:
            return "/upload"
        case .getAllGallerybyPlaceID(let id):
            return "/v1/galleries/\(id)"
        case .postAGallery:
            return "/v1/galleries"
        case .postAVisit:
            return "/v1/visits"
        case .deleteAVisitByPlaceID(let id):
            return "/v1/visits/\(id)"
        case .checkVisitByPlaceID(id: let id):
            return "/v1/visits/user/\(id)"
        }
    }
    
    
    var method:HTTPMethod {
        switch self {
        case .login, .register, .refresh, .postAPlace, .upload, .postAGallery, .postAVisit:
            return .post
        case .visits, .getPopular ,.getPopularWith, .getNewPlacesWith, .getNew, .getAllPlacesMap, .me ,.getAllPlacesforUser, .getAllVisits, .getAllGallerybyPlaceID, .checkVisitByPlaceID:
            return .get
        case .editProfile, .changePassword:
            return .put
        case .deleteAVisitByPlaceID:
            return .delete
        }
    
    }
    
    
    var headers:HTTPHeaders {
        switch self {
        case .login, .register, .refresh, .getPopular, .getPopularWith, .getNewPlacesWith, .getNew, .getAllPlacesMap, .getAllGallerybyPlaceID:
            return [:]
        case .visits, .me, .changePassword, .editProfile, .postAPlace, .getAllPlacesforUser, .getAllVisits, .postAGallery, .postAVisit, .deleteAVisitByPlaceID, .checkVisitByPlaceID:
            guard let token = AuthManager.shared.getToken(accountIdentifier: "access-token") else { return [:] }
            return ["Authorization": "Bearer \(token)"]
        case .upload:
            return ["Content-Type": "multipart/form-data"]
        }
    }
    
    var multipartFormData: MultipartFormData {
      let formData = MultipartFormData()
      switch self {
      case .upload(let imageData):
          imageData.forEach { image in
              formData.append(image, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
          }
          return formData
      default:
          break
      }
      return formData
    }
    
    var parameters:Parameters? {
        switch self {
        case .login(let params), .register(let params), .refresh(let params), .getPopularWith(let params), .getNewPlacesWith(let params), .editProfile(let params), .changePassword(let params), .postAPlace(let params), .postAGallery(let params), .postAVisit(let params):
            return params
        case .visits, .getPopular, .getNew, .getAllPlacesMap, .me, .getAllPlacesforUser, .getAllVisits, .getAllGallerybyPlaceID, .upload, .deleteAVisitByPlaceID, .checkVisitByPlaceID:
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


