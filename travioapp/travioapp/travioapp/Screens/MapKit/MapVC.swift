//
//  
//  MapVC.swift
//  travioapp
//
//  Created by Büşra Erim on 6.11.2023.
//
//
import UIKit
import SnapKit
import MapKit
import CoreLocation
import TinyConstraints

class MapVC: UIViewController {
    
    var mapAllPlaces:[PlaceItem] = []
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.delegate = self
        return map
    }()
    
    
    func networkingGetDataAllPlacesMap()->[PlaceItem]{
        let viewModel = MapViewModel()
              
        viewModel.dataTransferClosure = { [weak self] place in
            guard let this = self else { return }
            this.mapAllPlaces = place
            this.collectionView.reloadData()
            
            let initialLocation = CLLocationCoordinate2D(latitude: this.mapAllPlaces[0].latitude, longitude: this.mapAllPlaces[0].longitude)
            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            this.mapView.setRegion(region, animated: true)

        }
        viewModel.getDataAllPlacesMap()
        return mapAllPlaces
    }
    
    func addingPin(latitude:Double, longitude:Double, title:String){
        let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        annotation.title = title
        //        annotation.title = title
        self.mapView.addAnnotation(annotation)
    }
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let coordinate = mapView.centerCoordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MapCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        return cv
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress))
        gestureRecognizer.minimumPressDuration = 2.0
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        networkingGetDataAllPlacesMap()
        setupViews()
       
    }

    func setupViews() {
        self.view.addSubviews(mapView)
        mapView.addSubviews(collectionView)
        setupLayout()
    }
    
    func setupLayout() {
        collectionView.backgroundColor = .clear

        collectionView.snp.makeConstraints({ snp in
            snp.top.equalToSuperview().offset(565)
            snp.bottom.equalToSuperview()
            snp.leading.equalToSuperview()
            snp.trailing.equalToSuperview()
            
        })
    }
  
}


extension MapVC {
    func makeCollectionViewLayout()->UICollectionViewLayout{
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.5))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item])
        
       
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.interGroupSpacing = 18
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        return layoutSection
    }

}

extension MapVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapAllPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  MapCollectionCell
        let object = mapAllPlaces[indexPath.row]
        cell.configure(object: object)
        self.addingPin(latitude: object.latitude, longitude: object.longitude, title: object.title)
        return cell
    }
    
}


extension MapVC:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is CustomAnnotation == false {
                return nil
            }
        
            let senderAnnotation = annotation as! CustomAnnotation

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation")

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: senderAnnotation, reuseIdentifier: "CustomAnnotation")
                annotationView!.canShowCallout = true
            }
        
            let pinImage = UIImage(named: "Group 11")
            
            annotationView!.image = pinImage
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            return annotationView
        }
}

extension MapVC:UIGestureRecognizerDelegate{
    
}






#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MapVC_Preview: PreviewProvider {
    static var previews: some View{
         
        MapVC().showPreview()
    }
}
#endif
