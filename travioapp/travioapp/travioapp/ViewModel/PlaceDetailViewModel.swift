//
//  DetailViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 10.11.2023.
//

import Foundation
import Alamofire

class PlaceDetailViewModel{
    
    var checkStatus: ((String) -> Void)?
    
    var dataTransferClosure: (([Image]) -> Void)?
    
    
    func getDataAllPlacesMap(placeId:String){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllGallerybyPlaceID(id: placeId), callback: { (result:Result<APIResponse,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosure!(obj.data.images)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    

    func postAVisit(request: PostAVisit){
        
        let param = ["place_id": request.placeId, "visited_at": request.visitedAt]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .postAVisit(param: param), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(let obj):
                print(obj.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func deleteAVisitByPlaceId(placeId: String){
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .deleteAVisitByPlaceID(id: placeId), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(let obj):
                print(obj.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func checkVisitByPlaceID(placeId: String){
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .checkVisitByPlaceID(id: placeId), callback: { (result:Result<BaseResponse,Error>) in
            switch result {
            case .success(let obj):
                print(obj.status)
                self.checkStatus?(obj.status!)
            case .failure(let failure):
                print(failure.localizedDescription)
                self.checkStatus?("")
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
