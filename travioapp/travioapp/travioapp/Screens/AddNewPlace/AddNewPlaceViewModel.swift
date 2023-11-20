//
//  AddNewPlaceViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//


import Foundation
import Alamofire


class AddNewPlaceViewModel{
    
    var imageTransferClosure: (([String]) -> Void)?
    
    var placeIdClosure: ((String) -> Void)?

    func postNewPlace(request:AddNewPlace){
        let params = ["place": request.place, "title": request.title, "description": request.description, "cover_image_url": request.cover_image_url, "latitude": request.latitude, "longitude": request.longitude] as [String : Any]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .postAPlace(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                self.placeIdClosure!(success.message!)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    

    func uploadImage(data:[Data]){
        GenericNetworkingHelper.shared.uploadImage(urlRequest: .upload(imageData: data), responseType: UploadResponse.self, callback: { (result:Result<UploadResponse, Error>) in
            switch result {
            case .success(let success):
                self.imageTransferClosure!(success.urls)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func postAGallery(request:PostAGallery){
        let params = ["place_id": request.place_id, "image_url": request.image_url] as [String : Any]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .postAGallery(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success): 
                break
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    
}
