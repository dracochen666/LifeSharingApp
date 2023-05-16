//
//  CustomTextField.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/24.
//

import UIKit

extension UITextField {
    
    var unwrappedText: String { text ?? "" }
    var exactText: String { unwrappedText.isBlank ? "" : unwrappedText }
    
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
    
    convenience init(frame: CGRect, leftView: UIView,
                     textColor: UIColor = .label,
                     placeholder: String = "",
                     bgColor: UIColor = .clear,
                     font: CGFloat = 16) {
        self.init(frame: frame, textColor: textColor, bgColor: bgColor, font: font, placeholder: placeholder)
        
        self.leftView = leftView
        self.leftViewMode = .always
        self.layer.cornerRadius = 20
        self.borderStyle = .none
    }
    
    
}
