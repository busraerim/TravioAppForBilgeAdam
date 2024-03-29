//
//  SettingsView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 1.11.2023.
//

import UIKit
import Kingfisher


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SettingsViewC_Preview: PreviewProvider {
    static var previews: some View{
        
        SettingsView().showPreview()
    }
}
#endif

protocol SettingsViewProtocol:AnyObject{
    func saveButtonTapped()
}

class SettingsView: UIViewController {

    var profile:ProfileResponse?

    let cellModelArray = SettingsData.cellModelArray
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeSettingsLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        
        collection.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.identifier)
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
        view.layer.cornerRadius = 60
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .contentcolor
        return view
    }()
    
    private lazy var profileImage:UIImageView = {
        let profileImage = UIImageView()
        profileImage.layer.cornerRadius = 60
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
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
        lbl.font = CustomFont.header2.font
        lbl.text = "Settings"
        lbl.textAlignment = .center
        return lbl
    }()
        
    private lazy var lblProfileName:UILabel = {
        var lbl = UILabel()
        lbl.textColor = .black
        lbl.font = CustomFont.header5.font
        lbl.text = "Bruce Wills"
        lbl.textAlignment = .center
        return lbl
    }()
    
    @objc func buttonEditProfileTapped(){
        let vc = EditProfileVC()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    lazy var viewModel:EditProfileViewModel = {
        return EditProfileViewModel()
    }()
    
    
    @objc func buttonLogOutTapped() {
        AuthManager.shared.deleteToken(accountIdentifier: "access-token")

        let vc = LoginVc()
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.isNavigationBarHidden = true

        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func updateUI(with profile:ProfileResponse){
        lblProfileName.text = profile.fullName
        let url = URL(string: profile.ppUrl)
        let placeholderImage = UIImage(systemName: "person.crop.circle")
        profileImage.kf.setImage(with: url, placeholder: placeholderImage)
    }

    func getDataFromApi() {
        
        viewModel.dataTransferClosure = { [weak self] profile in
            self?.updateUI(with: profile)
        }
        
        viewModel.getProfileInfo()
        
        viewModel.updateLoadingState = { [weak self] in
            guard let self = self else { return }
            if self.viewModel.isLoading {
                self.showActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
        setupViews()
        
        showActivityIndicator()
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.hideActivityIndicator()
        }
        
    }

    private func setupViews(){
        self.view.backgroundColor = .background
        self.view.addSubviews(settingsItemView, lblTitle, buttonLogOut)
        settingsItemView.addSubviews(profileImage, lblProfileName, buttonEditProfile, collectionView)
       navigationController?.navigationBar.isTranslucent = true
       let logOutBarButton = UIBarButtonItem(customView: buttonLogOut)
       self.navigationItem.rightBarButtonItem = logOutBarButton
    
        let navigationBarTitle = UIBarButtonItem(customView: lblTitle)
        self.navigationItem.leftBarButtonItem = navigationBarTitle
        setupLayout()
    }
    
    private func setupLayout(){
        
        
        settingsItemView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })

        profileImage.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.width.equalTo(120)
            make.height.equalTo(120)
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
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(buttonEditProfile.snp.bottom).offset(12)
            make.bottom.equalToSuperview()

        })
    
        
    }
    

}


extension SettingsView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellType = SettingsCellType(rawValue: indexPath.item) else { return }
        
        let viewController: UIViewController
        
        switch cellType {
        case .securitySettings:
            viewController = SecuritySettingsView()
        case .appDefaults:
            // viewController = AppDefaultVC()
            // Implement AppDefaultVC as needed
            return
        case .myAddedPlaces:
            viewController = MyAddedPlacesVC()
        case .helpAndSupport:
            viewController = HelpAndSupportVC()
        case .about:
            viewController = AboutVC()
        case .termsOfUse:
            viewController = TermOfUsesVC()
        }
        
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension SettingsView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCell.identifier, for: indexPath) as! SettingsCell
        
        let data = cellModelArray[indexPath.item]
        cell.configure(data: data)
        
        
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
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top:24, leading: 0, bottom: 20, trailing: 0)
        layoutSection.interGroupSpacing = 8
        
        return layoutSection
    }
}

extension SettingsView:SettingsViewProtocol {
    func saveButtonTapped() {
        viewModel.dataTransferClosure = { [weak self] profile in
            self?.updateUI(with: profile)
        }
        
        viewModel.getProfileInfo()
    }
    
    
}
