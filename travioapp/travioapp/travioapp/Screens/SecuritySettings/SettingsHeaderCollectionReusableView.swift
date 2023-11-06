//
//  SettingsHeaderCollectionReusableView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit
import SnapKit

class SettingsHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifer = "headerCollectionReusableView"
    
     lazy var headerTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Header"
        lbl.textColor = .background
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(headerTitle)
        
        headerTitle.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview().offset(25)
            make.leading.trailing.equalToSuperview().inset(12)
        })
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}
