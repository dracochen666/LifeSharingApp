//
//  LS-FrontPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage

class LS_FrontPageViewController:UIViewController, PagedViewDelegate {
    func didMoveToPage(Index: Int) {
        print(Index)
    }
    
    let viewPager: ViewPager = {
        let viewPager = ViewPager(sizeConfiguration: .fillEqually(height: 44,spacing: 0))
        
        let view1 = WaterFallView()
//        view1.collectionView.backgroundColor = .white
        let view2 = WaterFallView()
//        view2.collectionView.backgroundColor = .blue
        let view3 = WaterFallView()
//        view3.collectionView.backgroundColor = .green
        
        viewPager.pagedView.pages = [view1,view2,view3]
        viewPager.tabbedView.tabs = [
            TabbedItem(title: "关注"),
            TabbedItem(title: "发现"),
            TabbedItem(title: "附近")
        ]
        
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kTabbedViewBgColor
        self.setupUI()
    }
    
    
    //MARK: 自定义方法区
    func setupUI() {
        self.view.addSubview(viewPager)

        viewPager.leftAnchor /==/ self.view.safeAreaLayoutGuide.leftAnchor
        viewPager.rightAnchor /==/ self.view.safeAreaLayoutGuide.rightAnchor
        viewPager.topAnchor /==/ self.view.safeAreaLayoutGuide.topAnchor - 15
        viewPager.bottomAnchor /==/ self.view.safeAreaLayoutGuide.bottomAnchor

    }


    

}
