//
//  Extension-Label.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/3.
//

import UIKit

extension UILabel {
    convenience init(frame: CGRect, text: String = "label",textColor: UIColor = .systemGray3, bgColor:UIColor = UIColor.clear, font: CGFloat = 10, textAlignment: NSTextAlignment = .center) {
        self.init()
        self.frame = frame
        self.text = text
        self.textColor = textColor
        self.backgroundColor = bgColor
        self.font = .systemFont(ofSize: font)
        self.textAlignment = textAlignment
    }
}
