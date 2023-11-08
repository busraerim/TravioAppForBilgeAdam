//
//  
//  AddNewPlaceVC.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//
//

import UIKit
import TinyConstraints

class AddNewPlaceVC: UIViewController {
    
    weak var delegate:GetData?
    
    var getCoordinate:(()->())?
    
    var lat:Double = 0.0
    var long:Double = 0.0


    
    private lazy var txtDescription:UITextView = {
        let text = UITextView()
        text.font = Fonts.poppinsRegular(size: 12).font
//        text.textContainer.maximumNumberOfLines = 0
        return text
    }()
    
    public lazy var labelCountry:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Light", size: 12)
        return label
    }()
    
    private lazy var txtTitle:UITextField = {
        let text = UITextField()
        text.font = Fonts.poppinsRegular(size: 12).font
        text.placeholder = "Please write a place name."
        return text
    }()

    private lazy var placeName:CustomNewPlaceView = {
        let view = CustomNewPlaceView()
        view.title.text = "Place Name"
        view.title.font = Fonts.poppinsMedium(size: 14).font
        return view
    }()
    
    private lazy var visitDescription:CustomNewPlaceView = {
        let view = CustomNewPlaceView()
        view.title.text = "Visit Description"
        view.title.font = Fonts.poppinsMedium(size: 14).font
        return view
    }()
    
    private lazy var countryCity:CustomNewPlaceView = {
        let view = CustomNewPlaceView()
        view.title.text = "Country City"
        view.title.font = Fonts.poppinsMedium(size: 14).font
        return view
    }()
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = makeCollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(AddNewPlaceCell.self, forCellWithReuseIdentifier: "cell")
        cv.dataSource = self
        return cv
    }()
    
    private lazy var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("Add Place", for: .normal)
        button.layer.cornerRadius = 10
        button.height(54)
        button.backgroundColor = UIColor(red: 0.22, green: 0.678, blue: 0.663, alpha: 1)

        button.addTarget(self, action: #selector(btnAddTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func btnAddTapped(){
        getCoordinate!()
        print("addnewplace bastı")
        let place = labelCountry.text!
        let title = txtTitle.text!
        let description = txtDescription.text!
        let cover_image_url = "https://isbh.tmgrup.com.tr/sbh/2016/04/28/650x344/1461845294399.jpg"
        let latitude = self.lat
        let longitude = self.long
        
        AddNewPlaceViewModel().postNewPlace(request:AddNewPlace(place: place, title: title, description: description, cover_image_url: cover_image_url, latitude: latitude, longitude: longitude))
        
        self.dismiss(animated: true, completion: {self.delegate?.getDataFromApi()})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
        setupViews()
       
    }
    
    
    func setupViews() {
        self.view.addSubviews(stackView, collectionView, addButton)
        collectionView.backgroundColor = .clear
        stackView.addArrangedSubviews(placeName, visitDescription, countryCity)
        visitDescription.addSubviews(txtDescription)
        placeName.addSubviews(txtTitle)
        countryCity.addSubviews(labelCountry)
        setupLayout()
    }
    
    func setupLayout() {   
        
        placeName.height(74)
        visitDescription.height(215)
        countryCity.height(74)
        
        stackView.topToSuperview(offset: 40)
        stackView.leadingToSuperview(offset:23)
        stackView.trailingToSuperview(offset:25)
        stackView.bottomToSuperview(offset: -325)
        
        
        collectionView.topToBottom(of: stackView, offset: 16)
        collectionView.leadingToSuperview()
        collectionView.bottomToSuperview(offset:-90)
        collectionView.trailingToSuperview()
        
        addButton.bottomToSuperview(offset:-24)
        addButton.leadingToSuperview(offset: 24)
        addButton.trailingToSuperview(offset: 24)
        addButton.topToBottom(of: collectionView, offset: 16)
        
    
        txtDescription.topToSuperview(offset:37)
        txtDescription.bottomToSuperview(offset:-16)
        txtDescription.leadingToSuperview(offset:16)
        txtDescription.trailingToSuperview(offset:16)

        txtTitle.topToSuperview(offset:16)
        txtTitle.bottomToSuperview(offset:-16)
        txtTitle.leadingToSuperview(offset:16)
        txtTitle.trailingToSuperview(offset:16)
        
        labelCountry.topToSuperview(offset:16)
        labelCountry.bottomToSuperview(offset:-16)
        labelCountry.leadingToSuperview(offset:16)
        labelCountry.trailingToSuperview(offset:16)
        
        
    }
  
}

extension AddNewPlaceVC {
    func makeCollectionViewLayout()->UICollectionViewLayout{
        
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            return self?.makeSliderLayoutSection()
        }
    }
    
    func makeSliderLayoutSection() -> NSCollectionLayoutSection {
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [item])
        
       
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.interGroupSpacing = 16
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 18)
        return layoutSection
    }

}

extension AddNewPlaceVC:UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  AddNewPlaceCell
        return cell
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AddNewPlaceVC_Preview: PreviewProvider {
    static var previews: some View{
         
        AddNewPlaceVC().showPreview()
    }
}
#endif
