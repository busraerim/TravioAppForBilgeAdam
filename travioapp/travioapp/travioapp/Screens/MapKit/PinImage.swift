//
//  PinImage.swift
//  travioapp
//
//  Created by Büşra Erim on 6.11.2023.
//

import UIKit
import TinyConstraints


class PinImage: UIImage {
    
    let logo = UIImageView()
    let pin = UIImageView()

    func setupContent() {
        
        logo.image = UIImage(named: "travio-logo 1")
        pin.image = UIImage(named: "Vector 1")
        
        logo.top(to: pin, offset: 4)
        logo.centerX(to: pin)

    }
        
}
