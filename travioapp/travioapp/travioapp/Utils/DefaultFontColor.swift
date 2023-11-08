//
//  DefaultFontColor.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import UIKit

let defaultFont = UIFont(name: "Avenir-Medium", size: 16)!

enum Colors {
    case boxColor
    case appGreenColor
    
    var color: UIColor {
        switch self {
        case .boxColor:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case .appGreenColor:
            return UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        }
    }
}


enum Fonts {
    case poppinsMedium(size:CGFloat)
    case poppinsRegular(size:CGFloat)
    case poppinsLight(size:CGFloat)
    
    var font: UIFont {
        switch self {
        case .poppinsMedium(let size):
            return UIFont(name: "Poppins-Medium", size: size) ?? defaultFont
        case .poppinsRegular(let size):
            return UIFont(name: "Poppins-Regular", size: size) ?? defaultFont
        case .poppinsLight(let size):
            return UIFont(name: "Poppins-Light", size: size) ?? defaultFont
        }
    }
}
