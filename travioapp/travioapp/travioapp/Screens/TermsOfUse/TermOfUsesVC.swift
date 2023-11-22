//
//  WebViewController.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 21.11.2023.
//

import UIKit
import WebKit
import SnapKit

class TermOfUsesVC: UIViewController {
    
    private lazy var backView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 60
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Terms of Use"
        lbl.font = CustomFont.header2.font
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var backButton:UIButton = {
        let btn = UIButton()
        btn.setImage(.backWard, for: .normal)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var webView:WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        let backButtonBar = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar
        self.navigationItem.titleView = lblTitle
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlString = "https://api.iosclass.live/terms"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func setupViews(){
        self.view.addSubviews(lblTitle, backView)
        backView.addSubviews(webView)
        view.backgroundColor = .background
        
        setupLayout()
        
    }
    
    private func setupLayout(){
        
        backView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        lblTitle.snp.makeConstraints({ make in
            make.width.equalTo(250)
        })
        
        webView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension TermOfUsesVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let backgroundColorCode = "document.body.style.backgroundColor = '#FFFFFF';"
        webView.evaluateJavaScript(backgroundColorCode)

        let jsCode = """
            var style = document.createElement('style');
            style.innerHTML = 'body { font-family: "Poppins", sans-serif; padding-top: 24px; }';
            document.head.appendChild(style);
        """
        webView.evaluateJavaScript(jsCode)

        let h1Styles = """
            var h1Elements = document.querySelectorAll('h1');
            for (var i = 0; i < h1Elements.length; i++) {
                h1Elements[i].style.fontFamily = 'Poppins-Bold, sans-serif';
                h1Elements[i].style.fontSize = '28px';
                h1Elements[i].style.color = 'black';
            }
        """
        webView.evaluateJavaScript(h1Styles)

        let pStyles = """
            var pElements = document.querySelectorAll('p');
            for (var i = 0; i < pElements.length; i++) {
                pElements[i].style.fontFamily = 'Poppins-Regular, sans-serif';
                pElements[i].style.fontSize = '16px';
                pElements[i].style.color = 'black';
            }
        """
        webView.evaluateJavaScript(pStyles)
    }
}
