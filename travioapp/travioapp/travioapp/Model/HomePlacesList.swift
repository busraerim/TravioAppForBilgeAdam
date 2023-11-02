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

struct HomePlaces:Codable {
    var id:String?
    var creator:String?
    var place:String?
    var title:String?
    var imageUrl:String?
    var description:String?
    var latitude:Double?
    var longitude:Double?
    var createdAt:String?
    var updatedAt:String?
  
}


struct DataPlace:Codable{
    var count:Int
    var places:[HomePlaces]
}



typealias TuplePlace = (title:String, places:[HomePlaces])



var deneme = [(title: "Popular", places: [ HomePlaces(place: "Rome", title: "Colleseum1", imageUrl: "colleseum"),
                                           HomePlaces(place: "Rome", title: "Colleseum2", imageUrl: "colleseum"),
                                           HomePlaces(place: "Rome", title: "Colleseum3", imageUrl: "colleseum")]
              )]

var deneme2 = [ (title: "New Places", places: [ HomePlaces(place: "Turkey", title: "Suleymaniye", imageUrl: "suleymaniye"),
                                            HomePlaces(place: "Turkey", title: "Suleymaniye2", imageUrl: "suleymaniye"),
                                            HomePlaces(place: "Turkey", title: "Suleymaniye3", imageUrl: "suleymaniye"),
                                            HomePlaces(place: "Turkey", title: "Suleymaniye4", imageUrl: "suleymaniye")
               ])
]

var deneme3 = [ (title:"Deneme", places: [ HomePlaces(place: "Turkey", title: "Suleymaniye", imageUrl: "suleymaniye"),
                                           HomePlaces(place: "Turkey", title: "Suleymaniye2", imageUrl: "suleymaniye"),
                                           HomePlaces(place: "Turkey", title: "Suleymaniye3", imageUrl: "suleymaniye"),
                                           HomePlaces(place: "Turkey", title: "Suleymaniye4", imageUrl: "suleymaniye")
            ] )
]


var denemearrayi = [deneme, deneme2, deneme3]



