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

    var dataTransferClosureForMyVisit: (([MyVisit]) -> Void)?

    
    
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
        var parameters: Parameters = ["limit": "\(limit)"]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopularWith(params: parameters), callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
        }
    })
}
    
    
    
    func getDataNewPlacesWithParam(limit: Int){

        var parameters: Parameters = ["limit": "\(limit)"]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopularWith(params: parameters), callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
        }
    })
}
    
    func getDataNewPlaces(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getNew, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    func getDataAllPlacesForUser(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllPlacesforUser, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
//                print(obj.data.places)
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    func getDataMyVisitsPlaces(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllVisits, callback: { (result:Result<ApiResponse,Error>) in
            switch result {
            case .success(let obj):
                print(obj.data.visits)
                self.dataTransferClosureForMyVisit!(obj.data.visits)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    
    
    
    
    
    
}
    
    
    
    
    
    
    
    



   
