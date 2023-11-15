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

    
    private lazy var customView:CustomView = {
        let view = CustomView()
        return view
    }()
    
    private lazy var backView:UIView = {
        let backView = UIView()
        backView.height(719)
        backView.width(390)
        backView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        return backView
    }()
    
    public lazy var labelTitle:UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "My Added Places"
        label.font = UIFont(name: "Poppins-SemiBold", size: 36)
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
    
    
    @objc func sortedButtonTapped(){
        if sortedButton.currentImage == .ztoA{
            myAddedPlacesSetting.sort { $0.title ?? "" < $1.title ?? "" }
            sortedButton.setImage(.atoZ, for: .normal)
            collectionView.reloadData()

        }else{
            myAddedPlacesSetting.sort { $0.title ?? "" > $1.title ?? "" }
            sortedButton.setImage(.ztoA, for: .normal)
            collectionView.reloadData()

        }
    }
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SeeAllCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func networkingGetDataMyAddedPlaces(){
        let viewModel = HomeViewModel()
              
        viewModel.dataTransferClosure = { [weak self] place in
            guard let this = self else { return }
            this.myAddedPlacesSetting = place
            this.collectionView.reloadData()
        }
        viewModel.getDataAllPlacesForUser()
        return
    }
    
    func checkVisit(placeId:String, place:PlaceItem){
    
      let vc = DetailScrollVC()
      let viewModel = PlaceDetailViewModel()

        
      viewModel.checkStatus = { [weak self] status in
          print("burası see allda \(status)")
          if status == "success" {
              vc.saveButton.setImage(.marked, for: .normal)
          }else{
              vc.saveButton.setImage(.notmarked, for: .normal)
          }
          vc.detailPlace = place
          self!.navigationController?.pushViewController(vc, animated: true)
      }
        
      viewModel.checkVisitByPlaceID(placeId: placeId )

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        networkingGetDataMyAddedPlaces()
//        print(dataPlaceSeeAll)
        setupViews()
    }
  
    func setupViews() {
        self.view.addSubviews(backView,labelTitle,backButton)
//        backView.addSubviews(customView)
        backView.addSubviews(collectionView, sortedButton)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
        
//        let leftButtonImage = UIImage(named:"backWard")
//        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
//        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        self.navigationItem.titleView = labelTitle
        setupLayout()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLayout() {
        backView.topToSuperview(offset:125)
        backView.edgesToSuperview(excluding: .top)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)
        
        backButton.topToSuperview(offset:60)
        backButton.leadingToSuperview(offset:24)
        
        labelTitle.top(to: backButton, offset: -15)
        labelTitle.leadingToTrailing(of: backButton, offset: 25)

        sortedButton.topToSuperview(offset:24)
        sortedButton.trailingToSuperview(offset: 24)
        
        collectionView.backgroundColor = .clear
        collectionView.edgesToSuperview()
        
    }
  
}

extension MyAddedPlacesVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let place = myAddedPlacesSetting[indexPath.row]
        self.checkVisit(placeId: place.id, place: place)
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
