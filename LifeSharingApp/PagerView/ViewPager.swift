//
//  ViewPager.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/20.
//

import UIKit
import Anchorage

class ViewPager: UIView {

    init(sizeConfiguration: TabbedView.SizeConfiguration,_ isTopicViewHidden: Bool = true) {
        self.sizeConfiguration = sizeConfiguration
        self.isTopicViewHidden = isTopicViewHidden
        super.init(frame: .zero)
        tabbedView.delegate = self
        pagedView.delegate = self
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    public var pagedView = PagedView()
    public let sizeConfiguration: TabbedView.SizeConfiguration
    public lazy var tabbedView: TabbedView = {
        let tabbedView = TabbedView(sizeConfiguration: sizeConfiguration)
        return tabbedView
    }()
    var isTopicViewHidden = true
    public lazy var topicView: DropDownMenuView = {
        let topicView = DropDownMenuView()
        return topicView
    }()
    
    //MARK: 自定义方法
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tabbedView)
        self.addSubview(pagedView)
        topicView.isHidden = isTopicViewHidden

        tabbedView.leftAnchor /==/ self.leftAnchor
        tabbedView.rightAnchor /==/ self.rightAnchor
        tabbedView.topAnchor /==/ self.topAnchor
        tabbedView.heightAnchor /==/ self.sizeConfiguration.height
        
        if isTopicViewHidden {
            pagedView.horizontalAnchors == self.horizontalAnchors
            pagedView.topAnchor == self.tabbedView.bottomAnchor + 5
            pagedView.bottomAnchor == self.bottomAnchor
        }else {
            self.addSubview(topicView)
            topicView.horizontalAnchors == self.horizontalAnchors + 40
            topicView.topAnchor == self.tabbedView.bottomAnchor + 5
            topicView.heightAnchor == 30
            
            pagedView.horizontalAnchors == self.horizontalAnchors
            pagedView.topAnchor == self.topicView.bottomAnchor
            pagedView.bottomAnchor == self.bottomAnchor
        }


    }
    
}

extension ViewPager: TabbedViewDelegate, PagedViewDelegate {
    func didMoveToTab(at Index: Int) {
        self.pagedView.moveToPage(index: Index)
    }
    
    func didMoveToPage(Index: Int) {
        self.tabbedView.moveToTab(index: Index)
    }
    
    
}

