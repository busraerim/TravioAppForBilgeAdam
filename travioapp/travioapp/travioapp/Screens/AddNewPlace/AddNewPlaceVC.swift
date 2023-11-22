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
    
    var imageDataArray:[Data] = []
    
    var getCoordinate:(()->())?
    
    var lat:Double = 0.0
    var long:Double = 0.0


    private lazy var txtDescription:UITextView = {
        let text = UITextView()
        text.font = CustomFont.title2.font
        return text
    }()
    
    public lazy var labelCountry:UILabel = {
        let label = UILabel()
        label.font = CustomFont.subHeader4.font
        return label
    }()
    
    private lazy var txtTitle:UITextField = {
        let text = UITextField()
        text.font = CustomFont.title2.font
        text.placeholder = "Please write a place name."
        return text
    }()

    private lazy var placeName:CustomNewPlaceView = {
        let view = CustomNewPlaceView()
        view.title.text = "Place Name"
        view.title.font = CustomFont.subHeader3.font
        return view
    }()
    
    private lazy var visitDescription:CustomNewPlaceView = {
        let view = CustomNewPlaceView()
        view.title.text = "Visit Description"
        view.title.font = CustomFont.subHeader3.font
        return view
    }()
    
    private lazy var countryCity:CustomNewPlaceView = {
        let view = CustomNewPlaceView()
        view.title.text = "Country City"
        view.title.font = CustomFont.subHeader3.font
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
        cv.delegate = self
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
    
    lazy var viewModel:AddNewPlaceViewModel = {
        return AddNewPlaceViewModel()
    }()
    
    func showAlertForEmptyText(title:String,message:String) {
       let btnRetry = UIAlertAction(title: "Try Again", style: .destructive)
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(btnRetry)
       self.present(alert, animated: true)
   }
    
    func showAlertForPermission(buttonTitle:String, title:String, message:String, style: UIAlertAction.Style = .default){
        let btnOK = UIAlertAction(title: buttonTitle, style: style, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(btnOK)
        self.present(alert, animated: true)
    }
    
    @objc func imagePickerControl(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func checkPhotoLibraryPermission(){
        let vc = SecuritySettingsView()
        
        if vc.status == .authorized {
            imagePickerControl(sourceType: .photoLibrary)
        }else{
            self.showAlertForPermission(buttonTitle: "OK", title: "Warning", message: "You have not granted access to the photo library. You can change these settings from the menu.")
        }
    }
        
    func checkCameraPermission(){
        let vc = SecuritySettingsView()

        if vc.cameraAuthorizationStatus == .authorized {
            imagePickerControl(sourceType: .camera)
        }else{
            self.showAlertForPermission(buttonTitle: "OK", title: "Warning", message: "You have not granted access to the camera. You can change these settings from the menu.")
        }
    }
    
    func showActionSheetCameraorPhotoLibrary() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let btnCamera = UIAlertAction(title: "Choose Camera", style: .destructive) { action in
            self.checkCameraPermission()
        }

        let btnPhotoLibrary = UIAlertAction(title: "Choose Photo Library", style: .destructive) { action in
            self.checkPhotoLibraryPermission()
        }

        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(btnCamera)
        actionSheet.addAction(btnPhotoLibrary)
        actionSheet.addAction(btnCancel)

        present(actionSheet, animated: true, completion: nil)
    }
    
    
    private func uploadImage(){
        let viewModel = AddNewPlaceViewModel()
        
        viewModel.imageTransferClosure = { [weak self] image in
            guard let this = self else { return }
            let coverImage = image[0]
            this.postAPlace(coverImage: coverImage , data: image)
        }
        viewModel.uploadImage(data: self.imageDataArray)
    }
    
    private func postAPlace(coverImage: String, data: [String]){
        let viewModel = AddNewPlaceViewModel()
        
        viewModel.placeIdClosure = { [weak self] placeId in
            guard let this = self else { return }
            let placeId = placeId
            this.postAGallery(placeId: placeId, data: data)
    }
        
        let place = labelCountry.text!
        let title = txtTitle.text!
        let description = txtDescription.text!
        let cover_image_url = coverImage
        let latitude = self.lat
        let longitude = self.long

        viewModel.postNewPlace(request:AddNewPlace(place: place, title: title, description: description, coverImageUrl: cover_image_url, latitude: latitude, longitude: longitude))

        self.dismiss(animated: true, completion: {self.delegate?.getDataFromApi()})
    }
    
    private func postAGallery(placeId: String, data:[String]){
        for index in 0..<data.count{
            AddNewPlaceViewModel().postAGallery(request: PostAGallery(placeId: placeId, imageUrl: data[index]))
        }
    }
    
    @objc func btnAddTapped(){
        
        if !txtTitle.text!.isEmpty && !txtDescription.text.isEmpty && self.imageDataArray.count >= 2 {
            getCoordinate!()
            self.uploadImage()
        }else{
            self.showAlertForEmptyText(title: "Hata", message: "İlgili alanları doldurduğunuzdan emin olunuz.")
        }
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

extension AddNewPlaceVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showActionSheetCameraorPhotoLibrary()
    }
}

extension AddNewPlaceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let cell = collectionView.cellForItem(at: selectedIndexPath) as? AddNewPlaceCell
                cell?.setImage(image: pickedImage)
                
                if let imageData = pickedImage.jpegData(compressionQuality: 1){
                    self.imageDataArray.append(imageData)
                    print(self.imageDataArray)
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
