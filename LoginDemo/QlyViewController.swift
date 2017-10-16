//
//  QlyViewController.swift
//  LoginDemo
//
//  Created by Tien Le on 7/24/17.
//  Copyright © 2017 Tienle. All rights reserved.
//

import UIKit
import PageMenu
class QlyViewController: UIViewController{

    var pageMenu: CAPSPageMenu?
    
    var controllerArray: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
    }
    func setupView() {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blue]
            
            // Initialize view controllers to display and place in array
            //        let sb1 = UIStoryboard(name: "Profile", bundle: nil)
            let firstVC = storyboard?.instantiateViewController(withIdentifier: "profileView") as! ProfileViewController
            firstVC.title = "Profile"
            controllerArray.append(firstVC)
            
            let sb2 = UIStoryboard(name: "Following", bundle: nil)
            let secondVC = sb2.instantiateViewController(withIdentifier: "followingView") as! FollowingViewController
            secondVC.title = "Following"
            controllerArray.append(secondVC)
            
            let sb3 = UIStoryboard(name: "Followers", bundle: nil)
            let thirdVC = sb3.instantiateViewController(withIdentifier: "followersView") as! FollowersViewController
            thirdVC.title = "Followers"
            controllerArray.append(thirdVC)
            
            // Customize menu (Optional)
            let parameters: [CAPSPageMenuOption] = [
                .scrollMenuBackgroundColor(UIColor.white),
                .viewBackgroundColor(UIColor.white),
                .selectionIndicatorColor(UIColor.blue),
                .selectedMenuItemLabelColor(UIColor.blue),
                .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
                .menuHeight(40.0),
                .menuItemWidth(90.0),
                .centerMenuItems(false)
            ]
            let btnSetting = UIButton(frame: CGRect(x: self.view.frame.width - 60, y: 5, width: 30, height: 30))
            btnSetting.setBackgroundImage(UIImage(named: "anhst"), for:.normal)
            btnSetting.addTarget(self, action: #selector(QlyViewController.btnSettingPressed), for:.touchUpInside )
            
            // Initialize scroll menu
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 20.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
            
            self.addChildViewController(pageMenu!)
            self.view.addSubview(pageMenu!.view)
            self.pageMenu?.view.addSubview(btnSetting)
            
            self.pageMenu!.didMove(toParentViewController: self)
        
    }
    
    func btnSettingPressed() {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        let settingVC = sb.instantiateViewController(withIdentifier: "settingView") as! SettingViewController
        self.addChildViewController(settingVC)
        self.view.addSubview(settingVC.view)
    }


}
