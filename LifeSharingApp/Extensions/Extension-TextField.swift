//
//  CustomTextField.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/24.
//

import UIKit

extension UITextField {
    
    convenience init(frame: CGRect,
                     textColor: UIColor = .label,
                     bgColor: UIColor = .clear,
                     font: CGFloat = 16,
                     placeholder: String = "",
                     borderStyle: UITextField.BorderStyle = .roundedRect,
                     isSecureTextEntry: Bool = false ) {
        self.init()
        self.frame = frame
        self.textColor = textColor
        self.backgroundColor = bgColor
        self.font = .systemFont(ofSize: font)
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.isSecureTextEntry = isSecureTextEntry
        }
    
}
