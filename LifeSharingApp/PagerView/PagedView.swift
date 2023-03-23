//
//  PagedView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/18.
//

import UIKit
import Anchorage

//PagedView的代理协议，当PagedView实例发生变化时，通过代理方法通知遵循协议的委托人
protocol PagedViewDelegate: AnyObject {
    func didMoveToPage(Index: Int)
}

class PagedView: UIView, UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {

    //MARK: 初始化方法
//    init() {
//        super.init(frame: .zero)
//
//        self.setupUI()
//    }
//
    init(pages: [WaterFallView] = []) {//增加pages变量的初始化方法
        self.pages = pages
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    weak var delegate: PagedViewDelegate?
    private lazy var collectionView: UICollectionView = {//使用lazy声明闭包可以避免循环引用以便在闭包内使用self。原因：lazy修饰的变量在self初始化之后才有可能被初始化，这样就不会出现self初始化过程中,自身内部闭包中又调用self本身。
        //初始化collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: "PageCollectionViewCell")
        
        return collectionView
    }()
    //页面数组pages用于存储页面。根据pages的count和item分别设置collectionview的页数和页面内容。
    public var pages: [WaterFallView] {
        didSet {
            //当赋值后执行collectionView.reloadData()以再次调用代理方法刷新数据
            self.collectionView.reloadData()
        }
    }
    
    //MARK: 自定义方法区
    //setupUI 添加collectionView到Self并添加约束
    func setupUI(){
        
        self.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.widthAnchor /==/ self.widthAnchor
        collectionView.heightAnchor /==/ self.heightAnchor
        collectionView.centerXAnchor /==/ self.centerXAnchor
        collectionView.centerYAnchor /==/ self.centerYAnchor
    }
    //moveToPage 进行collectionView中page的切换
    func moveToPage(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
//        self.collectionView.reloadData()
    }
    
    //MARK: DataSource 代理方法
    //返回页面总数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    //返回具体显示的Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as! PageCollectionViewCell
        cell.view = pages[indexPath.item]
        return cell
    }
    //调用时机：用户完成页面滑动后。通知self的代理（调用代理方法didMoveToPage(Index)）
    ///一旦用户完成滚动页面，获取页面索引并通知PagedView的委托。如前所述，委托可以是另一个视图或视图控制器。当我们想单独使用PagedView时，我们通常会让视图控制器成为委托。当使用一个尚未创建的ViewPager时，它包含PagedView和它上面的标签视图，ViewPager将充当PagedView的委托。
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        self.delegate?.didMoveToPage(Index: page)
    }
    
    //MARK: DelegateFlowlayout 代理方法
    //水平方向滚动情况下，minimumLineSpacing代表页水平间距 minimumInteritemSpacing代表页垂直间距。本次返回0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //返回每个Cell（每页）的大小。本次返回Collectionview的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width,
                              height: self.collectionView.frame.height)
    }
    
}
