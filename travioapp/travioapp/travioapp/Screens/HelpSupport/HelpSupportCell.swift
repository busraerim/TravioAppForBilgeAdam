//
//  HelpSupportCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 9.11.2023.
//

import UIKit

class HelpSupportCell: UICollectionViewCell {
    
    static let identifier = "helpCell"
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    public lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.font = CustomFont.title1.font
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = .textcolor
        return lbl
    }()
    
    private lazy var icon:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = .faq
        return iv
    }()
    
    private lazy var lblSubTitle:UILabel = {
        let lbl = UILabel()
        lbl.font = CustomFont.title3.font
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = .textcolor
        return lbl
    }()
    
    func configure(data:HelpSupportCellModel){
        lblTitle.text = data.title
        lblSubTitle.text = data.subTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backView)
        backView.addSubviews(lblTitle, lblSubTitle, icon)
        
        setupLayout()
    }
    
    private func setupLayout() {

        backView.dropShadow()
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(11)
            make.height.equalTo(15)
            make.centerY.equalTo(lblTitle)
            make.leading.equalTo(lblTitle.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(6)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(4)
            make.bottom.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
