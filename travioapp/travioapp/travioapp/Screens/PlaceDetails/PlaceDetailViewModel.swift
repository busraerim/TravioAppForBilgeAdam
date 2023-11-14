//
//  PlaceDetailViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 14.11.2023.
//

import Foundation

class PlaceDetailViewModel{
    
    var checkStatus: ((String) -> Void)?

    func postAVisit(request: PostAVisit){
        
        let param = ["place_id": request.place_id, "visited_at": request.visited_at]
        
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
    
    
}
