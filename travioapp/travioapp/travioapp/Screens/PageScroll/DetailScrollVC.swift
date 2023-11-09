//
//  
//  DetailScrollVC.swift
//  travioapp
//
//  Created by Büşra Erim on 9.11.2023.
//
//
import UIKit
import TinyConstraints

class DetailScrollVC: UIViewController {
    
  
    
    private lazy var backView:UIView = {
        let view = UIView()
//        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    private lazy var labelTitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font =  UIFont(name: "Poppins-SemiBold", size: 30)
        lbl.text = "İstanbul"
//        lbl.backgroundColor = .link
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var lblCreatedDate:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
//        lbl.backgroundColor = .link
        lbl.numberOfLines = 0
        lbl.text =  "jnfdk"
        return lbl
    }()
    
    private lazy var lblAddedByWho:UILabel = {
        let lbl = UILabel()
        lbl.text = "added by" //creator
        lbl.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 10)
//        lbl.backgroundColor = .brown
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
//        stack.backgroundColor = .purple
        stack.spacing = 10
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var lblDescription:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 12)
        lbl.text = "Lorem Ipsum is simply dummy text of thrlngeindustry. Lorem Ipsum has been the industry's standarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjnstandarkjgnkejlrgnjn12635137615271654127645123764512645154175417252176451276415776352"
        lbl.numberOfLines = 0
//        lbl.backgroundColor = .darkGray
        return lbl
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 16
        map.clipsToBounds = true
        return map
    }()
   
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .link
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.delaysContentTouches = false
        scrollView.alwaysBounceVertical = true
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: 1000)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Content Size: \(scrollView.contentSize)")
       setupViews()
       
    }
    

    func setupViews() {
        self.view.addSubviews(scrollView)
        scrollView.addSubviews(backView)
        stackView.addArrangedSubviews(labelTitle,lblCreatedDate,lblAddedByWho)

        backView.addSubviews(stackView,mapView,lblDescription)
        setupLayout()
    }
    
    func setupLayout() {
        
        scrollView.edgesToSuperview()
                
        backView.edgesToSuperview(usingSafeArea: true)

        stackView.topToSuperview(offset: 24)
        stackView.leadingToSuperview(offset: 24)
        stackView.trailingToSuperview(offset: 24)

        mapView.topToBottom(of: stackView, offset: 16)
        mapView.leadingToSuperview(offset: 16)
        mapView.trailingToSuperview(offset: 16)
        mapView.height(220)

        lblDescription.topToBottom(of: mapView, offset: 24)
        lblDescription.leadingToSuperview(offset: 16)
        lblDescription.trailingToSuperview(offset: 16)
        


        

    }
  
}

#if DEBUG
import SwiftUI
import MapKit

@available(iOS 13, *)
struct DetailScrollVC_Preview: PreviewProvider {
    static var previews: some View{
         
        DetailScrollVC().showPreview()
    }
}
#endif
