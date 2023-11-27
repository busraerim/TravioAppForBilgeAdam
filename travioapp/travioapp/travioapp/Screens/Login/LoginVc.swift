//
//  ViewController.swift
//  travioapp
//
//  Created by Büşra Erim on 15.10.2023.
//


import UIKit
import SnapKit
import TinyConstraints
import Photos


class LoginVc: UIViewController {
    
    var status = PHPhotoLibrary.authorizationStatus()
    
    
    func getPermission(){
        let vc = SecuritySettingsView()
        vc.checkPhotoLibraryPermission()
        vc.checkCameraPermission()
        vc.checkLocationPermission()
    }
    
    private lazy var travioImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "travio-logo 1")
        return image
    }()
    
    private lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        return backView
    }()
    
    private lazy var emailView:InputBox = {
        let email = InputBox()
        email.boxTitle = .label(label: "Email")
        email.boxPlaceholder = .placeholder(placeholder: "example@mail.com")
        email.txtPlaceholder.text = email.txtPlaceholder.text?.lowercased()
        email.showPasswordButton.isHidden = true
        return email
    }()
    
    private lazy var passwordView:InputBox = {
        let password = InputBox()
        password.boxTitle = .label(label: "Password")
        password.boxPlaceholder = .placeholder(placeholder: "*************")
        password.txtPlaceholder.isSecureTextEntry = true
        password.showPasswordButton.addTarget(self, action: #selector(buttonPressed), for: [.touchDown, .touchUpInside])
        return password
    }()
    
    @objc func buttonPressed(sender: InputBox, event: UIEvent) {
        if let touch = event.allTouches?.first {
            switch touch.phase {
            case .began:
               passwordView.txtPlaceholder.isSecureTextEntry = false
            case .ended:
                passwordView.txtPlaceholder.isSecureTextEntry = true
            default:
                break
            }
        }
    }
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        return stack
    }()
    
    private lazy var btnLogin:UIButton = {
        let login = UIButton()
        login.setTitle("Log in", for: .normal)
        login.layer.cornerRadius = 10
        login.height(54)
        login.backgroundColor = UIColor(red: 0.22, green: 0.68, blue: 0.66, alpha: 1.00)
        login.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)
        return login
    }()
    
    private lazy var lblAccount:UILabel = {
        let account = UILabel()
        account.text = "Don’t have any account?"
        account.textColor = .black
        account.numberOfLines = 1
        account.textAlignment = .center
        account.font = CustomFont.header6.font
        return account
    }()
    
    private lazy var btnSignup:UIButton = {
        let signUp = UIButton()
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.black, for: .normal)
        signUp.titleLabel?.font = CustomFont.header6.font
        signUp.addTarget(self, action: #selector(btnSignupTapped), for: .touchUpInside)
        return signUp
    }()
    
    private lazy var stackSignup:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        return stack
    }()
    
    private lazy var lblWelcome:UILabel = {
        let welcome = UILabel()
        welcome.text = "Welcome to Travio"
        welcome.textColor = .black
        welcome.font = CustomFont.subHeader1.font
        welcome.width(226)
        welcome.height(36)
        welcome.textAlignment = .center
        return welcome
    }()
    
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    @objc func btnLoginTapped() {
        showActivityIndicator()
        
        guard let email = emailView.txtPlaceholder.text,
              let password = passwordView.txtPlaceholder.text else {
            hideActivityIndicator()
            return
        }
        
        viewModel.loginControl(email: email, password: password)
        
//        viewModel.onSuccessLogin = { [weak self] in
//            let vc = TabbarUI()
//            self?.getPermission()
//            self?.hideActivityIndicator()
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }
//        
//        viewModel.onError = { [weak self] title, message in
//            self?.showAlert(title: title, message: message)
//        }
    }
    
    func showAlert(title: String, message: String) {
        let btnRetry = UIAlertAction(title: "Yeniden Dene", style: .destructive, handler: { _ in
            self.hideActivityIndicator()
            
        })
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btnRetry)
        self.present(alert, animated: true)
        
    }
    
    @objc func btnSignupTapped(){
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initVM() {
        viewModel.onError = { [weak self] title, message in
            DispatchQueue.main.async {
                self?.showAlert(title: title, message: message)
            }
        }
        viewModel.onSuccessLogin = { [weak self] in
            let vc = TabbarUI()
            self?.getPermission()
            self?.hideActivityIndicator()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
        initVM()
        
        showActivityIndicator()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.hideActivityIndicator()
        }
    }
    
    private func setupViews(){
        self.view.addSubviews(backView,btnLogin)
        
        backView.addSubviews(stackView,stackSignup,lblWelcome)
        stackView.addArrangedSubviews(emailView, passwordView)
        stackSignup.addArrangedSubviews(lblAccount,btnSignup)
        self.view.addSubview(travioImage)
        setupLayout()
    }
    
    private func setupLayout(){
        
        backView.snp.makeConstraints({ view in
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.7)
        })
        
        
        stackView.topToBottom(of: lblWelcome, offset: 41)
        stackView.leadingToSuperview(offset: 24)
        stackView.trailingToSuperview(offset: 24)
        
        btnLogin.topToBottom(of: stackView, offset: 48)
        btnLogin.leading(to: stackView)
        btnLogin.trailing(to: stackView)
        
        stackSignup.bottomToSuperview(offset: -21)
        stackSignup.centerX(to: stackView)
        
        
        lblWelcome.topToSuperview(offset: 40)
        lblWelcome.centerX(to: stackView)
        
        travioImage.topToSuperview(offset: 44)
        travioImage.horizontalToSuperview(insets: .left(120) + .right(121))
        
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)
        
        
    }
    
}



#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct LoginVc_Preview: PreviewProvider {
    static var previews: some View{
         
        LoginVc().showPreview()
    }
}
#endif

