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

struct MyVisit:Codable {
    let id: String
    let placeId: String
    let visitedAt: String
    let createdAt: String
    let updatedAt: String
    let place: PlaceItem
    
    enum CodingKeys:String,CodingKey {
        case id
        case placeId = "place_id"
        case visitedAt = "visited_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case place
    }
    
    
    
}
