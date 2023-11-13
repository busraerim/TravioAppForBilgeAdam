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
    var cover_image_url:String
    var latitude:Double
    var longitude:Double
}

struct PostAGallery:Codable {
    var place_id: String
    var image_url: String
}

