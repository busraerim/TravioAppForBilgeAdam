//
//  HomeViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 2.11.2023.
//

import Foundation
import Alamofire

class HomeViewModel{
    
    let dispatchGroup = DispatchGroup()


    var popularPlaceTuple: (title: String, places: [PlaceItem])?
    var newPlaceTuple: (title: String, places: [PlaceItem])?
    var myAddedTuple: (title: String, places: [PlaceItem])?
    var homeAllPlaces:HomeList = []
    
    var popularPlaceAll:[PlaceItem] = []
    var newPlaceAll:[PlaceItem] = []
    var myAddedPlaceAll:[PlaceItem] = []
    var seeAllPlaces:[[PlaceItem]] = []
   

    var homeDataClosure: ((HomeList)->Void)?

    var seeAllDataClosure: (([[PlaceItem]]) -> Void)?
    
    var myAddedSettingClosure: (([PlaceItem])->Void)?


    var dataTransferClosure: (([PlaceItem]) -> Void)?

    var dataTransferClosureForMyVisit: (([MyVisit]) -> Void)?
        
    
    
    func getDataPopularPlaces(){
        dispatchGroup.enter()
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopular, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                self.popularPlaceAll = place
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
            }
        })
    }

    
    func getDataPopularPlacesWithParam(limit: Int){
        dispatchGroup.enter()
        let parameters: Parameters = ["limit": "\(limit)"]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopularWith(params: parameters), callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                self.popularPlaceTuple = (title:"Popular Places", places: place)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
        }
            
    })
}
    
    
    
    func getDataNewPlacesWithParam(limit: Int){
        dispatchGroup.enter()
        var parameters: Parameters = ["limit": "\(limit)"]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopularWith(params: parameters), callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                self.newPlaceTuple = (title:"New Places", places: place)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
        }
    })
}
    
    func getDataNewPlaces(){
        dispatchGroup.enter()
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getNew, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                self.newPlaceAll = place
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
            }
        })
    }
    
    
    func getDataAllPlacesForUser(){
        dispatchGroup.enter()
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllPlacesforUser, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                self.myAddedPlaceAll = place
                self.myAddedSettingClosure?(obj.data.places)
                self.myAddedTuple = (title:"My Added Places", places: place)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.dispatchGroup.leave()
            }
        })
    }
    
    func getDataMyAddedPlaces(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllPlacesforUser, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                let place = obj.data.places
                self.myAddedPlaceAll = place
                self.myAddedSettingClosure!(place)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    func getAllData(){
        getDataPopularPlacesWithParam(limit: 10)
        getDataNewPlacesWithParam(limit: 10)
        getDataAllPlacesForUser()
        getDataPopularPlaces()
        getDataNewPlaces()
        dispatchGroup.notify(queue: .main) {
        self.homeAllPlaces.append(contentsOf: [self.popularPlaceTuple!, self.newPlaceTuple!, self.myAddedTuple!])
        self.seeAllPlaces.append(contentsOf: [self.popularPlaceAll, self.newPlaceAll, self.myAddedPlaceAll])
        self.homeDataClosure!(self.homeAllPlaces)
        self.seeAllDataClosure!(self.seeAllPlaces)
        }
    }
    
    
    func getDataMyVisitsPlaces(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllVisits, callback: { (result:Result<ApiResponse,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosureForMyVisit!(obj.data.visits)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
  
    
}
    
    
    
    
    
    
    
    



   
