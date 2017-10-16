//
//  FolderViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/31/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import Popover
import DLRadioButton
class FolderViewController: UIViewController  {
    
    var nameObject:[String] = []
    var nameSortBy:[String] = []
    var nameRole: [String] = []
    var tableObject = UITableView()
    var tableSortBy = UITableView()
    var tableRole = UITableView()
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    @IBOutlet weak var lblOjname: UILabel!
    @IBOutlet weak var lblSortBy: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var btnEverywhere: DLRadioButton!
    @IBOutlet weak var btnNearMe: DLRadioButton!
    @IBOutlet weak var btnNear: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        OnClick()
        var api = ApiDiscover()
        api.hienthi(token: SaveData().getToken(), group: 1, complete: {
            (result,status) in
            if status == 1{
                self.nameObject = result
            }
        })
        api.hienthi(token: SaveData().getToken(), group: 2, complete: {
            (result,status) in
            if status == 1{
                self.nameSortBy = result
            }
        })
        api.hienthi(token: SaveData().getToken(), group: 3, complete: {
            (result,status) in
            if status == 1{
                self.nameRole = result
            }
        })
        
        // Do any additional setup after loading the view.
        btnEverywhere.addTarget(self, action: #selector(ClickButtonEW), for: .touchUpInside)
        btnNearMe.addTarget(self, action: #selector(ClickButtonNM), for: .touchUpInside)
        btnNear.addTarget(self, action: #selector(ClickButtonN), for: .touchUpInside)
    }
    func ClickButtonEW(){
        self.btnEverywhere.isSelected = true
        self.btnNearMe.isSelected = false
        self.btnNear.isSelected = false
    }
    func ClickButtonNM(){
        self.btnEverywhere.isSelected = false
        self.btnNearMe.isSelected = true
        self.btnNear.isSelected = false
    }
    func ClickButtonN(){
        self.btnEverywhere.isSelected = false
        self.btnNearMe.isSelected = false
        self.btnNear.isSelected = true
    }
    func OnClick(){
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(PopOver1))
        lblOjname.isUserInteractionEnabled = true
        lblOjname.addGestureRecognizer(tab)
        
        let tab1 = UITapGestureRecognizer(target: self, action: #selector(PopOver2))
        lblSortBy.isUserInteractionEnabled = true
        lblSortBy.addGestureRecognizer(tab1)
        
        let tab2 = UITapGestureRecognizer(target: self, action: #selector(PopOver3))
        lblRole.isUserInteractionEnabled = true
        lblRole.addGestureRecognizer(tab2)
    }
    func PopOver3(){
        tableRole = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 300))
        tableRole.delegate = self
        tableRole.dataSource = self
        tableRole.isScrollEnabled = true
        self.popover = Popover(options: self.popoverOptions)
        self.popover.show(tableRole, fromView: self.lblRole)
    }

    func PopOver2(){
        tableSortBy = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 300))
        tableSortBy.delegate = self
        tableSortBy.dataSource = self
        tableSortBy.isScrollEnabled = true
        self.popover = Popover(options: self.popoverOptions)
        self.popover.show(tableSortBy, fromView: self.lblSortBy)
    }

    
    func PopOver1(){
        tableObject = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 300))
        tableObject.delegate = self
        tableObject.dataSource = self
        tableObject.isScrollEnabled = true
        self.popover = Popover(options: self.popoverOptions)
        self.popover.show(tableObject, fromView: self.lblOjname)
    }
}


extension FolderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableObject{
            lblOjname.text = nameObject[indexPath.row]
        }
        if tableView == tableSortBy{
            lblSortBy.text = nameSortBy[indexPath.row]
        }
        if tableView == tableRole{
            lblRole.text = nameRole[indexPath.row]
        }
        self.popover.dismiss()
    }
}

extension FolderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == tableObject{
            return nameObject.count

        }
        else if tableView == tableSortBy{
            return nameSortBy.count
            
        }
        else{
            return nameRole.count
            
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == tableObject{
            cell.textLabel?.text = nameObject[indexPath.row]
        }
        else if tableView == tableSortBy{
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = nameSortBy[indexPath.row]
        }
        else if tableView == tableRole{
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = nameRole[indexPath.row]
        }
        return cell
    }
}

