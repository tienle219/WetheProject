//
//  EditprofileViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/25/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import  Toaster
import Popover
class EditprofileViewController: UIViewController {

    @IBOutlet weak var PictureProfile: UIImageView!
    @IBOutlet weak var lblFirstName: UITextField!
    @IBOutlet weak var lblLastName: UITextField!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblDistricts: UILabel!
    @IBOutlet weak var lblMa: UILabel!
    @IBOutlet weak var lblRole1: UILabel!
    @IBOutlet weak var lblRole2: UILabel!
    @IBOutlet weak var txtBiography: UITextField!
    var tableContry = UITableView()
    var tableState = UITableView()
    var tableDistrict = UITableView()
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    var Country:[String] = []
    var State:[String] = []
    var District: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var api = ApigetProfile()
        Click()
        api.editprofile(token: SaveData().getToken(), complete: {
            (ctry, status,name) in
            if status == 1 {
                DispatchQueue.main.async {
                    self.Country = ctry
                    self.lblCountry.text = name
                }
                
            }
        })
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }

    func Click(){
        let tab = UITapGestureRecognizer(target: self, action: #selector(PopOverCountry))
        lblCountry.isUserInteractionEnabled = true
        lblCountry.addGestureRecognizer(tab)
    }
    func PopOverCountry(){
        tableContry = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 300))
        tableContry.delegate = self
        tableContry.dataSource = self
        tableContry.isScrollEnabled = true
        self.popover = Popover(options: self.popoverOptions)
        self.popover.show(tableContry, fromView: self.lblCountry)
    }
}
extension EditprofileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableContry{
            lblCountry.text = Country[indexPath.row]
        }
//        if tableView == tableSortBy{
//            lblSortBy.text = nameSortBy[indexPath.row]
//        }
//        if tableView == tableRole{
//            lblRole.text = nameRole[indexPath.row]
//        }
        self.popover.dismiss()
    }
}

extension EditprofileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        if tableView == tableObject{
//            return nameObject.count
//            
//        }
//        else if tableView == tableSortBy{
//            return nameSortBy.count
//            
//        }
//        else{
//            return nameRole.count
//            
//        }
        return Country.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == tableContry{
            cell.textLabel?.text = Country[indexPath.row]
        }
//        else if tableView == tableSortBy{
//            //            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            cell.textLabel?.text = nameSortBy[indexPath.row]
//        }
//        else if tableView == tableRole{
//            //            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            cell.textLabel?.text = nameRole[indexPath.row]
//        }
        return cell
    }
}
