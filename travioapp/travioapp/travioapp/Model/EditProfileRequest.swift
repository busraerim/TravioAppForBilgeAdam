//
//  EditProfileRequest.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

struct EditProfileRequest:Codable {
    var fullName:String
    var email:String
    var ppUrl:String
    
    enum CodingKeys:String,CodingKey {
        case fullName = "full_name"
        case email
        case ppUrl = "pp_url"
        
    }
}
