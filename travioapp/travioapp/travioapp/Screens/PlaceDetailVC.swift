//
//  PlaceDetailVC.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 30.10.2023.
//

import UIKit
import TinyConstraints

class PlaceDetailVC: UIViewController {

    private lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        return scroll
    }()
    
    private lazy var pageControlView:UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.backgroundColor = .gray
        page.backgroundStyle = .automatic
        return page
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let backButtonImage = UIImage(named: "backButtonBg")
        
        button.setImage(backButtonImage, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    private func setupViews(){
        view.addSubviews(scrollView, pageControlView)
        setupLayout()
    }
    
    private func setupLayout(){
        scrollView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
    }
    
    
    @objc func backButtonTapped(){
        
    }
    
}

extension PlaceDetailVC:UIScrollViewDelegate {
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

