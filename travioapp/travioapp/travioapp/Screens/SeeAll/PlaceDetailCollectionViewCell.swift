//
//  PlaceDetailCollectionViewCell.swift
//  travioapp
//
//  Created by Büşra Erim on 1.11.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class SeeAllCollectionCell: UICollectionViewCell {
    
    public lazy var placeView:CustomView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var icon:UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Vector-21")
        return icon
    }()
    
    public lazy var image:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var lblVisitLocation:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 24)
        lbl.height(36)
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Poppins-Light", size: 14)
        return lbl
    }()
    
    func configure(object: PlaceItem) {
        let url = URL(string: object.coverImageUrl)
        image.kf.setImage(with: url)
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

        self.contentView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        self.contentView.layer.shadowRadius = 20
        self.contentView.layer.shadowOpacity = 0.15
        placeView.edgesToSuperview()
        
        image.topToSuperview()
        image.leadingToSuperview()
        image.bottomToSuperview()
        image.width(90)
        
        lblVisitLocation.leadingToTrailing(of: image,offset: 8)
        lblVisitLocation.bottom(to: placeView, offset: -26)
        lblVisitLocation.trailingToSuperview()
        
 
        icon.leadingToTrailing(of: image, offset:8)
        icon.topToBottom(of: lblVisitLocation)
        
        lblPlace.leadingToTrailing(of: icon,offset: 6)
        lblPlace.centerY(to: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
