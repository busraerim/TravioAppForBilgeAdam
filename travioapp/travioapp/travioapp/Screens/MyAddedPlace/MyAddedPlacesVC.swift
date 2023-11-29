//
//  
//  MyAddedPlacesVC.swift
//  travioapp
//
//  Created by Büşra Erim on 8.11.2023.
//
//
import UIKit
import TinyConstraints


class MyAddedPlacesVC: UIViewController {
    
    var myAddedPlacesSetting:[PlaceItem] = []
   
    let viewModel = HomeViewModel()
    
    var placeIdMyAdded:[String] = []
        
    private lazy var customView:CustomView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var backView:UIView = {
        let backView = UIView()
        backView.height(719)
        backView.width(390)
        backView.backgroundColor = .contentcolor
        return backView
    }()
    
    public lazy var labelTitle:UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "My Added Places"
        label.font = CustomFont.header2.font
       return label
    }()
    
    private lazy var backButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButtonImage"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortedButton:UIButton = {
        let btn = UIButton()
        btn.setImage(.atoZ, for: .normal)
        btn.addTarget(self, action: #selector(sortedButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SeeAllCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        networkingGetDataMyAddedPlaces()
        setupViews()
    }
    
    @objc func sortedButtonTapped(){
        if sortedButton.currentImage == .ztoA{
            myAddedPlacesSetting.sort { $0.title < $1.title }
            sortedButton.setImage(.atoZ, for: .normal)
            collectionView.reloadData()

        }else{
            myAddedPlacesSetting.sort { $0.title > $1.title }
            sortedButton.setImage(.ztoA, for: .normal)
            collectionView.reloadData()

        }
    }
    
    func networkingGetDataMyAddedPlaces(){
        viewModel.getDataAllPlacesForUser()
        viewModel.myAddedSettingClosure = { place in
            self.myAddedPlacesSetting = place
            for index in 0..<place.count{
                self.placeIdMyAdded.append(place[index].id)
            }
            self.collectionView.reloadData()
        }
    }
  
    func setupViews() {
        self.view.addSubviews(backView,labelTitle,backButton)
        backView.addSubviews(collectionView, sortedButton)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        let backButtonBar = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar
        self.navigationItem.titleView = labelTitle

        setupLayout()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLayout() {
        backView.edgesToSuperview(excluding: .top)
        backView.heightToSuperview(multiplier: 0.82)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)

        sortedButton.topToSuperview(offset:24)
        sortedButton.trailingToSuperview(offset: 24)
        
        collectionView.backgroundColor = .clear
        collectionView.edgesToSuperview()
        
    }
  
}

extension MyAddedPlacesVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let place = myAddedPlacesSetting[indexPath.row]
        let placeDetailVC = PlaceDetailVC()
        placeDetailVC.detailPlace = place
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}

extension MyAddedPlacesVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAddedPlacesSetting.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SeeAllCollectionCell
        let object = myAddedPlacesSetting[indexPath.row]
        cell.configure(object: object)

        return cell
    }
    
}


extension MyAddedPlacesVC {
    func makeCollectionViewLayout()->UICollectionViewLayout{
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.125))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 70, leading: 24, bottom: 0, trailing: 22)
        layoutSection.interGroupSpacing = 16
        return layoutSection
    }

}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MyAddedPlacesVC_Preview: PreviewProvider {
    static var previews: some View{
         
        MyAddedPlacesVC().showPreview()
    }
}
#endif
