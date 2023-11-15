//
//  HeaderView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 14.11.2023.
//

import UIKit

class AppHeaderView: UIView {
    
    public lazy var labelTitle:UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Poppins-SemiBold", size: 36)
       return label
    }()
    
    public lazy var backView:UIView = {
        let view = UIView()
        return view
    }()
    
    private func setupViews(){
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
