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
        let viewPager = ViewPager(sizeConfiguration: .fillEqually(height: 44, spacing: 0),false)
        
        viewPager.isTopicViewHidden = false
        viewPager.topicView.topicDelegate = self
//        let view1 = UIView()
        let view2 = NoteWaterFallView(requestType: .getAll)
        view2.showNoteDetailDelegate = self
        view2.isGetAll = true
        let view3 = UIView()
        
        viewPager.pagedView.pages = [view2,view3]
        viewPager.tabbedView.tabs = [
            TabbedItem(title: "推荐"),
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

extension LS_FrontPageViewController: PassTopicDelegate {
    func passTopic(topic: String) {
        let view = viewPager.pagedView.pages[0] as! NoteWaterFallView
        view.notes = []
        view.collectionView.reloadData()
        if topic == "全部" {
            view.getNotes(0,false,topic,requestType: .getAll)
            return
        }
        view.getNotes(0,false,topic,requestType: .getTopicRelated)

    }
}
