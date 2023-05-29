//
//  CommentTableViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/22.
//

import UIKit
import Anchorage

class CommentTableViewCell: UITableViewCell {

    //MARK: 初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var commentFromLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .secondaryLabel, bgColor: .clear, font: 18, textAlignment: .left)
        return label
    }()
    var commentLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 20, textAlignment: .left)
        return label
    }()
    func setupUI() {
        self.backgroundColor = UIColor(named: kThirdLevelColor)
        self.addSubview(commentFromLabel)
        self.addSubview(commentLabel)
        
        commentFromLabel.leftAnchor == self.leftAnchor
        commentFromLabel.widthAnchor == 80
        commentFromLabel.verticalAnchors == self.verticalAnchors
        
        commentLabel.leftAnchor == commentFromLabel.rightAnchor
        commentLabel.verticalAnchors == self.verticalAnchors
        commentLabel.rightAnchor == self.rightAnchor
//        commentLabel.edgeAnchors == self.edgeAnchors
        
    }
}
