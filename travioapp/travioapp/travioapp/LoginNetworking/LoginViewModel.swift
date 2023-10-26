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
    
    var transferData: (()->())?
    
    
    func postData(email:String,password:String){
        
        
        let params = [ "email": email, "password": password]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .login(param: params), callback: { (result:Result<User,Error>) in
            switch result {
            case .success(let success):
                print("başarılı")
            case .failure(let failure):
                print("başarısız")
            }
            
        })
    }
    
    func registerPerson(person: Register) {
        
        let params = ["full_name": person.username, "email": person.email , "password": person.password]
        
        GenericNetworkingHelper.shared.getDataFromRemote(urlRequest: .register(param: params), callback: { (result:Result<BaseResponse, Error>) in
            switch result {
            case .success(let success):
                print(success.message)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
}
