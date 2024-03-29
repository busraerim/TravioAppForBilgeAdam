//
//  MapCollectionCell.swift
//  travioapp
//
//  Created by Büşra Erim on 6.11.2023.
//

import UIKit
import Kingfisher

class MapCollectionCell: UICollectionViewCell {
    
    public lazy var placeView:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var icon:UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Vector")
        return icon
    }()
    
    public lazy var image:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var lblVisitLocation:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = CustomFont.header4.font
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = CustomFont.subTitle1.font
        return lbl
    }()
    
    func configure(object: PlaceItem) {
        let url = URL(string: object.coverImageUrl)
        let placeholderImage = UIImage(systemName: "photo.artframe")
        image.kf.setImage(with: url, placeholder: placeholderImage)
        lblPlace.text = object.place
        lblVisitLocation.text = object.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        self.contentView.addSubview(placeView)
        placeView.addSubviews(image,lblPlace,lblVisitLocation)
        image.addSubview(icon)
        setupLayout()
    }
    
    private func setupLayout(){

        placeView.edgesToSuperview()
        image.edges(to: placeView)
        lblVisitLocation.leading(to: placeView, offset: 16)
        lblVisitLocation.trailing(to: placeView, offset: -6)
        lblVisitLocation.bottom(to: placeView, offset: -26)
        lblPlace.bottom(to: placeView, offset: -5)
        lblPlace.leading(to: placeView, offset: 31)
        icon.leading(to: placeView, offset: 16)
        icon.bottom(to: placeView, offset: -11)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
