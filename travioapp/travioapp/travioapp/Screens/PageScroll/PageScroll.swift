//
//  PageScroll.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//

import UIKit

class ScrollViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // UIScrollView'ü oluştur
            let scrollView = UIScrollView()
            scrollView.backgroundColor = .red
            scrollView.frame = view.bounds
            scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000) // İçerik boyutunu ayarla
            
            // UILabel oluştur ve içeriği ayarla
            let label = UILabel()
            label.text = "ScrollView Örneği\n" + String(repeating: "Bu bir örnek metin. ", count: 20)
            label.numberOfLines = 0 // Metni birden fazla satırda göster
            label.frame = CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 0)
            label.sizeToFit() // Etiketin boyutunu içeriğe göre otomatik ayarla
            
            // UILabel'i UIScrollView'e ekle
            scrollView.addSubview(label)
            
            // UIScrollView'ü görünüme ekle
            view.addSubview(scrollView)
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
