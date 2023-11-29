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



class PlaceDetailVC: UIViewController {
        
    
    let placeDetailViewModel = PlaceDetailViewModel()

    var detailPlace:PlaceItem?
    
    var getGallery:[Image] = []
    
    var images:[String] = []
    
//    lazy var viewModel: PlaceDetailViewModel = {
//        return PlaceDetailViewModel()
//    }()

    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PlaceDetailCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = images.count
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .black
        pc.backgroundStyle = .prominent
        return pc
    }()

    
    private lazy var scrollView:ScrollView = {
        let v = ScrollView()
        let date = placeDetailViewModel.formatDateString(detailPlace!.createdAt)
        v.textData(title: detailPlace!.title, createdDate: date!, creator: detailPlace!.creator, description: detailPlace!.description, place: detailPlace!)
        let location = CLLocation(latitude: self.detailPlace!.latitude, longitude: self.detailPlace!.longitude)
        let zoomRadius: CLLocationDistance = 240
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: zoomRadius, longitudinalMeters: zoomRadius)
        v.mapView.setRegion(region, animated: true)
        return v
    }()
    
    private lazy var saveButton:UIButton = {
       let button = UIButton()
        button.setImage(.notmarked, for: .normal)
        button.addTarget(self, action: #selector(buttonSaveTapped), for: .touchUpInside)
       return button
    }()
    
    @objc func buttonSaveTapped(){
                
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        let formattedDateString = dateFormatter.string(from: currentDate)
        
        if saveButton.currentImage == .notmarked{
            PlaceDetailViewModel().postAVisit(request: PostAVisit(placeId: detailPlace!.id, visitedAt: formattedDateString))
            saveButton.setImage(.marked, for: .normal)
        }else{
            PlaceDetailViewModel().deleteAVisitByPlaceId(placeId: detailPlace!.id)
            saveButton.setImage(.notmarked, for: .normal)
        }
        
    }
    
    func checkVisit(placeId:String){

        placeDetailViewModel.checkStatus = { [weak self] status in
          if status == "success" {
              self!.saveButton.setImage(.marked, for: .normal)
          }else{
              self!.saveButton.setImage(.notmarked, for: .normal)
          }
      }
        placeDetailViewModel.checkVisitByPlaceID(placeId: placeId )
    }

    
    public lazy var deleteButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.tintColor = UIColor(red: 0.22, green: 0.68, blue: 0.66, alpha: 1.00)
       return button
    }()
    
    func showAlertDelete(title:String,message:String) {
        let delete = UIAlertAction(title: "Sil", style: .default, handler: { action in
            self.placeDetailViewModel.deleteAPlaceId(placeId: self.detailPlace!.id)
            self.navigationController?.popViewController(animated: true)
        })
        let cancel = UIAlertAction(title: "İptal", style: .cancel)
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(delete)
       alert.addAction(cancel)

     self.present(alert, animated: true)
   }
        
    @objc func deleteButtonTapped(){
        showAlertDelete(title:"Uyarı", message: "Silmek istediğinize emin misiniz?")
    }

    func checkDelete(placeId:String){
        placeDetailViewModel.getDataAllPlacesForUser()
        initVM()
        placeDetailViewModel.placeIdClosure = { id in
            if id.contains(placeId){
                self.deleteButton.isHidden = false
            }else{
                self.deleteButton.isHidden = true
            }
        }
    }
    
    func initVM(){
        placeDetailViewModel.showAlertFailureClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.placeDetailViewModel.failAlertMessage {
                    self?.showAlertFailure(message: message)
                }
            }
        }
    }

    override func viewDidLoad() {
       super.viewDidLoad()
       self.getAllGalery(placeId: detailPlace!.id)
       checkVisit(placeId: detailPlace!.id)
       checkDelete(placeId: detailPlace!.id)
       initVM()
    }
    

 
    public func getAllGalery(placeId:String){
        placeDetailViewModel.dataTransferClosure = { [weak self] image in
            guard let this = self else { return }
            this.getGallery = image
            
            for index in 0..<this.getGallery.count{
                this.images.append(this.getGallery[index].imageUrl)
            }
            
            if this.images.count == 0{
                this.images.append("https://yekpar.com/writable/uploads/medias/files/istockphoto-1357365823-612x612.jpg")
            }
                        
            this.setupViews()

        }
        placeDetailViewModel.getAllGallerybyPlaceID(placeId: placeId)
        initVM()
    }
     

    func setupViews() {
        self.view.addSubviews(collectionView, saveButton, pageControl)
        self.view.addSubviews(scrollView)
        scrollView.addSubviews(deleteButton)
        self.view.backgroundColor = .contentcolor
        
        navigationController?.navigationBar.isTranslucent = true

        let saveBarButton = UIBarButtonItem(customView: saveButton)

        
        let leftButtonImage = UIImage(named:"backButtonFigma")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor(hex: "FFFFFF")
        

        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = saveBarButton

        setupLayout()
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLayout() {
        
        collectionView.topToSuperview()
        collectionView.height(280)
        collectionView.leadingToSuperview()
        collectionView.trailingToSuperview()
        collectionView.layoutIfNeeded()
        
        scrollView.topToBottom(of: collectionView)
        scrollView.bottomToSuperview()
        scrollView.leadingToSuperview()
        scrollView.trailingToSuperview()

        saveButton.topToSuperview(offset:50)
        saveButton.trailingToSuperview(offset:17)
        
        pageControl.centerXToSuperview()
        pageControl.bottomToTop(of: scrollView, offset: -10)
        
        deleteButton.topToSuperview(offset:30)
        deleteButton.trailingToSuperview(offset:20)
       
     
    }

}

extension PlaceDetailVC {
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
        return layoutSection
    }

}


extension PlaceDetailVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        if  let firstIndex = visibleIndexPaths.first{
            pageControl.currentPage = firstIndex.item
        }
    }
}

extension PlaceDetailVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  PlaceDetailCollectionCell
        let object = images[indexPath.row]
        cell.configure(object: object)
        return cell
    }
    
}




#if DEBUG
import SwiftUI
import MapKit

@available(iOS 13, *)
struct DetailScrollVC_Preview: PreviewProvider {
    static var previews: some View{
         
        PlaceDetailVC().showPreview()
    }
}
#endif
