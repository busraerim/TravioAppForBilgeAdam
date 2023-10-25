//
//  TraviaBackgroundView.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import UIKit

class TraviaBackgroundView: UIView {

    private lazy var backView:UIView = {
       let backView = UIView()
        backView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
       return backView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backView.edgesToSuperview(excluding: .top)
        self.backView.height(598)
        self.backView.width(390)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
