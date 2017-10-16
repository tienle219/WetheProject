//
//  FollowingViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/24/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import  Toaster
class FollowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var Viewsite: UIView!
//    @IBOutlet weak var tableView: UITableView!
    var nguois = [Nguoi]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            theodoi( complete: {
                result in
                self.nguois = result
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nguois.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FollowingTableViewCell
        cell.lblName.text = nguois[indexPath.row].name
        cell.lblAddress.text = nguois[indexPath.row].address
        cell.lblRole.text = nguois[indexPath.row].role
        let url = URL(string: nguois[indexPath.row].url)
        let data = try? Data(contentsOf: url!)
        
        if data != nil {
            let image = UIImage(data: data!)
            cell.imgVIew.layer.borderWidth = 1.0
            cell.imgVIew.layer.masksToBounds = false
            cell.imgVIew.layer.cornerRadius = cell.imgVIew.layer.frame.height/2
            cell.imgVIew.clipsToBounds = true
            cell.imgVIew.image = image
        }
        cell.btnBlock.addTarget(self, action: #selector(self.blockuser(_:)), for: .touchUpInside)
        tableView.sizeToFit()
        return cell
    }
    
    func blockuser(_ sender : UIButton){
        let index = sender.tag
        //        print("name : \(nguois[index].name)")
        //        print("id : \(nguois[index].id)")
        let savedata = SaveData()
        let url: URL? = URL(string: "https://smeportal.org/api/usersFollow/blockUser.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "token": savedata.getToken(),
            "action": "block",
            "userid": nguois[index].id
            
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
    
    func theodoi(complete : @escaping ([Nguoi]) -> Void){
        let queue = DispatchQueue(label: "following")
        queue.async {
            var nguois = [Nguoi]()
            let savedata = SaveData()
            let url: URL? = URL(string: "https://smeportal.org/api/usersFollow/showFollowing.json")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let json :[String: Any] = [
                "token": savedata.getToken()
//                "user_id": n.id
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
                        let data = jsonResult["data"] as? [String:Any]
                        if let u = data?["user"] as? [[String:Any]]{
                            for us in u{
                                let nguoi = Nguoi()
                                if let id = us["userid"] as? Int{
                                    nguoi.id = id.description
                                }
                                if let name = us["name"] as? String{
                                    nguoi.name = name
                                }
                                if let address = us["address"]as? String{
                                    nguoi.address = address
                                }
                                if let role = us["roles"]as? String{
                                    nguoi.role = role
                                }
                                if let image = us["avatar"]as? String{
                                    nguoi.url = image
                                }
                                nguois.append(nguoi)
                            }
                            complete(nguois)
                            return
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
    


}
