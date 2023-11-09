//
//  DetailBottomView.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 8.11.2023.
//

import UIKit
import MapKit

class DetailBottomView: UIView {
    
    let latitude:Double = 0.0
    let longitude:Double = 0.0
//    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    let region = MKCoordinateRegion(center: coordinate, span: span)

    private lazy var lblPlace:UILabel = {
        let lbl = UILabel()
        lbl.text = "İstanbul"
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font =  UIFont(name: "Poppins-SemiBold", size: 30)
        return lbl
    }()
    
    private lazy var lblCreatedDate:UILabel = {
        let lbl = UILabel()
        lbl.text = "7 Kasım 2023"
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
        return lbl
    }()
    
    private lazy var lblAddedByWho:UILabel = {
        let lbl = UILabel()
        lbl.text = "added by @sabri"
        lbl.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 10)
        return lbl
    }()
    
    private lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 16
        map.layer.masksToBounds = true
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.showsUserLocation = true
        map.isScrollEnabled = true
        map.isZoomEnabled = true
        return map
    }()
    
    
    private lazy var lblDescription:UITextView = {
        let textView = UITextView()
        textView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.alley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker inalley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker in"
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont(name: "Poppins-Regular", size: 12)
        return textView
    }()
    
    func configure(data: PlaceItem){
        lblPlace.text = data.place
        lblCreatedDate.text = data.created_at
        lblDescription.text = data.description
        lblAddedByWho.text = "created by @\(data.creator)"
        
//        = data.latitude
//        = data.longitude
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        addSubviews(lblPlace, lblCreatedDate, lblAddedByWho, mapView, lblDescription)
        
        setupLayout()
    }
    
    private func setupLayout(){
        
        lblPlace.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(24)
            make.trailing.leading.equalToSuperview().inset(24)
        })
        
        lblCreatedDate.snp.makeConstraints({ make in
            make.top.equalTo(lblPlace.snp.bottom)
            make.trailing.leading.equalTo(lblPlace)
        })
        
        lblAddedByWho.snp.makeConstraints({ make in
            make.top.equalTo(lblCreatedDate.snp.bottom)
            make.leading.trailing.equalTo(lblCreatedDate)
        })
        
        mapView.snp.makeConstraints({ make in
            make.top.equalTo(lblAddedByWho.snp.bottom).offset(9)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(227)
        })
        
        lblDescription.snp.makeConstraints({ make in
            make.top.equalTo(mapView.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(mapView)
        })
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
