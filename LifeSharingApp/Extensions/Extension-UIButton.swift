//
//  Extension-UIButton.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/24.
//

import UIKit

extension UIButton {
    
    convenience init(frame: CGRect = .zero,
                     tintColor: UIColor = .label, 
                     buttonType: ButtonType = .roundedRect,
                     title: String = "按钮",
                     bgColor: UIColor = .systemBlue,
                     cornerRadius: CGFloat) {
        self.init(type: buttonType)
        self.frame = frame
        self.tintColor = tintColor
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
    }
}
