//
//  
//  HomeUIVC.swift
//  travioapp
//
//  Created by Büşra Erim on 27.10.2023.
//
//
import UIKit
import TinyConstraints

class HomeUIVC: UIViewController {
    
    private lazy var travioLogoImage:UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y:0, width: 66, height: 62))
        image.image = UIImage(named: "travio-logo 1")
        return image
    }()
    
    private lazy var travioImage:UIImageView = {
        let image = UIImageView(frame: CGRect(x: 84.11, y: 44.28, width: 102.44, height: 28.04))
        image.image = UIImage(named: "travio")
        return image
    }()

    private lazy var backView:TravioBackgroundView = {
        let backView = TravioBackgroundView()
        backView.height(719)
        backView.width(390)
        return backView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
    }

    func setupViews() {
        self.view.addSubviews(backView,travioLogoImage,travioImage)
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        setupLayout()
    }
    
    func setupLayout() {
        backView.topToSuperview(offset:125)
        backView.edgesToSuperview(excluding: .top)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)
        
        travioLogoImage.height(62)
        travioLogoImage.width(66)
        travioLogoImage.leadingToSuperview(offset: 16)
        travioLogoImage.topToSuperview(offset: 50)
        travioImage.topToSuperview(offset: 60)
        travioImage.leadingToTrailing(of: travioLogoImage)
        
    }
  
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeUIVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HomeUIVC().showPreview()
    }
}
#endif
