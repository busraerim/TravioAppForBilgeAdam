    //
    //  scrollgit.swift
    //  BilgeAdamCalisma
    //
    //  Created by Büşra Erim on 9.11.2023.
    //

import Foundation
import UIKit
import MapKit
import TinyConstraints




final class ScrollView: UIView {

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        //    sv.backgroundColor = .red
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //      let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        //      view.backgroundColor = .blue
        return view
    }()

    public lazy var labelTitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font =  UIFont(name: "Poppins-SemiBold", size: 30)
        lbl.text = ""
//        lbl.backgroundColor = .link
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()
    
    public lazy var lblCreatedDate:UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
//        lbl.backgroundColor = .link
        lbl.numberOfLines = 0
        lbl.text =  ""
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()
    
    public lazy var lblAddedByWho:UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Regular", size: 10)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false

        return lbl
    }()
    
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()

    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        var latitude = 0.0
        var longitude = 0.0
        map.layer.cornerRadius = 16
        map.clipsToBounds = true
        return map
    }()



    public lazy var lblDescription:UILabel = {
       let lbl = UILabel()
       lbl.textColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
       lbl.font = UIFont(name: "Poppins-Regular", size: 12)
       lbl.text = ""
       lbl.numberOfLines = 0
       lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

       

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews() 
    }

    func setupViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        contentView.addSubview(lblDescription)
        stackView.addArrangedSubviews(labelTitle, lblCreatedDate, lblAddedByWho)
        contentView.addSubviews(mapView)

        setupLayout()
    }
     
    func setupLayout() {
        scrollView.edgesToSuperview()
        scrollView.layoutIfNeeded()
        
        
        stackView.topToSuperview(offset: 24)
        stackView.leadingToSuperview(offset: 24)
        stackView.trailingToSuperview(offset: 24)
        
        mapView.topToBottom(of: stackView, offset: 16)
        mapView.leadingToSuperview(offset: 16)
        mapView.trailingToSuperview(offset: 16)
        mapView.height(220)

        lblDescription.topToBottom(of: mapView, offset: 20)
        lblDescription.leadingToSuperview(offset: 20)
        lblDescription.trailingToSuperview(offset: 20)
        lblDescription.layoutIfNeeded()

        let heightConstraint = contentView.height(scrollView.frame.height + lblDescription.frame.height + 220 + stackView.frame.height)
        heightConstraint.priority = UILayoutPriority(250)
        
        contentView.edges(to: scrollView)
        contentView.width(to: scrollView)
    //        contentView.height(heightConstraint.constant)
        contentView.height(heightConstraint.constant)
        contentView.layoutIfNeeded()
        
    }

    }




    extension ScrollView:MKMapViewDelegate{
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