//
//  AddNewPlace.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import Foundation

struct AddNewPlace:Codable {
    var place:String
    var title:String
    var description:String
    var coverImageUrl:String
    var latitude:Double
    var longitude:Double
    
    enum CodingKeys:String,CodingKey {
        case place
        case title
        case description
        case coverImageUrl = "cover_image_url"
        case latitude
        case longitude
    }
}

struct PostAGallery:Codable {
    var placeId: String
    var imageUrl: String
    
    enum CodingKeys:String,CodingKey {
        case placeId = "place_id"
        case imageUrl = "image_url"
        
    }
}

