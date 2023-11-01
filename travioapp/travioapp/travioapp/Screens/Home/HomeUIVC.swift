
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
    
    
    private lazy var travioLogoImage:UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y:0, width: 56, height: 62))
        image.image = UIImage(named: "travio-logo 1")
        return image
    }()
    
    private lazy var travioImage:UIImageView = {
        let image = UIImageView(frame: CGRect(x: 84.11, y: 44.28, width: 102.44, height: 28.04))
        image.image = UIImage(named: "travio")
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
//        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
    }

    func setupViews() {
        self.view.addSubviews(backView,travioLogoImage,travioImage)
        backView.addSubview(collectionView)
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        setupLayout()
    }
    
    func setupLayout() {
        backView.topToSuperview(offset:125)
        backView.edgesToSuperview(excluding: .top)
        backView.layoutIfNeeded()
        backView.roundCorners(corners: .topLeft, radius: 80)

        travioLogoImage.height(62)
        travioLogoImage.width(66)
        travioLogoImage.leadingToSuperview(offset: 16)
        travioLogoImage.topToSuperview(offset: 50)
        travioImage.topToSuperview(offset: 60)
        travioImage.leadingToTrailing(of: travioLogoImage)
        
        collectionView.backgroundColor = .clear
        
        collectionView.edgesToSuperview()
    }
  
}

extension HomeUIVC:UICollectionViewDelegate{
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as! HeaderView
        header.label.text = denemearrayi[indexPath.section][0].title
//        header.label.text = "Deneme"
        return header
    }
}

extension HomeUIVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return denemearrayi.count
//        return homePlaces.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return homePlaces[section].count
        return denemearrayi[section][0].places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
        let object = denemearrayi[indexPath.section][0].places[indexPath.row]
//        let object = homePlaces[indexPath.section][indexPath.row]
//        cell.configure(object: object,title: "")
        cell.configure(object: object)
        return cell
    }
    
}

extension HomeUIVC {
    func makeCollectionViewLayout()->UICollectionViewLayout{
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            return makeSliderLayoutSection()
        }
    }
}

func makeSliderLayoutSection() -> NSCollectionLayoutSection {
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(45))
    let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    headerElement.pinToVisibleBounds = false
   
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    

    let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.5))
    let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item])
//    layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 45, leading: 18, bottom: 0, trailing: 18)
   
    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    layoutSection.orthogonalScrollingBehavior = .groupPaging
    layoutSection.boundarySupplementaryItems = [headerElement]
    layoutSection.interGroupSpacing = 18
    layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
    return layoutSection
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeUIVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HomeUIVC().showPreview()
    }
}
#endif
