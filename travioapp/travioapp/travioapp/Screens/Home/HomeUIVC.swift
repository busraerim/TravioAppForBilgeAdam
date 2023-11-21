//
//  HomeUIVC.swift
//  travioapp
//
//  Created by Büşra Erim on 27.10.2023.
//
//

import UIKit
import TinyConstraints

class HomeUIVC: UIViewController {
    
    var homeAllPlaces:HomeList = []
    var seeAllPlaces:[[PlaceItem]] = []

    private lazy var travioLogoImage:UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y:0, width: 56, height: 62))
        image.image = UIImage(named: "Group 19")
        return image
    }()

    private lazy var backView:UIView = {
        let backView = UIView()
        backView.height(719)
        backView.width(390)
        backView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        return backView
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(HeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: HeaderView.reuseId)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        setupViews()
    }
    
    func getData(){
        let viewModel = HomeViewModel()
        viewModel.getAllData()
        viewModel.homeDataClosure = {place in
            self.homeAllPlaces = place
            self.collectionView.reloadData()
        }
        viewModel.seeAllDataClosure = { place in
            self.seeAllPlaces = place
        }
    }
    
    func checkVisit(placeId:String, place:PlaceItem){
      let vc = DetailScrollVC()
      let viewModel = PlaceDetailViewModel()

      viewModel.checkStatus = { [weak self] status in
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
   

    func setupViews() {
        self.view.addSubviews(backView,travioLogoImage)
        backView.addSubview(collectionView)
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        setupLayout()
    }
    
    func setupLayout() {
        backView.edgesToSuperview(excluding: .top)
        backView.heightToSuperview(multiplier: 0.82)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)

        travioLogoImage.leadingToSuperview(offset: 16)
        travioLogoImage.bottomToTop(of: backView, offset: -35)
        
        collectionView.backgroundColor = .clear
        collectionView.edgesToSuperview()
        
    }
  
}

extension HomeUIVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = homeAllPlaces[indexPath.section].places[indexPath.row]
        let placeId = place.id
        checkVisit(placeId: placeId, place: place)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as! HeaderView
     
        header.label.text = homeAllPlaces[indexPath.section].title
        
        header.dataClosure = {
            let vc = SeeAllVC()
            vc.labelTitle.text = self.homeAllPlaces[indexPath.section].title
            switch indexPath.section{
            case 0 :
                vc.dataPlaceSeeAll = self.seeAllPlaces[indexPath.section]
            case 1:
                vc.dataPlaceSeeAll = self.seeAllPlaces[indexPath.section]
            case 2:
                vc.dataPlaceSeeAll = self.homeAllPlaces[indexPath.section].places
            default:
                break
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return header
    }
    
    
}

extension HomeUIVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeAllPlaces.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeAllPlaces[section].places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
        let object = homeAllPlaces[indexPath.section].places[indexPath.row]
        cell.configure(object: object)
        return cell
    }
    
}

extension HomeUIVC {
    func makeCollectionViewLayout()->UICollectionViewLayout{
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerElement.pinToVisibleBounds = false
       
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.5))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item])
        
       
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.boundarySupplementaryItems = [headerElement]
        layoutSection.interGroupSpacing = 18
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        return layoutSection
    }

}



#if DEBUG
import SwiftUI
import CoreLocation

@available(iOS 13, *)
struct HomeUIVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HomeUIVC().showPreview()
    }
}
#endif

