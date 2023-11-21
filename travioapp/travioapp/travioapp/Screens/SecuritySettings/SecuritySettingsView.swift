//
//  SecuritySettingsView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SecuritySettingsView_Preview: PreviewProvider {
    static var previews: some View{
        
        SecuritySettingsView().showPreview()
    }
}
#endif


import UIKit
import SnapKit
import Photos
import AVFoundation
import CoreLocation
import TinyConstraints



class SecuritySettingsView: UIViewController {
    
    var status = PHPhotoLibrary.authorizationStatus()

    
    var cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

    
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
        lbl.toggleSwitch.addTarget(self, action: #selector(cameraToggleChanged), for: .valueChanged)
        return lbl
    }()
    
    @objc func cameraToggleChanged(_ sender: UISwitch) {
        if sender.isOn {
            checkCameraPermission()
        }else{
            showSettingsAlert(title:"Camera Access Denied" , message:"Please enable access to your camera in Settings.", toggle: cameraLabel.toggleSwitch)
        }
    }

    private lazy var photoLibraryLabel:PrivacyCell = {
        let lbl = PrivacyCell()
        lbl.labelText.text = "Photo Library"
        lbl.toggleSwitch.addTarget(self, action: #selector(photoLibraryToggleChanged), for: .valueChanged)
        return lbl
    }()
    
    @objc func photoLibraryToggleChanged(_ sender: UISwitch) {
        if sender.isOn {
            checkPhotoLibraryPermission()
        }else{
            showSettingsAlert(title: "Photo Library Access Denied", message: "Please enable access to your photo library in Settings.", toggle: photoLibraryLabel.toggleSwitch)
        }
    }
    
  
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        return manager
    }()

    private lazy var locationLabel:PrivacyCell = {
        let lbl = PrivacyCell()
        lbl.labelText.text = "Location"
        lbl.toggleSwitch.addTarget(self, action: #selector(locationToggleChanged), for: .valueChanged)
        return lbl
    }()
    
    @objc func locationToggleChanged(_ sender: UISwitch) {
          if sender.isOn {
              checkLocationPermission()
          } else {
              showSettingsAlert(title: "Location Access Denied", message: "Please enable access to your location in Settings.", toggle: locationLabel.toggleSwitch)
          }
    }
    
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
    
    private lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .contentcolor
        scroll.layer.cornerRadius = 80
        scroll.layer.maskedCorners = .layerMinXMinYCorner
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlStatusPermission()
        setupViews()
        initVM()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        self.view.addSubviews(settingsItemView, backButton, lblTitle, scrollView)
        scrollView.addSubviews(settingsItemView)
        passwordStackView.addArrangedSubviews(newPassword, newPasswordConfirm)
        privacyStackView.addArrangedSubviews(cameraLabel, photoLibraryLabel, locationLabel)
        settingsItemView.addSubviews(changePasswordTitle, passwordStackView, privacyTitle, privacyStackView, saveButton)
        navigationController?.navigationBar.isTranslucent = true
        let backButtonBar = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar
        self.navigationItem.titleView = lblTitle

        setupLayout()
    }
    
    private func setupLayout() {
        
        scrollView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.85)
        settingsItemView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.trailing.bottom.equalToSuperview()
        })
        scrollView.layoutIfNeeded()
        
        
        let heightConstraint = settingsItemView.height(scrollView.frame.height + changePasswordTitle.frame.height + passwordStackView.frame.height + privacyTitle.frame.height + privacyStackView.frame.height + saveButton.frame.height )
        heightConstraint.priority = UILayoutPriority(250)
        
        settingsItemView.edges(to: scrollView)
        settingsItemView.width(to: scrollView)
        settingsItemView.height(heightConstraint.constant)
        settingsItemView.layoutIfNeeded()
        
      
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
            make.top.equalTo(privacyStackView.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
    }
}
    


extension SecuritySettingsView:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            print("Location access is granted now")
            self.locationLabel.toggleSwitch.isOn = true
        } else {
            print("Location access is still not granted")
            self.locationLabel.toggleSwitch.isOn = false
        }
    }

}




extension SecuritySettingsView{
    func checkCameraPermission() {
        switch cameraAuthorizationStatus {
        case .authorized:
            print("Kamera erişimi zaten var")
            self.cameraLabel.toggleSwitch.isOn = true
        case .denied, .restricted:
            print("Kamera izni daha önce reddedilmiş veya sınırlı")
            showSettingsAlert(title: "Camera Access Denied", message: "Please enable access to your camera in Settings." , toggle: cameraLabel.toggleSwitch)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Kamera izni verildi")
                    self.cameraLabel.toggleSwitch.isOn = true
                } else {
                    print("Kamera izni reddedildi")
                    self.cameraLabel.toggleSwitch.isOn = false
                }
            }
        @unknown default:
            break
        }
    }
    
    
    func checkPhotoLibraryPermission() {
        switch status {
        case .authorized:
            print("erişim zaten var")
            self.photoLibraryLabel.toggleSwitch.isOn = true
            break
        case .denied, .restricted:
            print("daha önce reddedilmiş")
            showSettingsAlert(title: "Photo Library Access Denied", message: "Please enable access to your photo library in Settings.", toggle: photoLibraryLabel.toggleSwitch)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    print("izin var")
                } else {
                    print("izin yok")
                    self.photoLibraryLabel.toggleSwitch.isOn = false
                }
            }
        @unknown default:
            break
        }
    }
    
    
    
    func checkLocationPermission() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access is already granted")
            self.locationLabel.toggleSwitch.isOn = true
        case .denied, .restricted:
            print("Location access was denied or restricted")
            showSettingsAlert(title: "Location Access Denied", message: "Please enable access to your location in Settings.", toggle: locationLabel.toggleSwitch)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}


extension SecuritySettingsView{
    
    
    func showSettingsAlert(title:String, message:String, toggle: UISwitch ) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            if toggle.isOn == false {
                toggle.isOn = true
            }else{
                toggle.isOn = false
            }
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        })

        present(alert, animated: true, completion: nil)
    }
    
}

extension SecuritySettingsView{
    
    func controlStatusPermission(){
        if status == .authorized{
            self.photoLibraryLabel.toggleSwitch.isOn = true
        }else{
            self.photoLibraryLabel.toggleSwitch.isOn = false
        }
        
        if cameraAuthorizationStatus == .authorized{
            self.cameraLabel.toggleSwitch.isOn = true
        }else{
            self.cameraLabel.toggleSwitch.isOn = false
        }
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse{
            self.locationLabel.toggleSwitch.isOn = true
        }else{
            self.locationLabel.toggleSwitch.isOn = false
        }
    }
}

