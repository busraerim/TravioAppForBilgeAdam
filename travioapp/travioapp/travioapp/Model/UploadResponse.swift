//
//  UploadResponse.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 9.11.2023.
//

import Foundation

struct UploadResponse:Codable {
    var messageType:String
    var message:String
    var urls:[String]
}
