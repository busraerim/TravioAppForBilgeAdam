//
//  Register.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 25.10.2023.
//

import Foundation

struct Register:Codable{
    var username:String? //full_name
    var email:String?
    var password:String?
    
    enum CodingKeys:String,CodingKey {
        case username = "full_name"
    }
}
