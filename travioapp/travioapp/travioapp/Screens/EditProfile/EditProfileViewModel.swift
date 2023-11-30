//
//  EditProfileViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

class EditProfileViewModel {
    
    var dataTransferClosure: ((ProfileResponse) -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingState?()
        }
    }

    var updateLoadingState: (() -> ())?
    var showAlertResult: (((String, String)) -> Void)?

    func getProfileInfo(){
        isLoading = true
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .me, callback: {(result:Result<ProfileResponse, Error>) in
            self.isLoading = false
            switch result {
            case .success(let profile):
                self.dataTransferClosure?(profile)
            case .failure(let err):
                self.showAlertResult?((title:"Hata", message: err.localizedDescription))
            }
        })
    }
    
    func changeProfileInfo(profile:EditProfileRequest){
        isLoading = true
        
        let params = ["full_name": profile.fullName, "email": profile.email, "pp_url": profile.ppUrl]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .editProfile(param: params), callback: { (result:Result<BaseResponse, Error>) in
            self.isLoading = false
            switch result {
            case .success(_):
                self.showAlertResult?((title:"Başarılı", message: "Profil başarıyla güncellenmiştir."))
            case .failure(let failure):
                self.showAlertResult?((title:"Hata", message: failure.localizedDescription))

            }
        })
    }
    
}
