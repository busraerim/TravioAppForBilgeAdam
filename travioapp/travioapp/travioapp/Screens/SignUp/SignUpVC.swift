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
        view.font = UIFont(name: "Poppins-SemiBold", size: 36)
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
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        return button
    }()
    
    //back button??
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
    
    func showAlert(buttonTitle:String, title:String, message:String){
        let btnRetry = UIAlertAction(title: buttonTitle, style: .default)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btnRetry)
        self.present(alert, animated: true)
    }
    
    func initVM(){
        viewModel.showErrorAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.errorAlertMessage {
                    self?.showAlert(buttonTitle:"Yeniden Dene", title: "Hata", message: message)
                }
            }
        }
        viewModel.showSuccessAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.successAlertMessage {
                    self?.showAlert(buttonTitle:"Kapat", title: "Başarılı", message: message)
                }
            }
        }
    }
    
    
    @objc func updateSignUpButtonState() {
        guard let email = emailInputView.txtPlaceholder.text ,
              let username = usernameInputView.txtPlaceholder.text,
              let password = passwordInputView.txtPlaceholder.text,
              let passwordConfirm = passwordConfirmInputView.txtPlaceholder.text else { return }
        
        signUpButton.isEnabled = !email.isEmpty && !password.isEmpty && !username.isEmpty && !passwordConfirm.isEmpty
        signUpButton.backgroundColor = signUpButton.isEnabled ? UIColor(named: "background") : UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    @objc func signUpButtonTapped(){
        guard let email = emailInputView.txtPlaceholder.text,
              let password = passwordInputView.txtPlaceholder.text,
              let username = usernameInputView.txtPlaceholder.text,
              let passwordConfirm = passwordConfirmInputView.txtPlaceholder.text else { return }

        viewModel.controlPassword(full_name: username, email: email, password: password, passwordConfirm: passwordConfirm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initVM()
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
        print("tapped")
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
        
        signUpButton.topToBottom(of: inputsStackView, offset: 202)
        signUpButton.horizontalToSuperview(insets: .right(24) + .left(24))
        
    }
    
}
