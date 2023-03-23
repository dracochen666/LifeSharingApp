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
        self.backgroundColor = .systemBackground
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
        label.textColor = .label
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    //borderView作为选中TabItem下划线，在选中的情况下才添加至Self，默认情况不添加
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: 自定义方法
    func setupUI() {
        self.addSubview(label)
//        label.leftAnchor /==/ self.leftAnchor + 10
//        label.rightAnchor /==/ self.rightAnchor - 10
//        label.topAnchor /==/ self.topAnchor
//        label.bottomAnchor /==/ self.bottomAnchor
        label.centerXAnchor /==/ self.centerXAnchor
        label.centerYAnchor /==/ self.centerYAnchor
        
    }
    
    //MARK: 代理方法
    func onSelected() {
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        self.addSubview(borderView)
        let borderViewConstraints = Anchorage.batch(active: false) {
            borderView.leftAnchor /==/ self.leftAnchor
            borderView.rightAnchor /==/ self.rightAnchor
            borderView.bottomAnchor /==/ self.bottomAnchor
            borderView.heightAnchor /==/ 2

        }
        NSLayoutConstraint.activate(borderViewConstraints)
    }
    
    func onNotSelected() {
        label.font = .systemFont(ofSize: 15)

        self.borderView.removeFromSuperview()
    }
    
    
}
