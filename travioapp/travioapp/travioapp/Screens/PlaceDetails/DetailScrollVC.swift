//
//  
//  DetailScrollVC.swift
//  travioapp
//
//  Created by Büşra Erim on 9.11.2023.
//
//
import UIKit
import TinyConstraints
import MapKit


class DetailScrollVC: UIViewController {
    
    var detailPlace:PlaceItem?
    
    var getGallery:[Image] = []
    
    var images:[String] = []
    
    lazy var viewModel: DetailViewModel = {
        return DetailViewModel()
    }()

    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ScrollCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.isScrollEnabled = false
        return cv
    }()
    
    private lazy var scrollView:ScrollView = {
        let v = ScrollView()
        v.labelTitle.text = detailPlace?.place
        v.lblCreatedDate.text = detailPlace!.created_at
        v.lblAddedByWho.text = "added by @\(detailPlace!.creator)"
        v.lblDescription.text = detailPlace?.description
        let location = CLLocation(latitude: self.detailPlace!.latitude, longitude: self.detailPlace!.longitude)
        let zoomRadius: CLLocationDistance = 240
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: zoomRadius, longitudinalMeters: zoomRadius)
        v.mapView.setRegion(region, animated: true)
        return v
    }()
   
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.getAllGalery(placeId: detailPlace!.id)

    }
    
    public func getAllGalery(placeId:String){
        viewModel.dataTransferClosure = { [weak self] image in
            guard let this = self else { return }
            this.getGallery = image
            
            for index in 0..<this.getGallery.count{
                this.images.append(this.getGallery[index].image_url)
            }
            
            if this.images.count == 0{
                this.images.append("https://yekpar.com/writable/uploads/medias/files/istockphoto-1357365823-612x612.jpg")
            }
            
            print(this.images)
            
            this.setupViews()

        }
        viewModel.getDataAllPlacesMap(placeId: placeId)
    }
     

    func setupViews() {
        self.view.addSubviews(collectionView)
        self.view.addSubviews(scrollView)
        self.view.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        
        navigationController?.navigationBar.isTranslucent = true
        
        let leftButtonImage = UIImage(named:"backWard")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        self.navigationItem.leftBarButtonItem = leftBarButton
        setupLayout()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func setupLayout() {
        
        collectionView.topToSuperview()
        collectionView.height(230)
        collectionView.leadingToSuperview()
        collectionView.trailingToSuperview()
        collectionView.layoutIfNeeded()
        
        scrollView.topToBottom(of: collectionView)
        scrollView.bottomToSuperview()
        scrollView.leadingToSuperview()
        scrollView.trailingToSuperview()
    }
}

extension DetailScrollVC {
    func makeCollectionViewLayout()->UICollectionViewLayout{
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item])
        
       
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
//        layoutSection.interGroupSpacing = 18
        return layoutSection
    }

}

extension DetailScrollVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  ScrollCell
        let object = images[indexPath.row]
        cell.configure(object: object)
        return cell
    }
    
}

extension DetailScrollVC:UICollectionViewDelegate{
}





#if DEBUG
import SwiftUI
import MapKit

@available(iOS 13, *)
struct DetailScrollVC_Preview: PreviewProvider {
    static var previews: some View{
         
        DetailScrollVC().showPreview()
    }
}
#endif
