//
//  CustomView.swift
//  travioapp
//
//  Created by Büşra Erim on 1.11.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class CustomView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.cornerRadius = 16
        self.backgroundColor =  UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        self.layer.masksToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
