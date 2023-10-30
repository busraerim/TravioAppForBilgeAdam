//
//  MyVisitsCell.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 27.10.2023.
//

import UIKit
import TinyConstraints

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MyVisitsCell_Preview: PreviewProvider {
    static var previews: some View{
         
        MyVisitsCell().showPreview()
    }
}
#endif

class MyVisitsCell: UITableViewCell {

    //item background?
    private lazy var item:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var image:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var lblVisitLocation:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 30)
        return lbl
    }()
    
    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Light", size: 16)
        return lbl
    }()
    
    private func setupViews(){
        self.contentView.addSubviews(image, lblPlace, lblVisitLocation)
        image.addSubview(item)
        setupLayout()
    }
    
    func configure(object: MyVisits) {
        image.image = UIImage(named: object.imageUrl!)
        lblPlace.text = object.place
        lblVisitLocation.text = object.title
    }
    
    private func setupLayout(){
        image.frame = CGRect(x: 0, y: 0, width: 344, height: 219)
        
        lblVisitLocation.frame = CGRect(x: 8, y: 142, width: 299, height: 45)
        
        lblPlace.frame = CGRect(x: 29, y: 180, width: 250, height: 24)
        
        item.frame = CGRect(x: 8, y: 180, width: 15, height: 20)
        item.image = .locationItem
        

    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
