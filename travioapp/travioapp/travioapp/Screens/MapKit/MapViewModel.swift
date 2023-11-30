//
//  MapViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 6.11.2023.
//

import Foundation
import Alamofire


class MapViewModel{
    
    
    var dataTransferClosure: (([PlaceItem]) -> Void)?
    
    let dispatchGroup = DispatchGroup()
    
    var showAlertResult: (((String, String)) -> Void)?
    
    
    func getDataAllPlacesMap(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getAllPlacesMap, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))
            }
        })
    }
    
}
    
    

