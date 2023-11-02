//
//  EditProfileCustomView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 2.11.2023.
//

import UIKit
import SnapKit

class EditProfileCustomView: UIView {
    
    lazy var textfield:UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "Poppins-Medium", size: 12)
        return tf
    }()
    
    lazy var icon:UIImageView = {
        let icon = UIImageView()
        icon.image = .userRoleIcon
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.height(52)
        self.backgroundColor =  .white
        self.layer.cornerRadius = 16
        self.dropShadow()
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(icon, textfield)
        setupLayout()
    }
    
    private func setupLayout(){
        
        icon.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        })
        
        textfield.snp.makeConstraints({ make in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
