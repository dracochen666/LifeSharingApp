//
//  Extension-UIStackView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/3.
//

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal,
                     distribution: UIStackView.Distribution = .fill,
                     spacing: CGFloat = kCustomGlobalMargin/3,
                     bgColor: UIColor = .systemGray3,
                     isLayoutMargin: Bool = true,
                     layoutMargins: UIEdgeInsets = UIEdgeInsets(top: kCustomGlobalMargin/2, left: kCustomGlobalMargin/2, bottom: kCustomGlobalMargin/2, right: kCustomGlobalMargin/2),
                     cornerRadius: CGFloat = kGlobalCornerRadius) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.backgroundColor = bgColor
        self.isLayoutMarginsRelativeArrangement = isLayoutMargin
        self.layoutMargins = layoutMargins
        self.layer.cornerRadius = cornerRadius
        
    }
}
