//
//  CustomTextField.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/24.
//

import UIKit

extension UITextField {
    
    convenience init(frame: CGRect, placeholder: String = "", borderStyle: UITextField.BorderStyle = .roundedRect, isSecureTextEntry: Bool = false ) {
        self.init()
        self.backgroundColor = .clear
        self.frame = frame
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.isSecureTextEntry = isSecureTextEntry
    }
    
}
