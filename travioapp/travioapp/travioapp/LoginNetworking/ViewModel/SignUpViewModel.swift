//
//  SignUpViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 26.10.2023.
//

import Foundation
import Alamofire

class SignUpViewModel {
    
    var transferData: (()->())?
    
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
    
    
    func controlPassword(full_name:String, email:String, password:String, passwordconfirm:String) {

        if password.count <= 6 || full_name.count < 4 {
            self.errorAlertMessage = "Geçersiz kullanıcı adı veya şifre!"
        }else if password == passwordconfirm {
            let person = Register(username: full_name, email: email, password: password)
            registerPerson(person: person)
            self.successAlertMessage = "Kullanıcı başarıyla oluşturuldu."
        } else {
            self.errorAlertMessage = "Şİfreler uyuşmuyor. Tekrar deneyiniz."
            //alert şifreler uyuşmuyor
        }
        
    }
    
    func registerPerson(person: Register) {
        
        let params = ["full_name": person.username, "email": person.email , "password": person.password]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .register(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                self.successAlertMessage = success.message
            case .failure(let failure):
                self.errorAlertMessage = failure.localizedDescription
            }
        })
    }
}
