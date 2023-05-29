//
//  DropDownMenuViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/27.
//

import UIKit
import Anchorage


class DropDownMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let menu = DropDownMenuView()
        self.view.addSubview(menu)
        
        menu.horizontalAnchors == self.view.horizontalAnchors
        menu.centerYAnchor == self.view.centerYAnchor
        
        menu.heightAnchor == 30
        
    }
    

}


