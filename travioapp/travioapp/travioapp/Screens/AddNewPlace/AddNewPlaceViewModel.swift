//
//  AddNewPlaceViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 7.11.2023.
//


import Foundation
import Alamofire


class AddNewPlaceViewModel{
    func postNewPlace(request:AddNewPlace){
        let params = ["place": request.place, "title": request.title, "description": request.description, "cover_image_url": request.cover_image_url, "latitude": request.latitude, "longitude": request.longitude] as [String : Any]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .createAPlace(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                print(success.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
}
