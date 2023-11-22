//
//  ChangePasswordRequest.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

struct ChangePasswordRequest:Codable {
    var newPassword:String?
    
    enum CodingKeys:String,CodingKey {
        case newPassword = "new_password"
        
    }
    
}
