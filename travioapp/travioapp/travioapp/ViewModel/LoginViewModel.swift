//
//  LoginViewModel.swift
//  travioapp
//
//  Created by Büşra Erim on 25.10.2023.
//

import Foundation
import Alamofire


class LoginViewModel{
     
    
    var kisiler:[User] = [] {
        didSet {
            self.transferData?()
        }
    }
    
    var alertMessage: String? {
            didSet {
                self.showAlertClosure?()
            }
        }
    
    
    var showAlertClosure: (()->())?
    var transferData: (()->())?
    

    func loginControl(email:String, password:String){
        if !email.isEmpty && !password.isEmpty{
            postData(email: email, password: password)
        }else{
            self.alertMessage = "Email ve şifre boş bırakılamaz."
        }
    }
    
    
    func postData(email:String,password:String){
        let params = [ "email": email, "password": password]
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .login(param: params), callback: { (result:Result<UserToken,Error>) in
            switch result {
            case .success(let user):
                if let accessToken = user.accessToken {
                    let accessTokenData = Data(accessToken.utf8)
                    
                    KeychainHelper.shared.save(accessTokenData, service: "access-token", account: "travio")
                    print("Erişim Token'ı: \(accessToken)")
                } else {
                    print("Hata: Erişim Token'ı bulunamadı.")
                }
            case .failure(let failure):
                self.alertMessage = "Hatalı email/şifre"
            }
            
        })
    }
}
