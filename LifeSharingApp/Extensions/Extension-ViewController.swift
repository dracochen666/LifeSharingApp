//
//  Extension-ViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/1.
//

import Foundation
//import MBProgressHUD

extension UIViewController {
    
    //提示框
    func showAlert(title: String,
                   subtitle: String, isCurrentView: Bool = true) {
        var showView = view!
        if !isCurrentView {
            showView = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.mode = .text
        hud.label.text = title
        if !subtitle.isEmpty { hud.detailsLabel.text = subtitle }
        hud.hide(animated: true, afterDelay: 1)
    }
    
    func hideAlert() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showLoadingAni(title: String = "") {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = title
    }
    func hideLoadingAni() {

        MBProgressHUD.hide(for: self.view, animated: true)

    }
    func showLoadingAniCustom(title: String = "", isCurrentView: Bool = true) {
        var showView = view!
        if !isCurrentView {
            showView = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.hide(animated: true, afterDelay: 1)
    }
    func hideLoadingAniCustom() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func addSubViewController(subVC: UIViewController) {
        addChild(subVC)
        subVC.view.frame = self.view.bounds
        view.addSubview(subVC.view)
        didMove(toParent: self)
    }
    
    func removeSubViewController(subVC: UIViewController) {
        willMove(toParent: nil)
        subVC.view.removeFromSuperview()
        subVC.removeFromParent()
    }
    
    func removeAllSubViewController() {
        if !children.isEmpty {
            for vc in children {
                removeSubViewController(subVC: vc)
            }
        }
    }
}
