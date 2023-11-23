//
//  AddNewPlaceViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//


import Foundation
import Alamofire


class AddNewPlaceViewModel{
    
    let dispatchGroup = DispatchGroup()
    
    var imageData:[String] = []
    
    var coverImage:String?
    
    var placeID:String?
    
    var profilePhoto:String?
    
    var profilePhotoClosure:((String)->Void)?
    
    var imageTransferClosure: ((String) -> Void)?
    
    var placeIdClosure: ((String) -> Void)?
    
    func postNewPlace(request:AddNewPlace){
        dispatchGroup.enter()
        let params = ["place": request.place, "title": request.title, "description": request.description, "cover_image_url": request.coverImageUrl, "latitude": request.latitude, "longitude": request.longitude] as [String : Any]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .postAPlace(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                self.placeID = success.message
//                self.placeIdClosure!(success.message!)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
            }
        })
    }
    

    func uploadImage(data:[Data]){
        dispatchGroup.enter()
        GenericNetworkingHelper.shared.uploadImage(urlRequest: .upload(imageData: data), responseType: UploadResponse.self, callback: { (result:Result<UploadResponse, Error>) in
            switch result {
            case .success(let success):
                self.imageData = success.urls
                self.coverImage = self.imageData[0]
                self.profilePhoto = self.imageData[0]
//                self.imageTransferClosure!(success.urls)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
            }
        })
    }
    
    func postAGallery(request:PostAGallery){
        let params = ["place_id": request.placeId, "image_url": request.imageUrl] as [String : Any]
        dispatchGroup.enter()
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .postAGallery(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(_): 
                self.dispatchGroup.leave()
                break
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
            }
        })
    }
    
    
    func addNewPlace(data:[Data], place: String, title:String, description:String, latitude:Double, longitude:Double){
        uploadImage(data: data)
        dispatchGroup.notify(queue: .main) {
            let param = AddNewPlace(place: place, title: title, description: description, coverImageUrl: self.coverImage!, latitude: latitude, longitude: longitude)
            self.postNewPlace(request: param)
            self.dispatchGroup.notify(queue: .main) {
                for index in 0..<self.imageData.count{
                    let params = PostAGallery(placeId: self.placeID!, imageUrl: self.imageData[index])
                    self.postAGallery(request: params )
                }
            }
        }
    }
    
    func chanceProfilePhoto(data:[Data]){
        uploadImage(data:data)
        dispatchGroup.notify(queue: .main) {
            self.profilePhotoClosure!(self.profilePhoto!)
        }
    }
    
}
