//
//  ViewController.swift
//  travioapp
//
//  Created by Büşra Erim on 15.10.2023.
//


import UIKit
import SnapKit
import TinyConstraints

class LoginVc: UIViewController {
    
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
        return email
    }()
    
    private lazy var passwordView:InputBox = {
        let password = InputBox()
        password.boxTitle = .label(label: "Password")
        password.boxPlaceholder = .placeholder(placeholder: "*************")
        //        password.txtPlaceholder.isSecureTextEntry = true
        return password
    }()
    
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
        account.font = UIFont(name: "Poppins-SemiBold", size: 14)
        return account
    }()
    
    private lazy var btnSignup:UIButton = {
        let signUp = UIButton()
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.black, for: .normal)
        signUp.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
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
        welcome.font = UIFont(name: "Poppins", size: 24)
        welcome.width(226)
        welcome.height(36)
        welcome.textAlignment = .center
        return welcome
    }()
    
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    @objc func btnLoginTapped(){
            let email = emailView.txtPlaceholder.text!
            let password = passwordView.txtPlaceholder.text!
            viewModel.loginControl(email: email, password: password)
    }
        
     func showAlert(title:String,message:String) {
        let btnRetry = UIAlertAction(title: "Yeniden Dene", style: .destructive)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btnRetry)
        self.present(alert, animated: true)
    }
        
        
    func initVM(){
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(title: "Giriş Başarısız.", message: message)
                }
            }
        }
    }
        
        
  
        
        
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.22, green: 0.68, blue: 0.66, alpha: 1.00)
        setupViews()
        initVM()
            
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

            
            emailView.width(342)
            stackView.topToBottom(of: lblWelcome, offset: 41)
            stackView.leadingToSuperview(offset: 24)
            stackView.trailingToSuperview(offset: 24)
            
            btnLogin.width(342)
            btnLogin.topToBottom(of: stackView, offset: 48)
            btnLogin.centerX(to: stackView)
            
//            stackSignup.topToBottom(of: btnLogin, offset:141)
            stackSignup.bottomToSuperview(offset: -21)
            stackSignup.centerX(to: stackView)
            
            
            lblWelcome.topToSuperview(offset: 40)
            lblWelcome.centerX(to: stackView)
            
//            travioImage.width(149)
//            travioImage.height(178)
            travioImage.topToSuperview(offset: 44)
            travioImage.horizontalToSuperview(insets: .left(120) + .right(121))
            
            backView.layoutIfNeeded()
            backView.roundCorners(corners: .topLeft, radius: 80)
            
            
        }
        
    }


//
//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct LoginVc_Preview: PreviewProvider {
//    static var previews: some View{
//         
//        LoginVc().showPreview()
//    }
//}
//#endif
//
