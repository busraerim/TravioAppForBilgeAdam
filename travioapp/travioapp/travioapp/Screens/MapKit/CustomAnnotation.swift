//
//  CustomAnnotation.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation
import TinyConstraints

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: String?
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
