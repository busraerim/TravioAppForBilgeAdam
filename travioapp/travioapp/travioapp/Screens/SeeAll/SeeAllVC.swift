//
//  
//  PlaceDetailsVC.swift
//  travioapp
//
//  Created by Büşra Erim on 31.10.2023.
//
//
import UIKit
import TinyConstraints

class SeeAllVC: UIViewController {
    
    var dataPlaceSeeAll:[PlaceItem] = []


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
        label.font = CustomFont.header1.font
       return label
    }()
    
    private lazy var buttonSorted:UIButton = {
        let button = UIButton()
        button.setImage(.atoZ, for: .normal)
        button.addTarget(self, action: #selector(buttonSortedTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SeeAllCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    @objc func buttonSortedTapped(){
        if buttonSorted.currentImage == .ztoA{
            dataPlaceSeeAll.sort { $0.title < $1.title }
            buttonSorted.setImage(.atoZ, for: .normal)
            collectionView.reloadData()
        }else{
            dataPlaceSeeAll.sort { $0.title > $1.title }
            buttonSorted.setImage(.ztoA, for: .normal)
            collectionView.reloadData()

        }
    }
    
    func checkVisit(placeId:String, place:PlaceItem){
        
        let placeDetailVC = PlaceDetailVC()
        
        let placeDetailViewModel = PlaceDetailViewModel()
        
        placeDetailViewModel.checkStatus = { [weak self] status in
          if status == "success" {
              placeDetailVC.saveButton.setImage(.marked, for: .normal)
          }else{
              placeDetailVC.saveButton.setImage(.notmarked, for: .normal)
          }
          placeDetailVC.detailPlace = place
          self!.navigationController?.pushViewController(placeDetailVC, animated: true)
      }
        placeDetailViewModel.checkVisitByPlaceID(placeId: placeId )

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dataPlaceSeeAll.sort { $0.title ?? "" < $1.title ?? "" }
        self.view.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)
        setupViews()
    }
  
    func setupViews() {
        self.view.addSubviews(backView,labelTitle)
        backView.addSubviews(collectionView,buttonSorted)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        self.navigationItem.leftBarButtonItem = leftBarButton
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
        
        labelTitle.topToSuperview(offset:46)
        labelTitle.leadingToSuperview(offset:24)

        collectionView.backgroundColor = .clear
        collectionView.edgesToSuperview()
        
        buttonSorted.topToSuperview(offset:24)
        buttonSorted.trailingToSuperview(offset: 24)
        
    }
  
}

extension SeeAllVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            buttonSorted.alpha = 0
        } else {
            buttonSorted.alpha = 1
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            UIView.animate(withDuration: 0.3) {
                self.buttonSorted.alpha = 1
            }
        }
    }
}

extension SeeAllVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkVisit(placeId: dataPlaceSeeAll[indexPath.row].id, place: dataPlaceSeeAll[indexPath.row])
    }
}

extension SeeAllVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPlaceSeeAll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SeeAllCollectionCell
        let object = dataPlaceSeeAll[indexPath.row]
        cell.configure(object: object)

        return cell
    }
    
}


extension SeeAllVC {
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
struct PlaceDetailsVC_Preview: PreviewProvider {
    static var previews: some View{
         
        SeeAllVC().showPreview()
    }
}
#endif
