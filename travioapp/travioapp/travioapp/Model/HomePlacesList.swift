//
//  HomePlacesList.swift
//  travioapp
//
//  Created by Büşra Erim on 30.10.2023.
//

import Foundation

struct HomePlaces:Codable {
    var place:String?
    var title:String?
    var imageUrl:String?
  
    enum CodingKeys: String, CodingKey {
        case imageUrl = "cover_image_url"
    }
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



