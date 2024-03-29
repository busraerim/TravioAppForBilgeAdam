//
//  CustomNewPlaceView.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import UIKit
import TinyConstraints

class CustomNewPlaceView: UIView {

    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.cornerRadius = 16
        self.backgroundColor =  UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.15
        self.addSubviews(title)
        
        title.topToSuperview(offset:8)
        title.leadingToSuperview(offset:16)
     

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
