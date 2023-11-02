//
//  ChangePasswordCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit

class ChangePasswordCell: UICollectionViewCell {
    
    static let identifier = "passwordCell"

    private lazy var backView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.frame.size = CGSize(width: frame.width, height: frame.height)
        return view
    }()
    
    private lazy var label:UILabel = {
        let lbl = UILabel()
        lbl.text = "Example"
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var textfieldPassword:UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        backView.addSubviews(label, textfieldPassword)
        
        setupLayouts()
    }
    
    
    func configure(data: String){
        label.text = data
    }

    
    private func setupLayouts() {
        
        label.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
        })
        
        textfieldPassword.snp.makeConstraints({ make in
            make.bottom.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
