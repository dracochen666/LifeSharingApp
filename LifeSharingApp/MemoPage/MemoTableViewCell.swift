//
//  MemoTableViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit
import Anchorage

class MemoTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

//MARK: 初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区

    lazy var checkBtn: UIButton = {
        let btn = UIButton(frame: .zero, tintColor: .systemBlue, buttonType: .system, title: "", bgColor: .clear, cornerRadius: 8)
        
        btn.setImage(UIImage(systemName: "circle"), for: .normal)
//        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView!.edgeAnchors == btn.edgeAnchors + 5
        
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    lazy var memoLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 30, textAlignment: .left)
        return label
    }()
    
//MARK: 自定义方法
    func setupUI() {
        self.accessoryType = .disclosureIndicator
        self.addSubview(checkBtn)
        self.addSubview(memoLabel)
        
//        checkBtn.rightAnchor == self.rightAnchor - 100
        checkBtn.widthAnchor == 50
        checkBtn.leftAnchor == self.leftAnchor
        checkBtn.topAnchor == self.topAnchor
        checkBtn.bottomAnchor == self.bottomAnchor
        
        memoLabel.leftAnchor == checkBtn.rightAnchor + 10
        memoLabel.rightAnchor == self.rightAnchor
        memoLabel.verticalAnchors == self.verticalAnchors
    }
}


