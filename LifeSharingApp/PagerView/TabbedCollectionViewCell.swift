//
//  TabbedCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/19.
//

import UIKit

protocol TabItemProtocol: UIView {
    //两种状态切换
    func onSelected()
    func onNotSelected()
}

class TabbedCollectionViewCell: UICollectionViewCell {
    
    //MARK: 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量
    //作为每个Cell中的View，这个view必须遵循TabItemProtocol协议实现选中和未选中方法
    public var view: TabItemProtocol? {
        didSet {
            self.setupUI()
        }
    }
    var leftConstraint = NSLayoutConstraint()
    var topConstraint = NSLayoutConstraint()
    var rightConstraint = NSLayoutConstraint()
    var bottomConstraint = NSLayoutConstraint()
    //contentInsets设置属性后，所有约束都会相应更新。
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0
    ) {
        didSet {
            leftConstraint.constant = contentInsets.left
            topConstraint.constant = contentInsets.top
            rightConstraint.constant = -contentInsets.right
            bottomConstraint.constant = -contentInsets.bottom
            self.contentView.layoutIfNeeded()
        }
    }
    
    //MARK: 自定义方法
    func setupUI() {
        guard let view = view else { return }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        leftConstraint = view.leftAnchor
            .constraint(equalTo: self.leftAnchor,
                        constant: contentInsets.left)
        topConstraint = view.topAnchor
            .constraint(equalTo: self.topAnchor,
                        constant: contentInsets.top)
        rightConstraint = view.rightAnchor
            .constraint(equalTo: self.rightAnchor,
                        constant: -contentInsets.right)
        bottomConstraint = view.bottomAnchor
            .constraint(equalTo: self.bottomAnchor,
                        constant: -contentInsets.bottom)
        
        NSLayoutConstraint.activate([
            leftConstraint,
            topConstraint,
            rightConstraint,
            bottomConstraint
        ])
    }
}
