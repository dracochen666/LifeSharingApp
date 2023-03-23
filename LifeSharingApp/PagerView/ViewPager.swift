//
//  ViewPager.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/20.
//

import UIKit
import Anchorage

class ViewPager: UIView {

    init(sizeConfiguration: TabbedView.SizeConfiguration) {
        self.sizeConfiguration = sizeConfiguration
        
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
    
    //MARK: 自定义方法
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tabbedView)
        self.addSubview(pagedView)
        
        let tabbedViewconstraints = Anchorage.batch(active: false) {
            tabbedView.leftAnchor /==/ self.leftAnchor
            tabbedView.rightAnchor /==/ self.rightAnchor
            tabbedView.topAnchor /==/ self.topAnchor
            tabbedView.heightAnchor /==/ self.sizeConfiguration.height

        }
        let pagedViewconstraints = Anchorage.batch(active: false) {
            pagedView.leftAnchor /==/ self.leftAnchor
            pagedView.rightAnchor /==/ self.rightAnchor
            pagedView.bottomAnchor /==/ self.bottomAnchor
            pagedView.topAnchor /==/ self.tabbedView.bottomAnchor

        }
        
        NSLayoutConstraint.activate(tabbedViewconstraints)
        NSLayoutConstraint.activate(pagedViewconstraints)

    }
    
    
}

extension ViewPager: TabbedViewDelegate, PagedViewDelegate {
    func didMoveToTab(at Index: Int) {
        print("didMoveToTab")
        self.pagedView.moveToPage(index: Index)
    }
    
    func didMoveToPage(Index: Int) {
        self.tabbedView.moveToTab(index: Index)
    }
    
    
}
