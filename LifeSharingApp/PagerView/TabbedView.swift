//
//  TabbedView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/19.
//

import UIKit
import Anchorage

protocol TabbedViewDelegate: AnyObject {
    func didMoveToTab(at Index: Int)
}

class TabbedView: UIView {
    

    enum SizeConfiguration {
            case fillEqually(height: CGFloat, spacing: CGFloat = 0)
            case fixed(width: CGFloat, height: CGFloat, spacing: CGFloat = 0)
            
            var height: CGFloat {
                switch self {
                case let .fillEqually(height, _):
                    return height
                case let .fixed(_, height, _):
                    return height
                }
            }
    }
    
    //MARK: 初始化方法
    init(sizeConfiguration: SizeConfiguration, tabs: [TabItemProtocol] = []) {
        self.sizeConfiguration = sizeConfiguration
        self.tabs = tabs
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    weak var delegate: TabbedViewDelegate?
    var sizeConfiguration: SizeConfiguration
    public lazy var collectionView: UICollectionView = {//显示TabItem
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = .zero
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .red
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TabbedCollectionViewCell.self, forCellWithReuseIdentifier: "TabbedCollectionViewCell")
        
        return collectionView
    }()
    private var currentlySelectedIndex: Int = 0 //记录当前选中的下标
    //存储TabView的每个TabItem的View，该View必须遵循TabItemProtocol的类
    var tabs: [TabItemProtocol] {
        didSet {//赋值后刷新collectionView、根据currentlySelectedIndex初始化状态
            self.tabs[self.currentlySelectedIndex].onSelected()
            self.delegate?.didMoveToTab(at: currentlySelectedIndex)
            self.collectionView.reloadData()

        }
    }
    //MARK: 自定义方法区
    func setupUI() {
        
        self.addSubview(collectionView)
        self.backgroundColor = kTabbedViewBgColor
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor /==/ self.leftAnchor + 80
        collectionView.rightAnchor /==/ self.rightAnchor - 80
        collectionView.topAnchor /==/ self.topAnchor
        collectionView.bottomAnchor /==/ self.bottomAnchor
        
    }
    func moveToTab(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        self.tabs[currentlySelectedIndex].onNotSelected()
        self.tabs[index].onSelected()
        self.currentlySelectedIndex = index
        
    }
    
    
    
}

//MARK: 代理方法区
//设置collectionView在某时机的动作
extension TabbedView: UICollectionViewDelegate {
    //用户点击某Item后
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //改变视图
        moveToTab(index: indexPath.item)
        //调用代理方法通知委托人执行操作
        self.delegate?.didMoveToTab(at: indexPath.item)
    }
}

//设置collectionView的item数、具体item实例
extension TabbedView: UICollectionViewDataSource {
    //DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabbedCollectionViewCell", for: indexPath) as! TabbedCollectionViewCell
        cell.view = tabs[indexPath.item]
        return cell
    }
}
//need review
extension TabbedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sizeConfiguration {
        case let .fillEqually(height, spacing):
//            let totalWidth = self.frame.width
//            print(self.collectionView.frame.width / CGFloat(tabs.count))
            let totalWidth = self.collectionView.frame.width
            let widthPerItem = (
                totalWidth - (
                    spacing * CGFloat((self.tabs.count + 1))
                )
            ) / CGFloat(self.tabs.count)
            return CGSize(width: widthPerItem,
                          height: height)
            
        case let .fixed(width, height, spacing):
            return CGSize(width: width - (spacing * 2),
                          height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch sizeConfiguration {
        case let .fillEqually(_, spacing),
             let .fixed(_, _, spacing):
            
            return spacing
        }
    }
}
