//
//  EditProfileVC.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 2.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

class EditProfileVC: UIViewController {
    
    weak var delegate:SettingsViewProtocol?

    var profile:ProfileResponse?
    
    var selectedImage:UIImage?
    
    var profileImage:[Data] = []
    
    var profilePhoto:String =  ""
    
    var oldPP:String = ""
    
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
        iv.layer.cornerRadius = 60
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var changePhotoButton:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Change Photo", for: .normal)
        btn.setTitleColor(.seablue, for: .normal)
        btn.addTarget(self, action: #selector(changePhotoButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var profileRoleView:EditProfileCustomView = {
        let view = EditProfileCustomView()
        view.label.text = "Admin"
        view.icon.image = .userRoleIcon
        return view
    }()
    
    private lazy var profileCreatedTimeView:EditProfileCustomView = {
        let view = EditProfileCustomView()
        view.label.text = "3 Kasım 2023"
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
    
    lazy var viewModel:EditProfileViewModel = {
        return EditProfileViewModel()
    }()
    
    lazy var uploadViewModel:AddNewPlaceViewModel = {
        return AddNewPlaceViewModel()
    }()
    
    
    func updateUI(with profile: ProfileResponse) {
        lblProfileName.text = profile.full_name

        profileRoleView.label.text = profile.role
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        guard let date = df.date(from: profile.created_at) else { return }

        let outdf = DateFormatter()
        outdf.dateFormat = "d MMMM yyyy"
        outdf.locale = Locale(identifier: "tr_TR")
        let formattedDate = outdf.string(from: date)
        profileCreatedTimeView.label.text = formattedDate
        
        emailInputView.txtPlaceholder.text = profile.email
        fullNameInputView.txtPlaceholder.text = profile.full_name
        let url = URL(string: profile.pp_url)
        profilePhotoImageView.kf.setImage(with: url)
    }
    
    @objc func saveButtonTapped(){
        
        if self.selectedImage == nil {
            saveInfos(profilPhoto: oldPP)

        }else{
            uploadImage()
        }

        
    }
    
    @objc func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func changePhotoButtonTapped(){
        openGallery()
    }
    
    @objc func closeButtonTapped(){
        viewModel.getProfileInfo()
        delegate?.saveButtonTapped()
        self.dismiss(animated: true)
        
    }
    
    private func uploadImage(){
        uploadViewModel.imageTransferClosure = { [weak self] image in
            guard let this = self else { return }
            this.saveInfos(profilPhoto: image[0])
            }
        
         uploadViewModel.uploadImage(data: self.profileImage)
        
    }
    
    private func saveInfos(profilPhoto: String){
        
        
        guard let email = emailInputView.txtPlaceholder.text,
              let full_name = fullNameInputView.txtPlaceholder.text else {return}
        
        viewModel.changeProfileInfo(profile: EditProfileRequest(full_name: full_name, email: email, pp_url: profilPhoto))
        
        lblProfileName.text = full_name
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .background

        
        viewModel.getProfileInfo()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        viewModel.dataTransferClosure = { [weak self] profile in
            self?.updateUI(with: profile)
            self?.oldPP = profile.pp_url
        }
    }
    
    func setupViews(){
        self.view.addSubviews(lblTitle, closeButton, editProfileItemView)
        inputsStackView.addArrangedSubviews(fullNameInputView, emailInputView)
        horizontalStackView.addArrangedSubviews(profileCreatedTimeView, profileRoleView)
        editProfileItemView.addSubviews(profilePhotoImageView, changePhotoButton, lblProfileName, horizontalStackView, inputsStackView, saveButton)
        setupLayout()
    }
    
    func setupLayout(){
        
        lblTitle.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
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
            make.width.equalTo(120)
            make.height.equalTo(120)
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

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        guard let imageData = pickedImage.jpegData(compressionQuality: 1) else { return }
        self.profileImage.append(imageData)
        
        self.selectedImage = pickedImage
        
        profilePhotoImageView.image = pickedImage

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
