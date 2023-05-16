//
//  UserProfileViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/13.
//

import UIKit
import Anchorage

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    lazy var displayDraftsBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "本地草稿", bgColor: .systemBackground, cornerRadius: 8)
        btn.addTarget(self, action: #selector(displayDrafts), for: .touchUpInside)
        return btn
    }()
    lazy var logoutBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "点击注销", bgColor: .systemBackground, cornerRadius: 8)
        btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return btn
    }()
    
    func setupUI() {
        view.addSubview(displayDraftsBtn)
        view.addSubview(logoutBtn)

        
        displayDraftsBtn.horizontalAnchors == view.horizontalAnchors
        displayDraftsBtn.topAnchor == view.topAnchor + 200
        
        logoutBtn.horizontalAnchors == view.horizontalAnchors
        logoutBtn.topAnchor == displayDraftsBtn.bottomAnchor + 20
        
        
    }

}

//点击事件
extension UserProfileViewController {
    @objc func displayDrafts() {
        let vc = NoteWaterFallViewController()
        self.present(vc, animated: true)
    }
    
    @objc func logout() {
        let loginVC = LS_LoginViewController()
        defaults.set("", forKey: LoginInfo().token)
        print("注销后：本地存储token：\(defaults.value(forKey: LoginInfo().token))", defaults.value(forKey: LoginInfo().token))
        aboutPageViewController.removeAllSubViewController()
        aboutPageViewController.addSubViewController(subVC: loginVC)
    }
}
