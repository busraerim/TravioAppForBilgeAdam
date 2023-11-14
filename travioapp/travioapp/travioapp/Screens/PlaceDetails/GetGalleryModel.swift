//
//  GetGalleryModel.swift
//  travioapp
//
//  Created by Büşra Erim on 10.11.2023.
//

import Foundation

struct ImageData: Codable {
    let count: Int
    let images: [Image]
}

struct Image: Codable {
    let id: String
    let place_id: String
    let image_url: String
    let created_at: String
    let updated_at: String
}

struct APIResponse: Codable {
    let data: ImageData
    let status: String
}


struct PostAVisit{
    let place_id:String
    let visited_at:String
}
