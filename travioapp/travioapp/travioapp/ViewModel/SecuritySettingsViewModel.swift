//
//  SecuritySettingsViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

class SecuritySettingsViewModel {
    
    var showErrorAlertClosure:(()->())?
    var showSuccessAlertClosure:(()->())?
    
    var errorAlertMessage: String? {
        didSet {
            self.showErrorAlertClosure?()
        }
    }
    
    var successAlertMessage: String? {
        didSet {
            self.showSuccessAlertClosure?()
        }
    }
    
    func controlPassworRequirement(password:String, passwordConfirm:String) {

        guard password == passwordConfirm else {
            self.errorAlertMessage = "Şifreler uyuşmuyor. Tekrar deneyiniz."
            return
        }
        
        guard password.count > 6  else {
            self.errorAlertMessage = "Geçersiz şifre"

            return
        }
        
        let object = ChangePasswordRequest(new_password: password)
        changePasswordMethod(request: object)
        
    }
    
    func changePasswordMethod(request:ChangePasswordRequest){
        let params = ["new_password": request.new_password]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .changePassword(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                self.successAlertMessage = "Şifre değiştirme başarılı."
                print(success.message ?? "AA")
            case .failure(let failure):
                self.errorAlertMessage = failure.localizedDescription
            }
        })
    }
}
