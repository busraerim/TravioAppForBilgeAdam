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
        
        NetworkingHelper.shared.postData(urlRequest: .login(param: params), callback:{ (result:Result<User,Error>) in
            print(result)
        })
    }
}
