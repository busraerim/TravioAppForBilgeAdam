//
//  TraviaBackgroundView.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import UIKit

class TravioBackgroundView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        self.height(719)
        self.width(390)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
