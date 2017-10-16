//
//  ThreeViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/14/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import  Toaster
class RegisterViewController: UIViewController {

    @IBOutlet weak var Scrollview: UIScrollView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRepass: UITextField!
    @IBOutlet weak var lblLogin: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let scrollview = Scrollview
//        scrollview?.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        let tap = UITapGestureRecognizer(target: self, action: #selector(Login))
        lblLogin.isUserInteractionEnabled = true

        lblLogin.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        scrollView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let myMutableString = NSMutableAttributedString(
            string: lblLogin.text!,
            attributes: [:])
        
        myMutableString.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.blue,
            range: NSRange(
                location:18,
                length:5))
        lblLogin.attributedText = myMutableString
    }
    func scrollView(){
        let scrollview = Scrollview
        scrollview?.contentSize = CGSize(width: (scrollview?.frame.size.width)!, height: (scrollview?.frame.size.height)!)
    }
    func Login(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let view1 = sb.instantiateViewController(withIdentifier: "homeView") as!HomeViewController
        self.present(view1, animated: true, completion: nil)

    }
    @IBAction func btnResgister(_ sender: Any) {
        let fistname = txtFirstName.text
        let lastname = txtLastName.text
        let email = txtEmail.text
        let pass = txtPassword.text
        let user = User(email: email!, password: pass!, firstname: fistname!, lastname: lastname!)
        DoRegister(user: user)
    }
    func checkSignUp(pass: String, repass: String) -> Bool{
        let pass = txtPassword.text
        let repass = txtRepass.text
        if pass == repass{
            return true
        }else{
            return false
        }
    }

    func DoRegister(user: User){
        let url: URL? = URL(string: "https://smeportal.org/api/users/register.json")
        var request = URLRequest(url: url!)
        let repass = txtRepass.text
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
                                    "email":user.email,
                                    "password": user.password,
                                    "firstname": user.firstname,
                                    "lastname": user.lastname
                                ]
        
        if  checkSignUp(pass: user.password, repass: repass!){
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
                    if  (status)==1{
                        DispatchQueue.main.async {
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let view2 = sb.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
                            self.present(view2, animated: true, completion: nil)
                        }
                    }else{
                        Toast(text: "Lỗi đăng ký tài khoản").show()
//                        DispatchQueue.main.async {
//                            let alert  = UIAlertController.init(title: "Alert", message: "khong thanh cong",preferredStyle: .alert)
//                            let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//                            alert.addAction(defaultAction)
//                            self.present(alert, animated: true, completion: nil)
//                        
//                        }
                    }
                } catch let error as NSError {
                    
                    print(error)
                }
            }
            task.resume()
        }
        else{
            Toast(text: "Mật khẩu không khớp").show()
        }
        
        

    }

}
