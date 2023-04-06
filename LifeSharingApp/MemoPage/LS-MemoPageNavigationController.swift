//
//  LS-MemoPageNavigationController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit

class LS_MemoPageNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.backgroundColor =
        self.navigationBar.backgroundColor = UIColor(named: kThirdLevelColor)
//        self.navigationBar.setBackgroundImage(UIImage.generateImageWithColor(color: .orange, size: CGSize(width: 50, height: 50)), for: .default)
    }
    

}
