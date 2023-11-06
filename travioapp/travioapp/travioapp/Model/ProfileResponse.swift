//
//  ProfileResponse.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

struct ProfileResponse:Codable {
    var full_name:String
    var email:String
    var pp_url:String
    var role:String
    var created_at:String
}
