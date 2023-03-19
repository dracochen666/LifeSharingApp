//
//  LS-TabBarController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/18.
//

import UIKit

class LS_TabViewController: UITabBarController {
    
    //    let tabBarVC = UITabBarController()
    let frontVC = LS_FrontPageViewController()
    let memoVC = LS_MemoPageViewController()
    let publishVC = LS_PostPageViewController()
    let messageVC = LS_MessagePageViewController()
    let aboutVC = LS_AboutPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        decorateBarItems()
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .lightGray
        self.setViewControllers([frontVC, memoVC, publishVC, messageVC, aboutVC], animated: true)
        
        class LS_TabViewController: UITabBarController {
            
            //    let tabBarVC = UITabBarController()
            let frontVC = LS_FrontPageViewController()
            let memoVC = LS_MemoPageViewController()
            let publishVC = LS_PostPageViewController()
            let messageVC = LS_MessagePageViewController()
            let aboutVC = LS_AboutPageViewController()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
                decorateBarItems()
                tabBar.backgroundColor = .systemBackground
                tabBar.tintColor = .lightGray
                self.setViewControllers([frontVC, memoVC, publishVC, messageVC, aboutVC], animated: true)
                
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
                
                //        let images = ["house","list.bullet","plus.rectangle.fill","message","gear"]
                //        guard let items = self.tabBar.items else {return}
                //        for i in 0..<items.count {
                //            items[i].image = UIImage(systemName: images[i])
                //        }
            }    }
        
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
            
            //        let images = ["house","list.bullet","plus.rectangle.fill","message","gear"]
            //        guard let items = self.tabBar.items else {return}
            //        for i in 0..<items.count {
            //            items[i].image = UIImage(systemName: images[i])
            //        }
        }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
