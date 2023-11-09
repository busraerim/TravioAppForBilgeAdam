//
//  PlaceDetailVC.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 30.10.2023.
//

import UIKit
import TinyConstraints
import MapKit

class PlaceDetailVC: UIViewController {
    
    // pin button
    var isMarked:Bool = true
    
    private var images: [UIImage] = [UIImage(named: "suleymaniye")!, UIImage(named: "ayasofya")!, UIImage(named: "suleymaniye")!, UIImage(named: "ayasofya")!, UIImage(named: "colleseum")!]
    
    private lazy var topView:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var bottomView:DetailBottomView = {
        let view = DetailBottomView()
        return view
    }()
        
    private lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.isDirectionalLockEnabled = true
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    private lazy var pageControl:UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = images.count
        page.currentPage = 0
        page.backgroundStyle = .prominent
        page.tintColor = .gray
        page.currentPageIndicatorTintColor = .black
        page.hidesForSinglePage = true
        return page
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "backButtonBg")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addVisitButton: UIButton = {
        let btn = UIButton()
        
        // Set the initial image based on isMarked
        let initialImage = isMarked ? UIImage(named: "mark") : UIImage(named: "notmarked")
        btn.setImage(initialImage, for: .normal)
        
        btn.addTarget(self, action: #selector(addVisitButtonTapped), for: .touchUpInside)
        
        return btn
    }()

    @objc func addVisitButtonTapped() {
        print("added")
        
        isMarked.toggle()
        
        let updatedImage = isMarked ? UIImage(named: "mark") : UIImage(named: "notmarked")
        addVisitButton.setImage(updatedImage, for: .normal)
    }
    
    
    @objc func backButtonTapped(){
        print("tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images.enumerated().forEach { index, image in
            let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
        }

        setupViews()
        
    }
    
    private func setupViews(){
        view.addSubviews(backButton, addVisitButton, topView, bottomView)
        topView.addSubviews(scrollView, pageControl)
        
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout(){
        
        topView.snp.makeConstraints({ make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(249)
        })
        
        bottomView.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(40)
        })
        
        addVisitButton.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(80)
        })
        
        pageControl.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
    }
    
    
    
}

extension PlaceDetailVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PlaceDetailVC_Preview: PreviewProvider {
    static var previews: some View{
        PlaceDetailVC().showPreview()
    }
}
#endif

