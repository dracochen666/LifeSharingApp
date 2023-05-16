//
//  OffLinePageViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/16.
//

import UIKit
import Anchorage

class OffLinePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    lazy var goToLoginBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "前往登录", bgColor: UIColor(named: kThirdLevelColor)!, cornerRadius: 8)
        
        btn.layoutMargins = EdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.addTarget(self, action: #selector(toLoginArea), for: .touchUpInside)
        return btn
    }()
    
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        self.view.addSubview(goToLoginBtn)
        
        goToLoginBtn.centerXAnchor == self.view.centerXAnchor
        goToLoginBtn.centerYAnchor == self.view.centerYAnchor - 100
    }

}

extension OffLinePageViewController {
    
    @objc func toLoginArea() {
        tabBarController?.selectedIndex = 4
    }
}
