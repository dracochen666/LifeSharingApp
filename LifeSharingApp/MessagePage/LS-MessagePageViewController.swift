//
//  LS-MessagePageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage

class LS_MessagePageViewController: UIViewController {

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(1)
        if UserLoginStatus.isLogin() {
            
            print("messPageStatus:", UserLoginStatus.isLogin())
            let vc = UserMessageViewController()
            self.addSubViewController(subVC: vc)
            
        }else {
            
            let vc = OffLinePageViewController()
            self.addSubViewController(subVC: vc)
            
        }
        print(2)
        
    }
    
    
}


