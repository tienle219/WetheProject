//
//  ChangeEmailViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/26/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import Toaster
class ChangeEmailViewController: UIViewController {

    let savedata = SaveData()

    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = savedata.getEmail().email
        // Do any additional setup after loading the view.
    }

    @IBAction func btnChangeEmail(_ sender: Any) {
        changeemail()
    }
    @IBAction func btnBack(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    func changeemail(){
                let url: URL? = URL(string: "https://smeportal.org/api/users/changeEmail.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "token": savedata.getToken(),
            "email":txtEmail.text,
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
                    let message = jsonResult["message"] as? String
                    Toast(text: message!).show()
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
    }


}
