//
//  PrivacyCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit
import SnapKit

class PrivacyCell: UIView {
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    lazy var labelText:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    lazy var toggleSwitch:UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private lazy var stackView:UIStackView = {
        let sv = UIStackView()
        sv.spacing = 8
        sv.axis = .horizontal
        sv.alignment = .center
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
        backView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{ make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(74)

        }
        
        toggleSwitch.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
