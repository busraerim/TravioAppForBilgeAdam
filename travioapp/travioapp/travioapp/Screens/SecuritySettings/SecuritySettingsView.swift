//
//  SecuritySettingsView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit
import SnapKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SecuritySettingsView_Preview: PreviewProvider {
    static var previews: some View{
        
        SecuritySettingsView().showPreview()
    }
}
#endif

class SecuritySettingsView: UIViewController {
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Security Settings"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 32)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var changePasswordTitle = createLabel(title: "Change Password")
    private lazy var privacyTitle = createLabel(title: "Privacy")
    
    private lazy var newPassword:ChangePasswordCell = {
        let pass = ChangePasswordCell()
        pass.label.text = "New Password"
        return pass
    }()
    
    private lazy var newPasswordConfirm:ChangePasswordCell = {
        let pass = ChangePasswordCell()
        pass.label.text = "New Password Confirm"
        return pass
    }()
    
    private lazy var passwordStackView = {
        let sv = UIStackView()
        sv.spacing = 3
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var cameraLabel:PrivacyCell = {
        let lbl = PrivacyCell()
        lbl.labelText.text = "Camera"
        return lbl
    }()
    
    private lazy var photoLibraryLabel:PrivacyCell = {
        let lbl = PrivacyCell()
        lbl.labelText.text = "Photo Library"
        return lbl
    }()
    
    private lazy var locationLabel:PrivacyCell = {
        let lbl = PrivacyCell()
        lbl.labelText.text = "Location"
        return lbl
    }()
    

    private lazy var privacyStackView = {
        let sv = UIStackView()
        sv.spacing = 20
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    
    private lazy var backButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButtonImage"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsItemView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .contentcolor
        return view
    }()
    
    private lazy var saveButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.height(54)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .background
        btn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    func createLabel(title:String) -> UILabel {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
        lbl.textColor = .background
        return lbl
    }
    
    lazy var viewModel:SecuritySettingsViewModel = {
        return SecuritySettingsViewModel()
    }()
    
    @objc private func saveButtonTapped(){
        guard let password = newPassword.textfieldPassword.text,
              let passwordConfirm = newPasswordConfirm.textfieldPassword.text else { return }
        
        viewModel.controlPassworRequirement(password: password, passwordConfirm: passwordConfirm)
    }
    
    
    func showAlert(buttonTitle:String, title:String, message:String, style: UIAlertAction.Style = .default){
        let btnRetry = UIAlertAction(title: buttonTitle, style: style)
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btnRetry)
        self.present(alert, animated: true)
    }
    
    func initVM(){
        viewModel.showErrorAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.errorAlertMessage {
                    self?.showAlert(buttonTitle:"Yeniden Dene", title: "Hata", message: message, style: .destructive)
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
    
    @objc private func backButtonTapped(){
        navigationController?.popViewController(animated: true)
        print("bastı back")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initVM()
    }
    
    private func setupViews() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .background
        self.view.addSubviews(settingsItemView, backButton, lblTitle)
        passwordStackView.addArrangedSubviews(newPassword, newPasswordConfirm)
        privacyStackView.addArrangedSubviews(cameraLabel, photoLibraryLabel, locationLabel)
        settingsItemView.addSubviews(changePasswordTitle, passwordStackView, privacyTitle, privacyStackView, saveButton)
        setupLayout()
    }
    
    private func setupLayout() {
        backButton.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(30)
        })
        
        lblTitle.snp.makeConstraints({ make in
            make.leading.equalTo(backButton.snp.trailing).offset(30)
            make.top.equalTo(backButton).offset(-10)
        })
        
        settingsItemView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.85)
            make.leading.trailing.bottom.equalToSuperview()
        })
        
        changePasswordTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
        })
        
        passwordStackView.dropShadow()
        passwordStackView.snp.makeConstraints({ make in
            make.top.equalTo(changePasswordTitle).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
        })
        
        privacyTitle.snp.makeConstraints({ make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(30)
            make.leading.equalTo(changePasswordTitle.snp.leading)
        })
        
        privacyStackView.dropShadow()
        privacyStackView.snp.makeConstraints({ make in
            make.top.equalTo(privacyTitle).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        })
        
        saveButton.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
    }
}
    




