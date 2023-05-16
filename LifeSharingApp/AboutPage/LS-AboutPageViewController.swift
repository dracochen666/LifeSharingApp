//
//  LS-AboutPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage

//添加全局强引用变量，存储”我的“页面指针
var aboutPageViewController = UIViewController()

class LS_AboutPageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutPageViewController = self
        
//        UserDefaults.standard.set("", forKey: "token")
        if (UserLoginStatus.isLogin()) {
            let vc = UserProfileViewController()
            self.addSubViewController(subVC: vc)
        }else {
            let vc = LS_LoginViewController()
            self.addSubViewController(subVC: vc)
        }
    }
    
//    var isLogin: Bool = false
    
}

