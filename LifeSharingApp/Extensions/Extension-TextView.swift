//
//  Extension-TextView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/28.
//

import UIKit

extension UITextView {
    
    convenience init(frame: CGRect,
                     textColor: UIColor = .placeholderText,
                     bgColor: UIColor = .clear,
                     font: CGFloat = 15,
                     placeholder: String = "输入正文",
                     borderColor: CGColor = UIColor.systemGray3.cgColor,
                     borderWidth: CGFloat = 0.3,
                     cornerRadius: CGFloat = 8,
                     numberOfLines: Int = 10) {
        self.init()
        self.frame = frame
        self.textColor = textColor
        self.backgroundColor = bgColor
        self.text = placeholder
        self.textContainer.maximumNumberOfLines = numberOfLines
        self.font = .systemFont(ofSize: font)
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        
        
    }
    
}
