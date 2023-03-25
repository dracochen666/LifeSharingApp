//
//  LS-TabBarController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/18.
//

import UIKit
import YPImagePicker

class LS_TabBarViewController: UITabBarController {
    
    //    let tabBarVC = UITabBarController()
    let frontVC = LS_FrontPageViewController()
    let memoVC = LS_MemoPageViewController()
    let publishVC = LS_PostPageViewController()
    let messageVC = LS_MessagePageViewController()
    let aboutVC = LS_AboutPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decorateBarItems()
        tabBar.backgroundColor = kTabBarBgColor
        tabBar.tintColor = .lightGray
        self.setViewControllers([frontVC, memoVC, publishVC, messageVC, aboutVC], animated: true)
        self.delegate = self
  
    }
    
    func decorateBarItems(){
        frontVC.tabBarItem.title = "首页"
        frontVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        frontVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -16)
        memoVC.tabBarItem.title = "备忘录"
        memoVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        memoVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -16)
        publishVC.tabBarItem.title = "发布"
        publishVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: .normal)
        publishVC.tabBarItem.image = UIImage(systemName: "plus.rectangle.fill")
        messageVC.tabBarItem.title = "消息"
        messageVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        messageVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -16)
        messageVC.tabBarItem.badgeValue = "12"
        aboutVC.tabBarItem.title = "我"
        aboutVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        aboutVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -16)
        
    }
    
}

extension LS_TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let _ = viewController as? LS_PostPageViewController {
//            self.present(WaterFallViewController(), animated: true)
            var config = YPImagePickerConfiguration()
//            config.isScrollToChangeModesEnabled = false
            config.albumName = "iSHARE Library"

            let picker = YPImagePicker()
            
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    print(photo.fromCamera) // Image source (camera or library)
                    print(photo.image) // Final image selected by the user
                    print(photo.originalImage) // original image selected by the user, unfiltered
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            return false
        }
            return true
    }
}
    

