//
//  DetailViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 10.11.2023.
//

import Foundation
import Alamofire

class PlaceDetailViewModel{

    
    var placeIdMyAdded:[String] = []
    var placeIdClosure: (([String])->Void)?
    
    var checkStatus: ((String) -> Void)?
    var dataTransferClosure: (([Image]) -> Void)?
    var showAlertResult: (((String, String)) -> Void)?

    func getAllGallerybyPlaceID(placeId:String){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllGallerybyPlaceID(id: placeId), callback: { (result:Result<APIResponse,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosure!(obj.data.images)
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))
            }
        })
    }
    

    func postAVisit(request: PostAVisit){
        
        let param = ["place_id": request.placeId, "visited_at": request.visitedAt]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .postAVisit(param: param), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(_):
                self.showAlertResult?((title:"Başarılı", message: "My Visits'e eklendi."))
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))
            }
        })
    }
    
    func getDataAllPlacesForUser(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllPlacesforUser, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                for index in 0..<place.count{
                    self.placeIdMyAdded.append(place[index].id)
                }
                self.placeIdClosure!(self.placeIdMyAdded)
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))
            }
        })
    }
    
    func deleteAVisitByPlaceId(placeId: String){
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .deleteAVisitByPlaceID(id: placeId), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(let obj):
                self.showAlertResult?((title:"Başarılı", message: "My Visits'ten kaldırıldı."))
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))
            }
        })
    }
    
    func checkVisitByPlaceID(placeId: String){
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .checkVisitByPlaceID(id: placeId), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(let obj):
                self.checkStatus?(obj.status!)
            case .failure(_):
                self.checkStatus?("")
            }
        })
    }
    
    func deleteAPlaceId(placeId: String){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .deleteAPlace(id: placeId), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(_):
                self.showAlertResult?((title:"Başarılı", message: "Silindi."))
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))
            }
        })
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let day = dayFormatter.string(from: date)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM"
            let month = monthFormatter.string(from: date)
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            let year = yearFormatter.string(from: date)
            
            let formattedDate = "\(day) \(month) \(year)"
            
            return formattedDate
        }
        
        return nil
    }

    
    
    
}
