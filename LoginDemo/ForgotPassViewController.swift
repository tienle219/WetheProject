//
//  forgotPassViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/18/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import Toaster
class ForgotPassViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
//    @IBOutlet weak var txtEmail: UITextField!
    override
    func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnReply(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let view1 = sb.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
        self.present(view1, animated: true, completion: nil)

    }
    @IBAction func btnSendpass(_ sender: Any) {
        let email = txtEmail.text
        let user = User(email: email!, password: "", firstname: "", lastname: "")
        SendtoEmail(user: user)
    }

    func SendtoEmail(user: User){
        let url: URL? = URL(string: "https://smeportal.org/api/users/forgot_pass.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "email":user.email
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


