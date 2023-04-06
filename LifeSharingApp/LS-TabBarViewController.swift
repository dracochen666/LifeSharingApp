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
        if viewController is LS_PostPageViewController {
            
            //待做 用户登录判断，若未登录则不允许发布
 
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
//            picker.navigationBar.backgroundColor = UIColor(named: kSecondLevelColor)
//            picker.navigationBar.setBackgroundImage(UIImage(named: "image1"), for: .defaultPrompt)

            present(picker, animated: true, completion: nil)
            picker.didFinishPicking { [unowned picker] items, _ in
//                if let photo = items.singlePhoto {
//                    print(photo.fromCamera) // Image source (camera or library)
//                    print(photo.image) // Final image selected by the user
//                    print(photo.originalImage) // original image selected by the user, unfiltered
                for item in items {
                    switch item {
                    case let .photo(p: photo):
                        print("photo")
                    case let .video(v: video):
                        print("video")
                    }
                }
            picker.pushViewController(LS_PostPageViewController(), animated: true)
            }
            return false
        }
            return true
    }
}
    

