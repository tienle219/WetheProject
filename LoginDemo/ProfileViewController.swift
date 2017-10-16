//
//  SecondViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/14/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import PageMenu
import Toaster
class ProfileViewController: UIViewController {

//    var pageMenu: CAPSPageMenu?
    
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblHoten: UILabel!
    @IBOutlet weak var lblChucvu: UILabel!
    @IBOutlet weak var lblVitri: UILabel!
    @IBOutlet weak var lblTieusu: UILabel!
    @IBOutlet weak var lblNguoitheodoi: UILabel!
    @IBOutlet weak var lblTheodoi: UILabel!
    @IBOutlet weak var lblDuan: UILabel!
    @IBAction func btnXemtieusu(_ sender: Any) {
        let alert  = UIAlertController.init(title: "Tiểu Sử", message: lblTieusu.text,preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblView.layer.borderWidth = 1
        self.lblView.layer.borderColor = UIColor(red: 222.0/255.0, green: 222.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor
        hienthi()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    func hienthi(){
//        let q = DispatchQueue(label: "1")
//        q.async {
            let savedata = SaveData()
            let url: URL? = URL(string: "https://smeportal.org/api/collaborators/getProfile.json")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let json :[String: Any] = [
                "user_id":0,
                "token": savedata.getToken()
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
                        var rl = [String]()
                        let data = jsonResult["data"] as? [String:Any]
                        let user = data?["user"] as? [String:Any]
                        let name = user?["name"] as? String
                        if let roles = user?["roles"] as? [[String:Any]]{
                            for role in roles{
                                if let n = role["role"]{
                                    rl.append(n as! String)
                                }
                            }
                        }
                        let biography = user?["biography"] as? String
                        let image = user?["avatar"] as? String
                        let following = data?["following"] as? Int
                        let followers = data?["follower"] as? Int
                        let project = data?["projects"] as? Int
                        DispatchQueue.main.sync {
                            self.lblHoten.text = name
                            self.lblTieusu.text = biography
                            self.lblTheodoi.text = following?.description
                            self.lblNguoitheodoi.text = followers?.description
                            self.lblDuan.text = project?.description
                            if (rl[0] != "" && rl[1] != ""){
                                self.lblChucvu.text = rl[0]
                                self.lblVitri.text = rl[1]
                            }
                            let url = URL(string: image!)
                            let data = try? Data(contentsOf: url!)
                            
                            if data != nil {
                                let image = UIImage(data: data!)
                                self.imageView.image = image
                            }
                        }
                        
                        
                    }else{
                        Toast(text: "Lỗi").show()
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
//        }
    }

}
