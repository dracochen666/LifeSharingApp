//
//  Extension-ViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/1.
//

import Foundation
//import MBProgressHUD

extension UIViewController {
    
    //提示
    func showAlert(title: String,
                   subtitle: String) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subtitle
        hud.hide(animated: true, afterDelay: 2)
    }
}
