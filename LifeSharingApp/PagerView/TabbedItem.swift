//
//  TabbedItem.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/20.
//

import UIKit
import Anchorage

class TabbedItem: UIView, TabItemProtocol {
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    var title: String = ""
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = title
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    //borderView作为选中TabItem下划线，在选中的情况下才添加至Self，默认情况不添加
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        
        return view
    }()
    
    //MARK: 自定义方法
    func setupUI() {
        self.addSubview(label)
        self.backgroundColor = kTabbedViewBgColor
        label.centerXAnchor /==/ self.centerXAnchor
        label.centerYAnchor /==/ self.centerYAnchor
        
    }
    
    //MARK: 代理方法
    func onSelected() {
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        self.addSubview(borderView)
        let borderViewConstraints = Anchorage.batch(active: false) {
            borderView.leftAnchor /==/ label.leftAnchor
            borderView.rightAnchor /==/ label.rightAnchor
            borderView.bottomAnchor /==/ self.bottomAnchor - 5
            borderView.heightAnchor /==/ 2

        }
        NSLayoutConstraint.activate(borderViewConstraints)
    }
    
    func onNotSelected() {
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray

        self.borderView.removeFromSuperview()
    }
    
    
}
