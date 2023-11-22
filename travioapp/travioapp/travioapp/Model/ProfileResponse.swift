//
//  ProfileResponse.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

struct ProfileResponse:Codable {
    var fullName:String
    var email:String
    var ppUrl:String
    var role:String
    var createdAt:String
    
    enum CodingKeys:String,CodingKey {
        case fullName = "full_name"
        case email
        case ppUrl = "pp_url"
        case role
        case createdAt = "created_at"
        
    }
}
