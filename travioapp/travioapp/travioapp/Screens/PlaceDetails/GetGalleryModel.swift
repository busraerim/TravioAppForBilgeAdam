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
    let placeId: String
    let imageUrl: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys:String,CodingKey {
        case id
        case placeId = "place_id"
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
    }
}

struct APIResponse: Codable {
    let data: ImageData
    let status: String
}


struct PostAVisit{
    let placeId:String
    let visitedAt:String
    
    enum CodingKeys:String,CodingKey {
        case placeId = "place_id"
        case visitedAt = "visited_at"
    }
}
