//
//  
//  MyVisitsVC.swift
//  travioapp
//
//  Created by Büşra Erim on 26.10.2023.
//
//


import UIKit
import TinyConstraints
import SnapKit

class MyVisitsVC: UIViewController {

    private lazy var lblMyVisits:UILabel = {
        let lbl = UILabel()
        lbl.height(52)
        lbl.width(165)
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 36)
        lbl.text = "My Visits"
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return lbl
    }()
    
    private lazy var backView:TravioBackgroundView = {
        let backView = TravioBackgroundView()
        return backView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.22, green: 0.68, blue: 0.66, alpha: 1.00)
       setupViews()
       
    }

    func setupViews() {
        self.view.addSubviews(backView,lblMyVisits)
        setupLayout()
    }
    
    func setupLayout() {
        backView.edgesToSuperview(excluding: .top)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)
        
        lblMyVisits.topToSuperview(offset: 40)
        lblMyVisits.leadingToSuperview(offset: 24)
       
    }
  
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MyVisitsVC_Preview: PreviewProvider {
    static var previews: some View{
         
        MyVisitsVC().showPreview()
    }
}
#endif
