//
//  CustomAnnotationView.swift
//  travioapp
//
//  Created by Büşra Erim on 6.11.2023.
//
//
//import MapKit
//
//class CustomAnnotationView: MKMarkerAnnotationView {
//    override var annotation: MKAnnotation? {
//        didSet { configure(for: annotation) }
//    }
//
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//
//        if let customAnnotation = annotation as? CustomAnnotation {
//            coordinate = customAnnotation.coordinate
//            glyphImage = UIImage(named: "Vector 1")
//        }
//            
//        configure(for: annotation)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(for annotation: MKAnnotation?) {
//        displayPriority = .required
//
//        // İşaretin koordinatını kullanmak için özel bir harita işareti (annotation) sınıfı (örneğin CustomAnnotation) kullanmanız gerekir.
//        // Özel harita işareti sınıfınız, MKAnnotation protokolünü uygulamalıdır ve koordinatı burada tanımlanmalıdır.
//    }
//}

