//
//  TopicSelectionViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/4.
//

import UIKit
import Anchorage

protocol PassValueFromTopicSelectViewController: AnyObject {
    func passSubTopic(topic:String, subTopic: String)
}

class TopicSelectionViewController: UIViewController {
    

    convenience init(isSearchViewVisable: Bool){
        self.init()
        self.isSearchViewVisable = isSearchViewVisable
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToEndEditing))
        tap.cancelsTouchesInView = false
        self.viewPager.addGestureRecognizer(tap)
        setupUI()
    }

    var isSearchViewVisable: Bool? = false
    //服务端传入(话题分类)tabs
    var topicsData: Topic = Topic(topics: kTopics, subTopics: kSubTopics)
    var tabs: [TabbedItem] = []
    //根据服务端传入的tabs数量生成pages，每个page中显示该话题分类的具体话题
    var pages: [UIView] = []
    weak var passSubTopicFromVCDelegate: PassValueFromTopicSelectViewController?
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
        let vp = ViewPager(sizeConfiguration: .fillEqually(height: 50))
        return vp
    }()

    func setupUI() {
        //固定数据用于测试
        let tabItems: [TabbedItem] = {
            var items: [TabbedItem] = []
            for topic in topicsData.topics {
                items.append(TabbedItem(title: topic))
            }
            return items
        }()

        let views: [SubTopicsTableView] = {
            var views: [SubTopicsTableView] = []
            let indexs = topicsData.topics.count
            for index in 0..<indexs {
                let topic = topicsData.topics[index]
                let subTopicsIn = topicsData.findSubTopicsInSubTopicsByTopic(topic: topic)
                let view = SubTopicsTableView(frame: .zero)
                view.topic = topic

                view.subTopics = subTopicsIn
                print(subTopicsIn)
                view.passSubTopicFromTVDelegate = self
                views.append(view)
            }
            return views
        }()
        viewPager.pagedView.pages = views
        viewPager.pagedView.collectionView.backgroundColor = .clear
        viewPager.tabbedView.tabs = tabItems
        viewPager.tabbedView.collectionView.isScrollEnabled = true
        
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        if isSearchViewVisable! {
            self.view.addSubview(searchTextField)
            self.view.addSubview(viewPager)
            searchTextField.horizontalAnchors == self.view.horizontalAnchors + 20
            searchTextField.topAnchor == self.view.topAnchor + kCustomGlobalMargin 
            searchTextField.heightAnchor == 40
            viewPager.horizontalAnchors == self.view.horizontalAnchors + 10
            viewPager.topAnchor == searchTextField.bottomAnchor + kCustomGlobalMargin
            viewPager.bottomAnchor == self.view.bottomAnchor
        }else{
            self.view.addSubview(viewPager)
            viewPager.horizontalAnchors == self.view.horizontalAnchors + 10
            viewPager.topAnchor == self.view.topAnchor + kCustomGlobalMargin
            viewPager.bottomAnchor == self.view.bottomAnchor
        }


    }
}


//MARK: 代理方法
////代理方法
//extension TopicSelectionViewController: UITextFieldDelegate {
//
//}

//自定义代理方法
extension TopicSelectionViewController: PassValueFromSubTopicsTableView {
    func passSubTopic(topic: String, subTopic: String) {
        self.passSubTopicFromVCDelegate?.passSubTopic(topic: topic, subTopic: subTopic)

    }
    
}

//MARK: 点击事件
extension TopicSelectionViewController {
    @objc func tapToEndEditing() {
        self.view.endEditing(false)
    }
}
