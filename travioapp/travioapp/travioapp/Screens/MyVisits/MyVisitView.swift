//
//  MyVisitsTableView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 27.10.2023.
//

import UIKit
import SnapKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MyVisitsView_Preview: PreviewProvider {
    static var previews: some View{
         
        MyVisitsView().showPreview()
    }
}
#endif

class MyVisitsView: UIViewController {

    var myVisitsPlace:[MyVisit] = []
    
    private lazy var lblTitle:UILabel = {
        var view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "Poppins-SemiBold", size: 36)
        view.text = "My Visits"
        return view
    }()
    
    private lazy var itemView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var collectionView:UICollectionView = {
        let lay = makeCollectionViewLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lay)
       
        cv.register(MyVisitsCell.self, forCellWithReuseIdentifier: "cell")
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    

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
        networkingMyVisitPlaces()
 
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkingMyVisitPlaces()
    }

    func networkingMyVisitPlaces()->[MyVisit]{
        let viewModel = HomeViewModel()
              
        viewModel.dataTransferClosureForMyVisit = { [weak self] place in
            guard let this = self else { return }
            this.myVisitsPlace = place
            this.collectionView.reloadData()
        }
        
        viewModel.getDataMyVisitsPlaces()
        return myVisitsPlace
    }
    
    private func setupViews(){
        view.backgroundColor = .background
        self.view.addSubviews(lblTitle, itemView)
        itemView.addSubviews(collectionView)
        setupLayout()
    }

    private func setupLayout(){
        
        itemView.snp.makeConstraints({ make in
            make.height.equalToSuperview().multipliedBy(0.85)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        lblTitle.snp.makeConstraints({ make in
            make.top.equalTo(46)
            make.leading.equalTo(30)
        })
      
        collectionView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
    }
    
}


extension MyVisitsView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var place = myVisitsPlace[indexPath.row].place
        var placeId = place.id
        
        checkVisit(placeId: placeId, place: place)

    }
}

extension MyVisitsView:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))
    }
}


extension MyVisitsView:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myVisitsPlace.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyVisitsCell
        let object = myVisitsPlace[indexPath.row]
        cell.configure(object:object)
        
        return cell
    }
}


extension MyVisitsView {
    
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            
            return self?.makeListLayoutSection()
            
        }
        
    }
     
    func makeListLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.57))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [item] )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        // tabbar geldikten sonra bottom ver 
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top:30, leading: 16, bottom: 0, trailing: 16)
        layoutSection.interGroupSpacing = 16
        
        return layoutSection
    }
}
