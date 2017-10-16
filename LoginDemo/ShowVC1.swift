//
//  ShowVC1.swift
//  LoginDemo
//
//  Created by Tien Le on 7/31/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
//protocol getData {
//    func getName(name: String)
//}
class ShowVC1: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Tableview: UITableView!
    var name:[String] = []
//    var Delegate: getData?
    override func viewDidLoad() {
        super.viewDidLoad()
        Tableview.delegate = self
        Tableview.dataSource = self
        hienthi()
    }
    @IBAction func btnBack(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FolderTableViewCell
        cell?.lblName.text = name[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let n = name[indexPath.row]
        
        let db = UIStoryboard(name: "Main", bundle: nil)
        let view = db.instantiateViewController(withIdentifier: "folder") as! FolderViewController
        view.name1 = name[indexPath.row]
        present(view, animated: true, completion: nil)
    }
    func hienthi(){
        let savedata = SaveData()
        let url: URL? = URL(string: "https://smeportal.org/api/Discover/getOptionSearch.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json :[String: Any] = [
            "token": savedata.getToken(),
            "group":1
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
                                self.name.append(ojname)
//                                print(self.name)
                                DispatchQueue.main.sync {
                                    self.Tableview.reloadData()
                                }
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
