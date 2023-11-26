//
//  SignUpViewModel.swift
//  travioapp
//
//  Created by Sabri DİNDAR on 26.10.2023.
//

import Foundation
import Alamofire

class SignUpViewModel {
    var onSuccess: ((String, String) -> Void)?
    var onError: ((String, String) -> Void)?
    
    func controlPassword(full_name:String, email:String, password:String, passwordConfirm:String) {
        guard full_name.count >= 4 || password.count > 6  else {
            self.onError?("Hata", "Geçersiz kullanıcı adı veya şifre.")
            return
        }
        guard password == passwordConfirm else {
            self.onError?("Hata", "Şifreler uyuşmuyor. Tekrar deneyiniz.")
            return
        }
        
        let person = Register(username: full_name, email: email, password: password)
        registerPerson(person: person)
        
    }
    
    func registerPerson(person: Register) {
        
        let params = ["full_name": person.username, "email": person.email , "password": person.password]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .register(param: params), callback: { (result:Result<BaseResponse, Error>) in
            
            switch result {
            case .success(let success):
                self.onSuccess?("Başarılı", "Kullanıcı başarıyla oluşturuldu.")
                
            case .failure(let failure):
                switch failure.localizedDescription{
                case "Response status code was unacceptable: 500.":
                    self.onError?("Hata", "Bu emailde kayıtlı kullanıcı bulunmaktadır.")
                case "Response status code was unacceptable: 400.":
                    self.onError?("Hata", "Emailinizi kontrol ediniz.")
                default:
                    self.onError?("Hata", failure.localizedDescription)

                }
            }
        })
    }
}

