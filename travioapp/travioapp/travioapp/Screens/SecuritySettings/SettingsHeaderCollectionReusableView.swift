//
//  SettingsHeaderCollectionReusableView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit

class SettingsHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifer = "headerCollectionReusableView"
    
    private lazy var headerTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Header"
        lbl.textColor = .background
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    public func configure(){
        addSubviews(headerTitle)
        backgroundColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerTitle.frame = bounds
    }
}
