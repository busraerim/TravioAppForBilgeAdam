//
//  ChangePasswordCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit
import SnapKit

class ChangePasswordCell: UIView {
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.frame.size = CGSize(width: frame.width, height: frame.height)
        return view
    }()
    
    lazy var label:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var textfieldPassword:UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "Poppins-Medium", size: 12)
        return tf
    }()
    
    lazy var stackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 8
        return sv
    }()
    
    func configure(titleLabel:String, fieldText:String) {
        label.text = titleLabel
        textfieldPassword.text = fieldText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        stackView.addArrangedSubviews(label, textfieldPassword)
        backView.addSubviews(stackView)
        
        setupLayouts()
    }
    
    
    func configure(data: String){
        label.text = data
    }

    
    private func setupLayouts() {
        backView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(8)
        }
        
        textfieldPassword.snp.makeConstraints({ make in
            make.width.equalTo(325)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
