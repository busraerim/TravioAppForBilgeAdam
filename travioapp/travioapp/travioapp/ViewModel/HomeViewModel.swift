//
//  HomeViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 2.11.2023.
//

import Foundation

class HomeViewModel{

    
    var dataTransferClosure: (([PlaceItem]) -> Void)?

    
    func getData(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .getPopular, callback: { (result:Result<Place,Error>) in
            switch result {
            case .success(let obj):
                print(obj.data.places)
                self.dataTransferClosure!(obj.data.places)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
}
    
    
    
   
