//
//  Extension-UIButton.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/24.
//

import UIKit

extension UIButton {
    
    convenience init(frame: CGRect = .zero, title: String = "按钮", bgColor: UIColor = .systemBlue, cornerRadius: CGFloat) {
        self.init()
        self.frame = frame
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
    }
}
