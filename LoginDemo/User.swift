//
//  Users.swift
//  LoginDemo
//
//  Created by Tien Le on 7/20/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import Foundation
class User: NSObject{
    let email:String
    let password: String
    let firstname: String
    let lastname: String
    init(email: String,password:String,firstname:String,lastname:String) {
        self.email = email
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
        
    }
}
