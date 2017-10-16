//
//  EditProfileViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/25/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit

class AccountDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var TableView: UITableView!
    var name: [String] = ["Email", "Change Password", "Payment Information"]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountdetailTableViewCell
        cell.lblName.text = name[indexPath.row]
        if name[0] == name[indexPath.row]{
            let email = SaveData().getEmail()
            if email.email != "" {
                cell.lblEmail.text = email.email
            }
        }
        tableView.sizeToFit()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "Change", bundle: nil)
            let edit = sb.instantiateViewController(withIdentifier: "changeemail") as! ChangeEmailViewController
            edit.didMove(toParentViewController: self)
            self.addChildViewController(edit)
            self.view.addSubview(edit.view)
        case 1:
            let sb = UIStoryboard(name: "Change", bundle: nil)
            let edit = sb.instantiateViewController(withIdentifier: "changepassword") as! ChangePasswordViewController
            edit.didMove(toParentViewController: self)
            self.addChildViewController(edit)
            self.view.addSubview(edit.view)
//        case 2:
//            let sb = UIStoryboard(name: "Setting", bundle: nil)
//            let edit = sb.instantiateViewController(withIdentifier: "blockuser") as! BlockUsersViewController
//            edit.didMove(toParentViewController: self)
//            self.addChildViewController(edit)
//            self.view.addSubview(edit.view)
        default: break
            //            print("Loi")
            
        }
    }

}
