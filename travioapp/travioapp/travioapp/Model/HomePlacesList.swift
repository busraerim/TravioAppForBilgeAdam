//
//  HomePlacesList.swift
//  travioapp
//
//  Created by Büşra Erim on 30.10.2023.
//

import Foundation

//struct HomePlacesAndTitle{
//    var title:String
//    var places:[HomePlaces]
//}

struct HomePlaces:Codable {
    var place:String?
    var title:String?
    //    var description:String?
    var imageUrl:String?
    //    var latitude:String?
    //    var longitude:String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "cover_image_url"
    }
}

//
//var popularPlaces = [HomePlacesAndTitle(title: "Popular Places",
//                                         places: [ HomePlaces(place: "Rome", title: "Colleseum1", imageUrl: "colleseum"),
//                                                   HomePlaces(place: "Rome", title: "Colleseum2", imageUrl: "colleseum"),
//                                                   HomePlaces(place: "Rome", title: "Colleseum3", imageUrl: "colleseum")]
//                                        )]
//
//var newPlaces = [HomePlacesAndTitle(title: "New Places",
//                                    places: [ HomePlaces(place: "Turkey", title: "Suleymaniye", imageUrl: "colleseum"),
//                                              HomePlaces(place: "Turkey", title: "Suleymaniye2", imageUrl: "suleymaniye"),
//                                              HomePlaces(place: "Turkey", title: "Suleymaniye3", imageUrl: "suleymaniye"),
//                                              HomePlaces(place: "Turkey", title: "Suleymaniye4", imageUrl: "suleymaniye")]
//)]
//
//var lastPlaces = [HomePlacesAndTitle(title: "Last Places", 
//                                     places: [ HomePlaces(place: "Turkey", title: "Suleymaniye", imageUrl: "suleymaniye"),
//                                               HomePlaces(place: "Turkey", title: "Suleymaniye2", imageUrl: "suleymaniye"),
//                                               HomePlaces(place: "Turkey", title: "Suleymaniye3", imageUrl: "suleymaniye"),
//                                               HomePlaces(place: "Turkey", title: "Suleymaniye4", imageUrl: "suleymaniye")]
//)]


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


//
//var popularPlaces:[HomePlaces] = [ HomePlaces(place: "Rome", title: "Colleseum1", imageUrl: "colleseum"),
//                                 HomePlaces(place: "Rome", title: "Colleseum2", imageUrl: "colleseum"),
//                                 HomePlaces(place: "Rome", title: "Colleseum3", imageUrl: "colleseum")
//]
//
//var newPlaces:[HomePlaces] = [ HomePlaces(place: "Turkey", title: "Suleymaniye", imageUrl: "colleseum"),
//                             HomePlaces(place: "Turkey", title: "Suleymaniye2", imageUrl: "suleymaniye"),
//                             HomePlaces(place: "Turkey", title: "Suleymaniye3", imageUrl: "suleymaniye"),
//                             HomePlaces(place: "Turkey", title: "Suleymaniye4", imageUrl: "suleymaniye")
//]
//
//var lastPlaces:[HomePlaces] = [ HomePlaces(place: "Turkey", title: "Suleymaniye", imageUrl: "suleymaniye"),
//                             HomePlaces(place: "Turkey", title: "Suleymaniye2", imageUrl: "suleymaniye"),
//                             HomePlaces(place: "Turkey", title: "Suleymaniye3", imageUrl: "suleymaniye"),
//                             HomePlaces(place: "Turkey", title: "Suleymaniye4", imageUrl: "suleymaniye")
//]


//var homePlaces = [popularPlaces,newPlaces,lastPlaces]
var homeTitle = ["Popular Places", "New Places", "Last Places"]
