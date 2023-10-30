//
//  MyVisits.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 27.10.2023.
//

import Foundation
import UIKit

struct MyVisits:Codable {
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
