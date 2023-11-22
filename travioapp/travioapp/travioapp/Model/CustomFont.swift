//
//  CustomFont.swift
//  travioapp
//
//  Created by Büşra Erim on 22.11.2023.
//

import Foundation
import UIKit

enum CustomFont {
    case header1
    case header2
    case header3
    case header4
    case header5
    case header6
    case subHeader1
    case subHeader2
    case subHeader3
    case subHeader4
    case title1
    case title2
    case title3
    case subTitle1
    case subTitle2
    case subTitle3
    case subTitle4
   
    var font: UIFont? {
        switch self {
        case .header1:
            return UIFont(name: "Poppins-SemiBold", size: 36)
        case .header2:
            return UIFont(name: "Poppins-SemiBold", size: 32)
        case .header3:
            return UIFont(name: "Poppins-SemiBold", size: 30)
        case .header4:
            return UIFont(name: "Poppins-SemiBold", size: 24)
        case .header5:
            return UIFont(name: "Poppins-SemiBold", size: 16)
        case .header6:
            return UIFont(name: "Poppins-SemiBold", size: 14)
        case .subHeader1:
            return UIFont(name: "Poppins-Medium", size: 24)
        case .subHeader2:
            return UIFont(name: "Poppins-Medium", size: 20)
        case .subHeader3:
            return UIFont(name: "Poppins-Medium", size: 14)
        case .subHeader4:
            return UIFont(name: "Poppins-Medium", size: 12)
        case .title1:
            return UIFont(name: "Poppins-Regular", size: 14)
        case .title2:
            return UIFont(name: "Poppins-Regular", size: 12)
        case .title3:
            return UIFont(name: "Poppins-Regular", size: 10)
        case .subTitle1:
            return UIFont(name: "Poppins-Light", size: 16)
        case .subTitle2:
            return UIFont(name: "Poppins-Light", size: 14)
        case .subTitle3:
            return UIFont(name: "Poppins-Light", size: 12)
        case .subTitle4:
            return UIFont(name: "Poppins-Light", size: 10)
        }
    }
}
