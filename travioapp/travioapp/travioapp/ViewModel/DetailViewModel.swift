//
//  DetailViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 10.11.2023.
//

import Foundation
import Alamofire

class DetailViewModel{
    
    
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
}
