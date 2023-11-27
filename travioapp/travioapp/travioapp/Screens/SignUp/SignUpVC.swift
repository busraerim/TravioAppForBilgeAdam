//
//  SignUpNonActiveVC.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 25.10.2023.
//

import UIKit
import TinyConstraints

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SignUpVC_Preview: PreviewProvider {
    static var previews: some View{
        SignUpVC().showPreview()
    }
}
#endif


class SignUpVC: UIViewController {
    
    private lazy var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var lblTitle:UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = CustomFont.header1.font
        view.text = "Sign Up"
        return view
    }()
    
    private func createInputBox(title: String, placeholder: String) -> InputBox {
        let inputBox = InputBox()
        inputBox.boxTitle = .label(label: title)
        inputBox.boxPlaceholder = .placeholder(placeholder: placeholder)
        
        let textField = inputBox.txtPlaceholder
        textField.addTarget(self, action: #selector(updateSignUpButtonState), for: .editingChanged)
    
        return inputBox
    }
    
    //username ve email autocorrections vs..
    private lazy var usernameInputView:InputBox = createInputBox(title: "Username", placeholder: "bilge_adam")
    private lazy var emailInputView:InputBox = createInputBox(title: "Email", placeholder: "developer@bilgeadam.com")
    private lazy var passwordInputView:InputBox = createInputBox(title: "Password", placeholder: "")
    private lazy var passwordConfirmInputView:InputBox = createInputBox(title: "Password Confirm", placeholder: "")
    
    
    private lazy var inputsStackView:UIStackView = {
        let sv = UIStackView()
        sv.spacing = 24
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    
    private lazy var signUpButton:UIButton = {
        let button = UIButton()
        button.height(54)
        button.layer.cornerRadius = 10
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        if let backButtonImage = UIImage(named: "backButtonImage") {
            button.setImage(backButtonImage, for: .normal)
        }
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    var viewModel:SignUpViewModel = {
        return SignUpViewModel()
    }()
    

    func showAlert(alertTitle:String, style:UIAlertAction.Style, title: String, message: String, handler:(() -> Void)?) {
        let btnRetry = UIAlertAction(title: alertTitle, style: style, handler: { action in
            self.hideActivityIndicator()
            handler?()
        })
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btnRetry)
        self.present(alert, animated: true)
        
    }
    
    
    func initVM() {
        viewModel.onError = { [weak self] title, message in
            DispatchQueue.main.async {
                self?.showAlert(alertTitle: "Yeniden Dene", style: .destructive, title: title, message: message, handler: nil)
                self?.hideActivityIndicator()
            }
        }
        
        viewModel.onSuccess = { [weak self] title, message in
            DispatchQueue.main.async {
                self?.showAlert(alertTitle: "Tamam", style: .default, title: title, message: message, handler: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    
    @objc func updateSignUpButtonState() {
        guard let email = emailInputView.txtPlaceholder.text ,
              let username = usernameInputView.txtPlaceholder.text,
              let password = passwordInputView.txtPlaceholder.text,
              let passwordConfirm = passwordConfirmInputView.txtPlaceholder.text else { return }

        if !email.isEmpty && !password.isEmpty && !username.isEmpty && !passwordConfirm.isEmpty{
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .background
            signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        } 
    }
    
    @objc func signUpButtonTapped(){
        showActivityIndicator()
        guard let email = emailInputView.txtPlaceholder.text,
              let password = passwordInputView.txtPlaceholder.text,
              let username = usernameInputView.txtPlaceholder.text,
              let passwordConfirm = passwordConfirmInputView.txtPlaceholder.text else { return }
        
        viewModel.controlPassword(full_name: username, email: email, password: password, passwordConfirm: passwordConfirm)
        
    }
    
    private func showPassword(){
        self.usernameInputView.showPasswordButton.isHidden = true
        self.emailInputView.showPasswordButton.isHidden = true
        self.passwordInputView.txtPlaceholder.isSecureTextEntry = true
        self.passwordConfirmInputView.txtPlaceholder.isSecureTextEntry = true
        passwordInputView.showPasswordButton.addTarget(self, action: #selector(buttonPressed), for: [.touchDown, .touchUpInside])
        passwordConfirmInputView.showPasswordButton.addTarget(self, action: #selector(buttonPressed), for: [.touchDown, .touchUpInside])
    }
    
    @objc func buttonPressed(sender: InputBox, event: UIEvent) {
        if let touch = event.allTouches?.first {
            switch touch.phase {
            case .began:
               passwordInputView.txtPlaceholder.isSecureTextEntry = false
               passwordConfirmInputView.txtPlaceholder.isSecureTextEntry = false
            case .ended:
                passwordInputView.txtPlaceholder.isSecureTextEntry = true
                passwordConfirmInputView.txtPlaceholder.isSecureTextEntry = true
            default:
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.titleView = lblTitle
    
        
        showPassword()
        setupViews()
        initVM()
        
        showActivityIndicator()
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.hideActivityIndicator()
        }
    }
    
    private func setupViews(){
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "background")
        view.addSubviews(backButton, backgroundView, lblTitle)
        signUpButton.isHidden = false
        inputsStackView.addArrangedSubviews(usernameInputView, emailInputView, passwordInputView, passwordConfirmInputView)
        backgroundView.addSubviews(inputsStackView, signUpButton)
        setupLayout()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupLayout(){

        backButton.topToSuperview(offset: 60)
        backButton.leadingToSuperview(offset:34)
        
        lblTitle.topToSuperview(offset: 40)
        lblTitle.horizontalToSuperview(insets: .left(120) + .right(120))
     
        backgroundView.edgesToSuperview(excluding: .top)
        backgroundView.topToSuperview(offset: 124)
        backgroundView.layoutIfNeeded()
        backgroundView.roundCorners(corners: .topLeft, radius: 80)
        
        inputsStackView.horizontalToSuperview(insets: .left(24) + .right(24))
        inputsStackView.topToSuperview(offset: 72)
        
        signUpButton.bottomToSuperview(offset: -40)
        signUpButton.horizontalToSuperview(insets: .right(24) + .left(24))
        
    }
    
}


