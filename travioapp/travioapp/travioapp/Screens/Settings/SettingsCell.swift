//
//  SettingsCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    var buttonAction: (() -> Void)?
    
    func configure(data: SettingsCellModel){
        label.text = data.label
        iconImageView.image = UIImage(named: data.iconImage)
    }
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.frame.size = CGSize(width: frame.width, height: frame.height)
        return view
    }()
    
    private lazy var iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "person.circle.fill")
        return iv
    }()
    
    private lazy var label:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var button:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(.arrowRight, for: .normal)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        backView.addSubview(stackView)
        
        stackView.addArrangedSubviews(iconImageView, label, UIView(), button)
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }}
