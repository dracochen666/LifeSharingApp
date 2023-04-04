//
//  TopicSelectionViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/4.
//

import UIKit
import Anchorage

class TopicSelectionViewController: UIViewController {

//    convenience init(){
//        self.init()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
  
    var pages: [UIView] = []
    var tabs: [TabbedItem] = []
    lazy var searchTextField: UITextField = {
        let searchView = UIView()
        let iv = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iv.tintColor = .darkGray
        searchView.addSubview(iv)
        iv.edgeAnchors == searchView.edgeAnchors + 5
        let textField = UITextField(frame: .zero, leftView: searchView, placeholder: "搜索更多有趣话题", bgColor: UIColor(named: kThirdLevelColor)!, font: 16)
        
        return textField
    }()
    lazy var viewPager: ViewPager = {
        let vp = ViewPager(sizeConfiguration: .fillEqually(height: 60))
        return vp
    }()

    func setupUI() {
        let tabItems = [TabbedItem(title: "美食"),
                        TabbedItem(title: "旅游"),
                        TabbedItem(title: "风景"),
                        TabbedItem(title: "摄影"),
                        TabbedItem(title: "汽车")]

        let view1 = UIView()
        view1.layer.cornerRadius = kGlobalCornerRadius
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        let view5 = UIView()
        
        viewPager.pagedView.pages = [view1, view2, view3, view4, view5]
        viewPager.tabbedView.tabs = tabItems
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        self.view.addSubview(searchTextField)
        self.view.addSubview(viewPager)
        
        //约束
        searchTextField.horizontalAnchors == self.view.horizontalAnchors + 20
        searchTextField.topAnchor == self.view.topAnchor + kCustomGlobalMargin
        searchTextField.heightAnchor == 40
        
        viewPager.horizontalAnchors == self.view.horizontalAnchors + 20
        viewPager.topAnchor == searchTextField.bottomAnchor + kCustomGlobalMargin
        viewPager.bottomAnchor == self.view.bottomAnchor
    }
}
