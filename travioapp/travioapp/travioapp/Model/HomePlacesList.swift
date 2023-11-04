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
    let cover_image_url: String
    let latitude: Double
    let longitude: Double
    let created_at: String
    let updated_at: String
    
}

struct Place: Codable {
    let data: PlaceData
    let status: String
}

typealias PopularPlaceList = (title:String, places:[PlaceItem])

typealias HomeList = [(title:String, places:[PlaceItem])]



