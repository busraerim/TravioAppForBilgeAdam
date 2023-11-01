//
//  
//  PlaceDetailsVC.swift
//  travioapp
//
//  Created by Büşra Erim on 31.10.2023.
//
//
import UIKit
import TinyConstraints

class PlaceDetailsVC: UIViewController {
    
    private lazy var backView:UIView = {
        let backView = UIView()
        backView.height(719)
        backView.width(390)
        backView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        return backView
    }()
    
    private lazy var labelTitle:UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Poppins-SemiBold", size: 36)
        label.text = "Popular Place"
       return label
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        self.view.addSubviews(backView,labelTitle)
       setupViews()
       
    }
    
  
    func setupViews() {
        // Add here the setup for the UI
        self.view.addSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        backView.topToSuperview(offset:125)
        backView.edgesToSuperview(excluding: .top)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)
        
        
        labelTitle.topToSuperview(offset:46)
        labelTitle.leadingToSuperview(offset:24)
    }
  
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PlaceDetailsVC_Preview: PreviewProvider {
    static var previews: some View{
         
        PlaceDetailsVC().showPreview()
    }
}
#endif
