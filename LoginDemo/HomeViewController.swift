//
//  ViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/13/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import Toaster
class HomeViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblForgotPass: UILabel!
    @IBOutlet weak var lblSingup: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUp))
        lblSingup.isUserInteractionEnabled = true
        lblSingup.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(forgotPass))
        lblForgotPass.isUserInteractionEnabled = true
        lblForgotPass.addGestureRecognizer(tap1)
        
        let user = SaveData().getUser()
        if user.email != "" {
            txtEmail.text = user.email
            txtPassword.text = user.password
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let myMutableString1 = NSMutableAttributedString(
            string: lblSingup.text!,
            attributes: [:])
        let myMutableString2 = NSMutableAttributedString(string: lblForgotPass.text!, attributes: [:])
        myMutableString1.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.blue,
            range: NSRange(
                location:23,
                length:7))
        myMutableString2.addAttribute(NSForegroundColorAttributeName,
                                      value: UIColor.blue,
                                      range: NSRange(location: 0,length:21))
        lblSingup.attributedText = myMutableString1
        lblForgotPass.attributedText = myMutableString2
    }
    
    
    //MARK: Xử lý butotn login
    @IBAction func btnLogin(_ sender: Any) {
        let email = txtEmail.text
        let password = txtPassword.text
        let user = User(email: email!, password: password!, firstname: "", lastname: "")
        DoLogin(user : user, complete: {
            (status) in
            if status == 1{
                SaveData().saveUser(user: user)
                DispatchQueue.main.async {
//                    let sb = UIStoryboard(name: "Main", bundle: nil)
//                    let view2 = sb.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
//                    self.present(view2, animated: true, completion: nil)
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let view2 = sb.instantiateViewController(withIdentifier: "tabView")
                    self.present(view2, animated: true, completion: nil)
                    
                }
            }
            else{
                Toast(text: "Lỗi sai thông tin tài khoản").show()
            }
        })
    }
    
    //MARK: Xử lý butotn quên mật khẩu
    func forgotPass(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let view4 = sb.instantiateViewController(withIdentifier: "forgotpassView") as! ForgotPassViewController
        
        self.present(view4, animated: true, completion: nil)
    }
    func SignUp(){
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let view3 = sb.instantiateViewController(withIdentifier: "registerView") as! RegisterViewController
        
        self.present(view3, animated: true, completion: nil)
    }
    func DoLogin(user : User,complete : @escaping (Int) -> ()){
        let savedata = SaveData()
        let url: URL? = URL(string: "https://smeportal.org/api/users/login.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = ["email":user.email,
                                   "password": user.password]
        
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
            
//            let response = String(
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                let status = jsonResult["status"] as? Int
                if  (status)==1{
                    let rootData = jsonResult["data"] as! [String : Any]
                    let token = rootData["token"] as? String
                    savedata.saveToken(token: token!)
                    complete(status!)
                    return
                }else{
                    complete(status!)
                    return
                }
            } catch let error as NSError {
                
                print(error)
            }
            }
        task.resume()
    }
}
