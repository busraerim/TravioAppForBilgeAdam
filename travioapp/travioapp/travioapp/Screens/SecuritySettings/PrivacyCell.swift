//
//  PrivacyCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit

class PrivacyCell: UICollectionViewCell {
        
    static let identifier = "privacyCell"
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.frame.size = CGSize(width: frame.width, height: frame.height)
        return view
    }()
    
    private lazy var labelText:UILabel = {
        let lbl = UILabel()
        lbl.text = "Text"
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var toggleSwitch:UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private lazy var stackView:UIStackView = {
        let sv = UIStackView()
        sv.spacing = 5
        sv.axis = .horizontal
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        backView.addSubview(stackView)
        
        stackView.addArrangedSubviews(labelText, UIView(), toggleSwitch)
        setupLayouts()
    }
    
    
    func configure(data: String){
        labelText.text = data
    }

    
    private func setupLayouts() {
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
