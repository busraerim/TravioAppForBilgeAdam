//
//  ScrollCell.swift
//  travioapp
//
//  Created by Büşra Erim on 9.11.2023.
//

import UIKit
import Kingfisher


class ScrollCell: UICollectionViewCell {
    

        public lazy var placeView:UIView = {
            let view = UIView()
            return view
        }()
    
        private lazy var gradient:UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "Rectangle 13")
            return iv
        }()
        
        public lazy var image:UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            return image
        }()
    
        func configure(object: String) {
            let url = URL(string: object)
            image.kf.setImage(with: url)
        }
 
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        private func setupViews(){
            contentView.backgroundColor = .clear
            backgroundColor = .clear
            self.contentView.addSubview(placeView)
            placeView.addSubviews(image)
            image.addSubviews(gradient)
            setupLayout()
        }
        
        private func setupLayout(){

            placeView.edgesToSuperview()
            image.edges(to: placeView)
            gradient.bottomToSuperview()
            gradient.leadingToSuperview()
            gradient.trailingToSuperview()
     
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
        
    

}
