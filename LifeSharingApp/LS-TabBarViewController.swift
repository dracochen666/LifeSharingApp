//
//  LS-TabBarController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/18.
//

import UIKit
import YPImagePicker
import Alamofire
import SwiftyJSON

//创建全局tabBarViewcontroller引用
var tabBarViewController = UIViewController()
var defaults = UserDefaults.standard
let headers: HTTPHeaders = [
    "token": "\(defaults.value(forKey: LoginInfo().token)!)"
]



class LS_TabBarViewController: UITabBarController {

    //    let tabBarVC = UITabBarController()
    lazy var frontVC: LS_FrontPageViewController = {
        let vc = LS_FrontPageViewController()
        vc.showDelegate = self
        return vc
    }()
//    let frontVC = LS_FrontPageViewController()
//    lazy var frontNC: LS_FrontPageNavigationController = {
//        frontVC.showDelegate = self
//       let nc =  LS_FrontPageNavigationController(rootViewController: frontVC)
//        return nc
//    }()
    let memoVC = LS_MemoPageNavigationController(rootViewController: LS_MemoPageViewController())
    let publishVC = LS_PostPageViewController()
    let messageVC = LS_MessagePageViewController()

    let aboutVC = LS_AboutPageViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        tabBarViewController = self
        
        decorateBarItems()
        tabBar.backgroundColor = kTabBarBgColor
        tabBar.tintColor = .lightGray
        self.setViewControllers([frontVC, memoVC, publishVC, messageVC, aboutVC], animated: true)
        self.delegate = self
  
    }
    
    func decorateBarItems(){
        frontVC.tabBarItem.title = "首页"
        frontVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
//        frontNC.tabBarItem.title = "首页"
//        frontNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
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
        print("当前登录用户token:",defaults.value(forKey: LoginInfo().token))

        if viewController is LS_PostPageViewController {
            if !(UserLoginStatus.isLogin()) {
                self.showAlert(title: "请先登录", subtitle: "")
                return false
            }
            
            //图片视频选择逻辑：
            //1.只能选择多个图片或单个视频，图片视频不能混选
            //2.选择图片后，在笔记编辑页面可删除或追加图片
            
            var config = YPImagePickerConfiguration()
            config.albumName = "iSHARE Library"
            config.onlySquareImagesFromCamera = false
            config.maxCameraZoomFactor = kPickerCameraZoom
            
            //相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kPickerMaxPhotoCount
            config.library.preSelectItemOnMultipleSelection = false
            
            let picker = YPImagePicker(configuration: config)

            present(picker, animated: true, completion: nil)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("cancelled")
                    tabBarController.selectedIndex = 0
                    picker.dismiss(animated: true)
                    return
                }
                
                let vc = NoteEditViewController()
                var i = 0
                for item in items {
                    switch item {
                    case let .photo(p: photo):
                        vc.photos.append(photo.image)
                        i += 1
                    case let .video(v: video):
                        print("video")
                    }
                }
                picker.pushViewController(vc, animated: true)
            }
        }
        if viewController is LS_MessagePageViewController {
            if !UserLoginStatus.isLogin() {
                self.showAlert(title: "请登录", subtitle: "")
                return false
            }
        }
        return true
    }
}
    
extension LS_TabBarViewController: ShowDetail {
    func showDetail() {
        print("hello")
        
        self.navigationController?.pushViewController(NoteDetailViewController(), animated: true)
    }
    
    
}
