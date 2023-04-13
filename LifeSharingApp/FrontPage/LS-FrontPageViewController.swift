//
//  LS-FrontPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage

protocol ShowDetail: AnyObject {
    func showDetail()
}
class LS_FrontPageViewController:UIViewController, PagedViewDelegate {
    func didMoveToPage(Index: Int) {
        print(Index)
    }
    
    var showDelegate: ShowDetail?
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(sizeConfiguration: .fillEqually(height: 44, spacing: 0))
        
        let view1 = WaterFallView()
        let view2 = WaterFallView()
        view2.showNoteDetailDelegate = self
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
        self.view.backgroundColor = kTabbedViewBgColor
        self.setupUI()
    }
    
    
    //MARK: 自定义方法区
    func setupUI() {
        self.view.addSubview(viewPager)

        viewPager.leftAnchor /==/ self.view.safeAreaLayoutGuide.leftAnchor
        viewPager.rightAnchor /==/ self.view.safeAreaLayoutGuide.rightAnchor
        viewPager.topAnchor /==/ self.view.safeAreaLayoutGuide.topAnchor - 20
        viewPager.bottomAnchor /==/ self.view.safeAreaLayoutGuide.bottomAnchor

    }


    

}

extension LS_FrontPageViewController: ShowNoteDetailDelegate {
    func showDetail() {
        self.showDelegate?.showDetail()
    }
    
    
}
