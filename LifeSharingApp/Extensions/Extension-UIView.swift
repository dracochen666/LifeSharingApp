//
//  Extension-UIView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/9.
//

import UIKit

extension UIView {
    convenience init(frame: CGRect, bgColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        self.frame = frame
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
    }

}
