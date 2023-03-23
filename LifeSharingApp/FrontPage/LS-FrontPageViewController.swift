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
        let viewPager = ViewPager(sizeConfiguration: .fillEqually(height: 44, spacing: 0))
        
        let view1 = WaterFallView()
        let view2 = WaterFallView()
        let view3 = WaterFallView()
        
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
//        let pages = [v1,v2,v3]
//        let pageView = PagedView(pages: pages)
        self.view.backgroundColor = .systemBackground
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

//    override func calculateStretchedCellWidths(_ minimumCellWidths: [CGFloat], suggestedStretchedCellWidth: CGFloat, previousNumberOfLargeCells: Int) -> CGFloat {
//        return 10
//    }
    

}
