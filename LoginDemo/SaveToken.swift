//
//  SaveToken.swift
//  LoginDemo
//
//  Created by Tien Le on 7/24/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import Foundation
class SaveData: NSObject{
    
    var userDefault : UserDefaults
    
    override init() {
        userDefault = UserDefaults.standard
    }
    
    func saveToken(token : String) {
        userDefault.set(token, forKey: "Token")
        userDefault.synchronize()
    }
    
    func getToken() -> String {
        
        let token = userDefault.string(forKey: "Token")
        if token == nil {
            return ""
        }
        return token!
    }
    func saveName(name: String){
        userDefault.set(name, forKey: "Name")
        userDefault.synchronize()
    }
    func getName() -> String{
        let name = userDefault.string(forKey: "Name")
        if name == nil {
            return ""
        }
        return name!
    }
    func saveUser(user: User){
        userDefault.set(user.email, forKey: "email")
        userDefault.set(user.password, forKey: "password")
        userDefault.synchronize()
    }
    func getUser() -> User{
        let email = userDefault.string(forKey: "email")
        let password = userDefault.string(forKey: "password")
        if email == nil || password == nil {
            return User(email: "", password: "", firstname: "", lastname: "")
        }
        return User(email: email!, password: password!, firstname: "", lastname: "")
    }
    func saveEmail(user: User){
        userDefault.set(user.email, forKey: "email")
//        userDefault.set(user.password, forKey: "password")
        userDefault.synchronize()
    }
    func getEmail() ->User{
        let email = userDefault.string(forKey: "email")
        if email == nil  {
            return User(email: "", password: "", firstname: "", lastname: "")
        }
        return User(email: email!, password: "", firstname: "", lastname: "")
    }
}



















