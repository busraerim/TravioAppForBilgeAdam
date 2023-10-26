//
//  UserToken.swift
//  travioapp
//
//  Created by Büşra Erim on 26.10.2023.
//

import Foundation

struct UserToken:Codable {
    var accessToken:String?
    var refreshToken:String?
    var message:String?
    var status:String?
}
