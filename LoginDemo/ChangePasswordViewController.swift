//
//  ChangePasswordViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/26/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import Toaster
class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var txtOldpassword: UITextField!
    @IBOutlet weak var txtNewpasword: UITextField!
    @IBOutlet weak var txtConfirmpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnChangepassword(_ sender: Any) {
        changepassword()
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    func checkPass(pass: String, confirm: String) -> Bool{
        let pass = txtNewpasword.text
        let confirm = txtConfirmpassword.text
        if pass == confirm{
            return true
        }else{
            return false
        }
    }
    func changepassword(){
        let savedata = SaveData()
        let url: URL? = URL(string: "https://smeportal.org/api/users/changePass.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "token": savedata.getToken(),
            "old_password":txtOldpassword.text,
            "password":txtNewpasword.text
        ]
        if checkPass(pass: txtNewpasword.text!, confirm: txtConfirmpassword.text!){
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
                    DispatchQueue.main.async {
                        self.txtOldpassword.text = ""
                        self.txtNewpasword.text = ""
                        self.txtConfirmpassword.text = ""
                    }
                
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }else{
            Toast(text: "Mật khẩu mới không trùng nhau").show()
        }
    }

}
