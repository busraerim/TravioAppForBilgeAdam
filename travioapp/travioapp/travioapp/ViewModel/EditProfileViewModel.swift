//
//  EditProfileViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

class EditProfileViewModel {
    
    var dataTransferClosure: ((ProfileResponse) -> Void)?
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (() -> ())?
    
    func getProfileInfo(){
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .me, callback: {(result:Result<ProfileResponse, Error>) in
            switch result {
            case .success(let profile):
                self.dataTransferClosure!(profile)
                print(profile)
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
    
    func changeProfileInfo(profile:EditProfileRequest){
        let params = ["full_name": profile.full_name, "email": profile.email, "pp_url": profile.pp_url]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .editProfile(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                self.alertMessage = "Profil başarıyla güncellenmiştir."
                print(success.message ?? "A")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
}
