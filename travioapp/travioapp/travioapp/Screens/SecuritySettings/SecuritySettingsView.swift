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
    
    let passwordTitles = ["New Password", "New Password Confirm"]
    let privacyTitles = ["Camera", "Photo Library", "Location"]
    let headers = ["Change Password", "Privacy"]
    
    private lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "Security Settings"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 32)
        lbl.textColor = .white
        return lbl
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
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeSettingsLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        
        collection.register(ChangePasswordCell.self, forCellWithReuseIdentifier: ChangePasswordCell.identifier)
        collection.register(PrivacyCell.self, forCellWithReuseIdentifier: PrivacyCell.identifier)

        collection.register(SettingsHeaderCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SettingsHeaderCollectionReusableView.identifer)
        
        collection.dataSource = self
        collection.delegate = self

        return collection
    }()

    @objc private func saveButtonTapped(){
        print("saved")
    }
    
    @objc private func backButtonTapped(){

        navigationController?.popViewController(animated: true)
        print("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .background
        self.view.addSubviews(settingsItemView, backButton, lblTitle)
        settingsItemView.addSubviews(collectionView, saveButton)
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
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview()
        })
        
        saveButton.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
    }
    
}

extension SecuritySettingsView:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return passwordTitles.count
        } else {
            return privacyTitles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChangePasswordCell.identifier, for: indexPath) as!
            ChangePasswordCell
            
            let pass = passwordTitles[indexPath.item]

            cell.configure(data: pass)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrivacyCell.identifier, for: indexPath) as! PrivacyCell
            
            let privacy = privacyTitles[indexPath.item]
            
            cell.configure(data: privacy)
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.register(SettingsHeaderCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SettingsHeaderCollectionReusableView.identifer) as! SettingsHeaderCollectionReusableView
            
        header.configure()
        
        return header
        
    }
    
    
}

extension SecuritySettingsView:UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: 20)
//    }
}

extension SecuritySettingsView {
    
    func makeSettingsLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            if sectionIndex == 0 {
                return self?.passwordLayout()
            } else {
                return self?.privacyLayout()
            }
        }
    }
    
    func passwordLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.22))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem] )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 0, bottom: 40, trailing: 0)
        layoutSection.interGroupSpacing = 10
        
        return layoutSection
    }
    
    func privacyLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.22))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem] )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 0, bottom: 100, trailing: 0)
        layoutSection.interGroupSpacing = 10
        
        return layoutSection
    }
}
