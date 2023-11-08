//
//  PageScroll.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import UIKit

class ScrollViewController: UIViewController {
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.bounds.width * 3, height: view.bounds.height)
        scrollView.isPagingEnabled = true
        return scrollView
    }()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(scrollView)
        
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageView1.image = UIImage(named: "Vector-5")
        imageView1.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageView2.image = UIImage(named: "Vector-6")
        imageView2.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: CGRect(x: view.bounds.width * 2, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageView3.image = UIImage(named: "Vector-7")
        imageView3.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView3)
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ScrollViewController_Preview: PreviewProvider {
    static var previews: some View{
         
        ScrollViewController().showPreview()
    }
}
#endif
