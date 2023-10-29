
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
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cv.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
    }

    func setupViews() {
        self.view.addSubviews(backView,travioLogoImage,travioImage,collectionView)
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
        
//        collectionView.backgroundColor = .green
        collectionView.topToSuperview(offset: 150)
        collectionView.bottomToSuperview()
        collectionView.leadingToSuperview(offset: 10)
        collectionView.trailingToSuperview(offset: 10)
    }
  
}

extension HomeUIVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: collectionView.frame.width - 0, height: 80)
    }
}


extension HomeUIVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
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
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
    let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item])
    
    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
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
