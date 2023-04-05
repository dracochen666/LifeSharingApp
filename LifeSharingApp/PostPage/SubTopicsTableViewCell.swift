//
//  SubTopicsTableViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/4.
//

import UIKit
import Anchorage

class SubTopicsTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var subTopicLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 30, textAlignment: .left)
        return label
    }()
    
    func setupUI() {
        self.addSubview(subTopicLabel)
        self.backgroundColor = .clear
        subTopicLabel.edgeAnchors == self.edgeAnchors
    }
    
    
}
