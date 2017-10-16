//
//  ApigetProfile.swift
//  LoginDemo
//
//  Created by Tien Le on 8/1/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import Foundation
class ApigetProfile{
    func editprofile(token: String, complete: @escaping ([String], Int,String) -> Void){
        var namecountry: String = "Country"
//        var name: [String] = []
        let savedata = SaveData()
        let url: URL? = URL(string: "https://smeportal.org/api/profile/getProfile.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "token": savedata.getToken(),
            "language": "en"
        ]
        let postString = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        request.httpBody = postString
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else{
                print("error= \(String(describing: error))")
                return
            }
            if (response as? HTTPURLResponse) != nil{
                //                print("reponse = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("reponseString = \(String(describing: responseString))")
            do {
                var keyCountry : [String] = []
                var Arraycoutry : [String] = []
//                var keySate : [String] = []
//                var Arraysate : [String] = []
//                var keyDistrict : [String] = []
//                var Arraydistrict : [String] = []
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let status = jsonResult["status"] as? Int
                if status == 1{
                    let data = jsonResult["data"] as? [String: Any]
                    let us = data?["Users"] as? [String:Any]
                    let country = us?["country_id"] as? Int
                    let countries = data?["countries"] as? NSDictionary
                    keyCountry = (countries?.allKeys as? [String])!
                    Arraycoutry = (countries?.allValues as! [String])
                    namecountry = (countries?.value(forKey: (country?.description)!) as? String)!
                    complete(Arraycoutry, status!,namecountry)
                    return
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
        
    }
}
