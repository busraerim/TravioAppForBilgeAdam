//
//  EditProfileVC.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 2.11.2023.
//

import UIKit
import SnapKit

class EditProfileVC: UIViewController {
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Edit Profile"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 32)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblProfileName:UILabel = {
        let lbl = UILabel()
        lbl.text = "Bruce Wills"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 24)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var editProfileItemView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .contentcolor
        return view
    }()
    
    private lazy var saveButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.height(54)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .background
        btn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var closeButton:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(.closeIcon, for: .normal)
        btn.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var profilePhotoImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = .profile
        return iv
    }()
    
    // buttona bakılacak..
    private lazy var changePhotoButton:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Change Photo", for: .normal)
        btn.setTitleColor(.seablue, for: .normal)
        btn.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var profileRoleView:EditProfileCustomView = {
        let view = EditProfileCustomView()
        view.textfield.placeholder = "admin role"
        view.icon.image = .userRoleIcon
        return view
    }()
    
    private lazy var profileCreatedTimeView:EditProfileCustomView = {
        let view = EditProfileCustomView()
        view.textfield.placeholder = "created at"
        view.icon.image = .userCreatedIcon
        return view
    }()
    
    private lazy var horizontalStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var emailInputView:InputBox = {
        let inputBox = InputBox()
        inputBox.boxTitle = .label(label: "Email")
        inputBox.boxPlaceholder = .placeholder(placeholder: "bilge_adam")
        inputBox.txtPlaceholder.textType = .emailAddress
        return inputBox
    }()
    
    private lazy var fullNameInputView:InputBox = {
        let inputBox = InputBox()
        inputBox.boxTitle = .label(label: "Full Name")
        inputBox.boxPlaceholder = .placeholder(placeholder: "bilge_adam")
        inputBox.txtPlaceholder.configureForNoAutocorrection()
        return inputBox
    }()
    
    private lazy var inputsStackView:UIStackView = {
        let sv = UIStackView()
        sv.spacing = 8
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    @objc func saveButtonTapped(){
        print("saved")
    }
    
    @objc func changePhotoButtonTapped(){
        print("photo changed")
    }
    
    // image = .close-icon, basınca go back to settings
    @objc func closeButtonTapped(){
        print("closed")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .background
        setupViews()
    }
    
    func setupViews(){
        self.view.addSubviews(lblTitle, closeButton, editProfileItemView)
        inputsStackView.addArrangedSubviews(emailInputView, fullNameInputView)
        horizontalStackView.addArrangedSubviews(profileCreatedTimeView, profileRoleView)
        editProfileItemView.addSubviews(profilePhotoImageView, changePhotoButton, lblProfileName, horizontalStackView, inputsStackView, saveButton)
        setupLayout()
    }
    
    func setupLayout(){
        
        //safearea??
        lblTitle.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-25)
            make.leading.equalToSuperview().offset(24)
        })
        
        closeButton.snp.makeConstraints({ make in
            make.centerY.equalTo(lblTitle)
            make.trailing.equalToSuperview().offset(-24)
        })
        
        editProfileItemView.snp.makeConstraints({ make in
            make.bottom.trailing.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.83)
        })
        
        profilePhotoImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        })
        
        changePhotoButton.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profilePhotoImageView.snp.bottom).offset(7)
        })
        
        lblProfileName.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(changePhotoButton.snp.bottom).offset(7)
        })
        
        horizontalStackView.snp.makeConstraints({ make in
            make.leading.trailing.equalTo(saveButton)
            make.top.equalTo(lblProfileName.snp.bottom).offset(21)
        })
        
        inputsStackView.snp.makeConstraints({ make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(19)
            make.leading.trailing.equalTo(saveButton)
        })
        
        saveButton.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-35)
            make.leading.trailing.equalToSuperview().inset(24)
        })
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct EditProfileVC_Preview: PreviewProvider {
    static var previews: some View{
        
        EditProfileVC().showPreview()
    }
}
#endif
