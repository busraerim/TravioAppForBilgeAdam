//
//  HomeViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 2.11.2023.
//

import Foundation
import Alamofire

class HomeViewModel{

    
    var dataTransferClosure: (([PlaceItem]) -> Void)?

    
    func getDataPopularPlaces(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopular, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
//                print(obj.data.places)
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    

    
    func getDataPopularPlacesWithParam(limit: Int){
//        if limit>15{
//            limit = 10
//        }
//        
        var parameters: Parameters = ["limit": "\(limit)"]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopularWith(params: parameters), callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
//                print(obj.data.places)
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
        }
    })
}
    
    
    
    
    
    
    
    
    
}
    
    
    
    
    
    
    
    



   
