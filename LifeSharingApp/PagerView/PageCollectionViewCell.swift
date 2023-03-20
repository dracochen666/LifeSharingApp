//
//  PageCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/19.
//

import UIKit
import Anchorage

class PageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //创建view作为Cell的主要视图。view为计算属性，在view被赋值后会再次调用setupUI，便会添加至Cell内部并添加约束。
    public var view: UIView? {
        didSet{
            self.setupUI()
        }
    }
    
    func setupUI() {
        guard let view = view else { return }
        
        self.contentView.addSubview(view)
        
        view.widthAnchor /==/ self.contentView.widthAnchor
        view.heightAnchor /==/ self.contentView.heightAnchor
        view.centerXAnchor /==/ self.contentView.centerXAnchor
        view.centerYAnchor /==/ self.contentView.centerYAnchor
    }
}
