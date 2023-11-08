//
//  SettingsView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SettingsViewC_Preview: PreviewProvider {
    static var previews: some View{
        
        SettingsView().showPreview()
    }
}
#endif

class SettingsView: UIViewController {

    var profile:ProfileResponse?

    let cellModelArray: [SettingsCellModel] = [
        SettingsCellModel(iconImage: "user-alt", label: "Security Settings"),
        SettingsCellModel(iconImage: "app-icon", label: "App Defaults"),
        SettingsCellModel(iconImage: "map-icon", label: "My Added Places"),
        SettingsCellModel(iconImage: "help-icon", label: "Help & Supports"),
        SettingsCellModel(iconImage: "about-icon", label: "About"),
        SettingsCellModel(iconImage: "term-icon", label: "Terms of Use")]
    
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeSettingsLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        
        collection.register(SettingsCell.self, forCellWithReuseIdentifier: "settings")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var settingsView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }()
    
    private lazy var settingsItemView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .contentcolor
        return view
    }()
    
    private lazy var profileImage:UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "profile-image")
        return profileImage
    }()
    
    private lazy var buttonLogOut:UIButton = {
        let btn = UIButton()
        btn.setImage(.logoutBtn, for: .normal)
        btn.addTarget(self, action: #selector(buttonLogOutTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonEditProfile: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.seablue, for: .normal)
        button.addTarget(self, action: #selector(buttonEditProfileTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var lblTitle:UILabel = {
        var lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 32)
        lbl.text = "Settings"
        lbl.textAlignment = .center
        return lbl
    }()
    
    func updateUI(with profile:ProfileResponse){
        lblProfileName.text = profile.full_name
//        profileImage.image = UIImage(named: profile.pp_url)
    }
    
    private lazy var lblProfileName:UILabel = {
        var lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
        lbl.text = "Bruce Wills"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblEditProfile:UILabel = {
        var lbl = UILabel()
        lbl.textColor = .seablue
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 12)
        lbl.text = "Settings"
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    @objc func buttonEditProfileTapped(){
        let vc = EditProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var viewModel:EditProfileViewModel = {
        return EditProfileViewModel()
    }()
    
    
    // logout bakılacak
    @objc func buttonLogOutTapped() {
        AuthManager.shared.deleteAccessToken()

        let vc = LoginVc() // Replace with the actual login view controller
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.isNavigationBarHidden = true

        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
 


        viewModel.dataTransferClosure = { [weak self] profile in
            self?.updateUI(with: profile)
        }
        
        viewModel.getProfileInfo()
        
        setupViews()
    }

    private func setupViews(){
        self.view.backgroundColor = .background
        self.view.addSubviews(settingsItemView, lblTitle, buttonLogOut)
        settingsItemView.addSubviews(profileImage, lblProfileName, buttonEditProfile, collectionView)
       
        setupLayout()
    }

    private func setupLayout(){
        
        
        settingsItemView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.85)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        lblTitle.snp.makeConstraints({ make in
            make.top.equalTo(55)
            make.leading.equalTo(30)
        })
        
        buttonLogOut.snp.makeConstraints({make in
            make.trailing.equalToSuperview().offset(-48)
            make.top.equalTo(lblTitle).offset(10)
        })
        
        
        profileImage.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        })
        
        lblProfileName.snp.makeConstraints({ make in
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        })
        
        buttonEditProfile.snp.makeConstraints({make in
            make.top.equalTo(lblProfileName.snp.bottom)
            make.centerX.equalToSuperview()
        })
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().offset(218)
        })
    
        
    }
    

}


extension SettingsView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = SecuritySettingsView()
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.item == 2 {
            let vc = MyAddedPlacesVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension SettingsView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settings", for: indexPath) as! SettingsCell
        
        let data = cellModelArray[indexPath.item]
        cell.configure(data: data)
        
        //case e göre sayfalara gitme
        
        return cell
    }
    
    
}

extension SettingsView {
    
    func makeSettingsLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            
            return self?.settingsLayout()
            
        }
        
    }
    
    func settingsLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.15))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem] )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top:24, leading: 0, bottom: 200, trailing: 0)
        layoutSection.interGroupSpacing = 8
        
        return layoutSection
    }
}
