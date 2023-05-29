//
//  DropDownMenuCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/27.
//

import UIKit
import Anchorage

class DropDownMenuCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var label: UILabel = {
        let label = UILabel(frame: .zero, text: "话题", textColor: .label, bgColor: .clear, font: 16, textAlignment: .center)
        
        return label
    }()
    
    func setupUI() {

        self.addSubview(label)
        self.backgroundColor = UIColor(named: kThirdLevelColor)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        label.edgeAnchors == self.edgeAnchors + 3
    }
    
    
}
