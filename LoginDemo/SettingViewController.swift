//
//  SettingViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/25/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var tableView: UITableView!
    var name: [String] = ["Edit profile","Account Details","Notifications","Blocked Users","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func btnBack(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let view = sb.instantiateViewController(withIdentifier: "tabView") as! TabBarViewController
        self.present(view, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingTableViewCell
        cell.lblName.text = name[indexPath.section]
//        print(name[indexPath.row])
        tableView.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let edit = sb.instantiateViewController(withIdentifier: "editprofile") as! EditprofileViewController
            edit.didMove(toParentViewController: self)
            self.addChildViewController(edit)
            self.view.addSubview(edit.view)
        case 1:
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let edit = sb.instantiateViewController(withIdentifier: "AccountDetail") as! AccountDetailViewController
            edit.didMove(toParentViewController: self)
            self.addChildViewController(edit)
            self.view.addSubview(edit.view)
        case 3:
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let edit = sb.instantiateViewController(withIdentifier: "blockuser") as! BlockUsersViewController
            edit.didMove(toParentViewController: self)
            self.addChildViewController(edit)
            self.view.addSubview(edit.view)
        case 4:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let view  = sb.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
            self.present(view, animated: true, completion: nil)
        default: break
//            print("Loi")
            
        }
        
        
    }

}
