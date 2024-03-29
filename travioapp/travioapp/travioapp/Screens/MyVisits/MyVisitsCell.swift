//
//  MyVisitsCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 31.10.2023.
//

import UIKit
import Kingfisher

class MyVisitsCell: UICollectionViewCell {
    
    static let identifier = "myVisitCell"
    
    lazy var backView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var icon:UIImageView = {
        let iv = UIImageView()
        iv.image = .locationItem
        iv.size(CGSize(width: 15, height: 20))
        return iv
    }()
    
    private lazy var gradient:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Rectangle 12")
        return iv
    }()
    
    private lazy var image:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = CustomFont.header3.font
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var lblSubtitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = CustomFont.subTitle1.font
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func configure(object: MyVisit) {
        let url = URL(string: object.place.coverImageUrl)
        let placeholderImage = UIImage(systemName: "photo.artframe")
        image.kf.setImage(with: url, placeholder: placeholderImage)
        lblSubtitle.text = object.place.place
        lblTitle.text = object.place.title
    }
    
    private func setupViews(){
        contentView.addSubview(backView)
        backView.addSubviews(image, lblTitle, lblSubtitle, icon)
        image.addSubviews(gradient)
        setupLayout()
    }
    
    private func setupLayout(){
        backView.edgesToSuperview()
        image.edges(to: backView)
        gradient.bottomToSuperview()
        gradient.leadingToSuperview()
        gradient.trailingToSuperview()
        lblTitle.leading(to: backView, offset: 16)
        lblTitle.trailing(to: backView, offset: -16)
        lblTitle.bottom(to: backView, offset: -26)
        lblSubtitle.centerY(to: icon)
        lblSubtitle.leadingToTrailing(of: icon, offset: 6)
        icon.leading(to: backView, offset: 16)
        icon.bottom(to: backView, offset: -11)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
