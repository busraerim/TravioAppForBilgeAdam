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
struct SignUpNonActiveVC_Preview: PreviewProvider {
    static var previews: some View{
         
        SignUpNonActiveVC().showPreview()
    }
}
#endif


class SignUpNonActiveVC: UIViewController {
    
    private lazy var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var lblTitle:UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-SemiBold", size: 36)
        // Line height: 54 pt
        view.text = "Sign Up"
        return view
    }()
    
    private lazy var usernameInputView = createInputBox(title: "Username", placeholder: "bilge_adam")
    
    private lazy var emailInputView = createInputBox(title: "Email", placeholder: "developer@bilgeadam.com")
    
    private lazy var passwordInputView = createInputBox(title: "Password", placeholder: "")
    
    private lazy var passwordConfirmInputView = createInputBox(title: "Password Confirm", placeholder: "")
    
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
    
    private func createInputBox(title:String, placeholder:String) -> InputBox {
        let input = InputBox()
        input.boxTitle = .label(label: title)
        input.boxPlaceholder = .placeholder(placeholder: placeholder)
        return input
    }
    
    var viewModel:LoginViewModel = {
        return LoginViewModel()
    }()
    
    @objc func signUpButtonTapped(){
        var email = emailInputView.boxPlaceholder.text
        var password = passwordInputView.boxPlaceholder.text
        var username = usernameInputView.boxPlaceholder.text
        var person = Register(username: username, email: email, password: password)
        
        viewModel.registerPerson(person: person)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(named: "background")
        view.addSubviews(backgroundView, lblTitle)
        inputsStackView.addArrangedSubviews(usernameInputView, emailInputView, passwordInputView, passwordConfirmInputView)
        backgroundView.addSubviews(inputsStackView, signUpButton)
        setupLayout()
    }
    
    private func setupLayout(){
        
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
        
        //202
        
    }
    
}
