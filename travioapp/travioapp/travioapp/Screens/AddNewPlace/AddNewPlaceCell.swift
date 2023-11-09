//
//  AddNewPlaceCell.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import UIKit

class AddNewPlaceCell: UICollectionViewCell {
    
    private lazy var addImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Vector-19")
        return image
    }()
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Add Photo"
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        label.font = Fonts.poppinsLight(size: 12).font
        return label
    }()
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var customView:UIView = {
        let view = UIView()
        view.backgroundColor =  Colors.boxColor.color
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        self.addSubviews(customView, stackView)
        customView.addSubviews(stackView)
        stackView.addArrangedSubviews(addImage,label)
        setupLayout()
    }
    
    private func setupLayout(){
        customView.height(215)
        customView.width(269)
        customView.edgesToSuperview()
        
        customView.layoutIfNeeded()
        customView.roundAllCorners(radius: 16)

        
        stackView.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}