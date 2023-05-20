//
//  PagerTestViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/20.
//

import UIKit
import Anchorage

class PagerTestViewController: UIViewController {
    
    let viewPager: ViewPager = {
        let viewPager = ViewPager(sizeConfiguration: .fillEqually(height: 44, spacing: 0))
        
        let view1 = NoteWaterFallView(requestType: .getAll)
        let view2 = NoteWaterFallView(requestType: .getAll)
        let view3 = NoteWaterFallView(requestType: .getAll)
        
        viewPager.pagedView.pages = [view1,view2,view3]
        viewPager.tabbedView.tabs = [
            TabbedItem(title: "关注"),
            TabbedItem(title: "发现"),
            TabbedItem(title: "附近")
        ]
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(viewPager)
        
        let viewPagerConstraints = Anchorage.batch(active: false) {
            viewPager.leftAnchor /==/ self.view.leftAnchor
            viewPager.rightAnchor /==/ self.view.rightAnchor
            viewPager.bottomAnchor /==/ self.view.bottomAnchor - 50
            viewPager.topAnchor /==/ self.view.topAnchor + 50

        }
        NSLayoutConstraint.activate(viewPagerConstraints)
//        NSLayoutConstraint.activate([
//                    viewPager.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                    viewPager.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7),
//                    viewPager.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                    viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
//                ])
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.navigationItem.title = "ViewPager"
//
//        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .systemBlue
//        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }

}
