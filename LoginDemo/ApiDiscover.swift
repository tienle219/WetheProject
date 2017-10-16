//
//  ApiDiscover.swift
//  LoginDemo
//
//  Created by Tien Le on 7/31/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import Foundation
class ApiDiscover {
    func hienthi(token: String, group: Int, complete: @escaping ([String],Int) -> Void){
//        let savedata = SaveData()
        var name : [String] = []
        let url: URL? = URL(string: "https://smeportal.org/api/Discover/getOptionSearch.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "token": token,
            "group":group
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
            _ = String(data: data, encoding: .utf8)
            //            print("reponseString = \(String(describing: reponseString))")
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let status = jsonResult["status"] as? Int
                if  (status) == 1{
                    if let dta = jsonResult["data"] as? [[String:Any]]{
                        for i in dta{
                            if let ojname = i["object_name"] as? String{
                                name.append(ojname)
                                complete(name,status!)
                            }
                        }
                    }
                }
            }
            catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
}
