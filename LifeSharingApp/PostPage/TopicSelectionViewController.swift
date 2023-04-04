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

    func setupUI() {
        
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        self.view.addSubview(searchTextField)
        
        //约束
        searchTextField.horizontalAnchors == self.view.horizontalAnchors + 20
        searchTextField.topAnchor == self.view.topAnchor + kCustomGlobalMargin
        searchTextField.heightAnchor == 40
        
    }
}
