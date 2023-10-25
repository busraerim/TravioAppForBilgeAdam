//
//  InputBox.swift
//  travioapp
//
//  Created by Büşra Erim on 15.10.2023.
//

import UIKit
import SnapKit
import TinyConstraints

enum TitlePlaceholderText {
    case label(label: String?)
    case placeholder(placeholder: String?)
    
    var text:String?{
        switch self {
        case .label(let label):
            return label
        case .placeholder(let placeholder):
            return placeholder
        }
    }

}

class InputBox: UIView {
    
    var boxTitle:TitlePlaceholderText = .label(label: " ") {
        didSet{
            lblTitle.text = boxTitle.text
        }
    }

    var boxPlaceholder:TitlePlaceholderText = .placeholder(placeholder: ""){
        didSet{
            txtPlaceholder.placeholder = boxPlaceholder.text
        }
    }
    
    public lazy var lblTitle:UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont(name: "Avenir-Medium", size: 16)
        title.width(39)
        title.height(21)
        return title
    }()
    
    public lazy var txtPlaceholder: UITextField = {
       let placeholder = UITextField()
        placeholder.font = UIFont(name: "Avenir-Medium", size: 14)
        return placeholder
    }()
    

    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.cornerRadius = 16
        self.height(74)
        self.backgroundColor =  UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.15
        self.addSubviews(lblTitle,txtPlaceholder)

        lblTitle.topToSuperview(offset: 10)
        lblTitle.leadingToSuperview(offset: 5)
        lblTitle.trailingToSuperview(offset: 200)
        
        txtPlaceholder.topToBottom(of: lblTitle, offset: 6)
//        txtPlaceholder.centerX(to: lblTitle)
        txtPlaceholder.leadingToSuperview(offset: 5)
        txtPlaceholder.trailingToSuperview(offset: 200)

        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
  //sv.layer.shadowRadius=20
//sv.layer.shadowopacity = 0.15
