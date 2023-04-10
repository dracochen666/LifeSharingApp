//
//  UserPositionTableViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/10.
//

import UIKit
import Anchorage

class UserPositionTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var poiLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 16, textAlignment: .left)
        return label
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 12, textAlignment: .left)
        return label
    }()
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 0, bgColor: .clear, isLayoutMargin: true, cornerRadius: kGlobalCornerRadius)
        return stackView
    }()
    func setupUI() {
        self.addSubview(locationStackView)
        locationStackView.addArrangedSubview(poiLabel)
        locationStackView.addArrangedSubview(addressLabel)
        
        locationStackView.edgeAnchors == self.edgeAnchors + kCustomGlobalMargin
        
    }
}
