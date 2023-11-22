//
//  HomePlacesList.swift
//  travioapp
//
//  Created by Büşra Erim on 30.10.2023.
//

import Foundation


struct PlaceData: Codable {
    let count: Int
    let places: [PlaceItem]
}


struct PlaceItem: Codable {
    let id: String
    let creator: String
    let place: String
    let title: String
    let description: String
    let coverImageUrl: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys:String,CodingKey {
        case id
        case creator
        case place
        case title
        case description
        case coverImageUrl = "cover_image_url"
        case latitude
        case longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
    }
    
}

struct Place: Codable {
    let data: PlaceData
    let status: String
}

typealias PlaceTitleTupple = (title:String, places:[PlaceItem])

typealias HomeList = [(title:String, places:[PlaceItem])]



