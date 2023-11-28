//
//  SecuritySettingsViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 6.11.2023.
//

import Foundation

class SecuritySettingsViewModel {
    
    
    var onSuccess: ((String, String) -> Void)?
    var onError: ((String, String) -> Void)?
    
    func controlPassworRequirement(password:String, passwordConfirm:String) {

        guard password == passwordConfirm else {
            self.onError!("Hata", "Şifreler uyuşmuyor. Tekrar deneyiniz.")
            return
        }
        
        guard password.count >= 6  else {
            self.onError!("Hata", "Geçersiz şifre.")
            return
        }
        
        guard password != info.password else {
            self.onError!("Hata", "Yeni şifreniz güncel şifreniz ile aynı olamaz.")
            return
        }
        
        
        info.password = password
        
        let object = ChangePasswordRequest(newPassword: password)
        changePasswordMethod(request: object)
        
    }
    
    func changePasswordMethod(request:ChangePasswordRequest){
        let params = ["new_password": request.newPassword]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .changePassword(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                self.onSuccess!("Başarılı", "Şifre değiştirme başarılı.")
            case .failure(let failure):
                self.onError!("Hata", failure.localizedDescription)
            }
        })
    }
}
