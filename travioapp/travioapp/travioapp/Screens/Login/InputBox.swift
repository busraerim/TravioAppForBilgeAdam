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

    var boxPlaceholder:TitlePlaceholderText = .placeholder(placeholder: " "){
        didSet{
            txtPlaceholder.placeholder = boxPlaceholder.text
        }
    }
    
    public lazy var lblTitle:UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = CustomFont.subHeader3.font
        title.width(129)
        return title
    }()
    
    public lazy var txtPlaceholder: UITextField = {
       let placeholder = UITextField()
        placeholder.font = CustomFont.subTitle3.font
        placeholder.autocapitalizationType = .none
        placeholder.width(250)
        return placeholder
    }()
    
    public lazy var showPasswordButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eyes.inverse"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    

    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.cornerRadius = 16
        self.height(74)
        self.backgroundColor =  UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.15
        self.addSubviews(lblTitle,txtPlaceholder, showPasswordButton)

        lblTitle.topToSuperview(offset: 8)
        lblTitle.leadingToSuperview(offset: 12)
        lblTitle.trailingToSuperview(offset:12)
        
        txtPlaceholder.topToBottom(of: lblTitle, offset: 8)
        txtPlaceholder.leadingToSuperview(offset: 12)
        txtPlaceholder.trailingToSuperview(offset:12)
        
        showPasswordButton.trailingToSuperview(offset:20)
        showPasswordButton.centerYToSuperview()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

