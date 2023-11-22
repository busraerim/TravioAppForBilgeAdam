//
//  HeaderView.swift
//  travioapp
//
//  Created by Büşra Erim on 31.10.2023.
//

import Foundation
import UIKit
import TinyConstraints

class HeaderView: UICollectionReusableView {
    
    static let reuseId = "HeaderView"
    let label = UILabel()
    let button = UIButton()
    
//    typealias DataPlace = [TuplePlace]
    typealias DataPlace = [PlaceTitleTupple]

    
    var dataClosure: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    func setupContent() {
         
        label.font = CustomFont.subHeader2.font
        label.text = "Section ?? "
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = CustomFont.subHeader3.font
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(HomeUIVC(), action: #selector(btnSeeAll), for: .touchUpInside)
        
        addSubviews(label,button)
        button.trailingToSuperview(offset: 16)
        button.bottomToSuperview()
        label.leadingToSuperview(offset: 18)
        label.bottomToSuperview()
    }
    
    @objc func btnSeeAll(){
        dataClosure?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
