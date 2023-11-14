//
//  MyVisits.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 27.10.2023.
//

import Foundation
import UIKit


struct ApiResponse: Codable {
    let data: MyVisitData
    let status: String
}

struct MyVisitData: Codable {
    let count: Int
    let visits: [MyVisit]
}

struct MyVisit: Codable {
    let id: String
    let place_id: String
    let visited_at: String
    let created_at: String
    let updated_at: String
    let place: PlaceItem
}

//struct MyVisitPlace: Codable {
//    let id: String
//    let creator: String
//    let place: String
//    let title: String
//    let description: String
//    let cover_image_url: String
//    let latitude: Double
//    let longitude: Double
//    let created_at: String
//    let updated_at: String
//}
