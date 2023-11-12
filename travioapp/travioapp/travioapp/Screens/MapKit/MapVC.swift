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

protocol GetData:AnyObject {
    func getDataFromApi()
}

class MapVC: UIViewController {
    
    var selectedPin: CustomAnnotation?

    var mapAllPlaces:[PlaceItem] = []
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: view.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.delegate = self
        return map
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MapCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func networkingGetDataAllPlacesMap()->[PlaceItem]{
        let viewModel = MapViewModel()
              
        viewModel.dataTransferClosure = { [weak self] place in
            guard let this = self else { return }
            this.mapAllPlaces = place
            this.collectionView.reloadData()
            this.addingPin(place: self!.mapAllPlaces)
            
            let initialLocation = CLLocationCoordinate2D(latitude: this.mapAllPlaces[0].latitude, longitude: this.mapAllPlaces[0].longitude)
            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            this.mapView.setRegion(region, animated: true)

        }
        viewModel.getDataAllPlacesMap()
        return mapAllPlaces
    }
    
    func addingPin(place: [PlaceItem]){
        for item in 0..<place.count{
            
            let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: place[item].latitude, longitude: place[item].longitude))
            annotation.title = place[item].title
            self.mapView.addAnnotation(annotation)
        }

    }
    
    
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let coordinate = mapView.centerCoordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        getCityCountry(gestureRecognizer: gestureRecognizer)
     }
    
    private func getCityCountry(gestureRecognizer: UILongPressGestureRecognizer){
        let vc = AddNewPlaceVC()
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let geocoder = CLGeocoder()

            vc.delegate = self
            vc.getCoordinate = {
                vc.lat = location.coordinate.latitude
                vc.long = location.coordinate.longitude
            }
            
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Reverse geocoding hatası: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first {
                    if let city = placemark.locality, let country = placemark.country {
                        let place = "\(city), \(country)"
                        vc.labelCountry.text = place
                        print("Şehir: \(city)")
                        print("Ülke: \(country)")
                    } else {
                        print("Şehir ve Ülke bilgisi bulunamadı.")
                    }
                } else {
                    print("Bilgi bulunamadı.")
                }
            }
        }
        self.present(vc, animated: true)
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress))
        gestureRecognizer.minimumPressDuration = 1.0
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        var allPlaces = networkingGetDataAllPlacesMap()
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

extension MapVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = CLLocation(latitude: mapAllPlaces[indexPath.row].latitude, longitude: mapAllPlaces[indexPath.row].longitude)
            let zoomRadius: CLLocationDistance = 400
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: zoomRadius, longitudinalMeters: zoomRadius)
            mapView.setRegion(region, animated: true)
        let vc = DetailScrollVC()  
        vc.detailPlace = mapAllPlaces[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomAnnotation {
            let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let zoomRadius: CLLocationDistance = 400
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: zoomRadius, longitudinalMeters: zoomRadius)
            let index = mapAllPlaces.firstIndex(where: { $0.latitude == annotation.coordinate.latitude && $0.longitude == annotation.coordinate.longitude })
            let indexPath = IndexPath(item: index!, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            mapView.setRegion(region, animated: true)
            
            }
        }
        
}

extension MapVC:UIGestureRecognizerDelegate{

}



extension MapVC:GetData{
    func getDataFromApi() {
        networkingGetDataAllPlacesMap()
    }
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
