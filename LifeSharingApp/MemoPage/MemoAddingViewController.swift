//
//  MemoAddingViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit
import Anchorage

class MemoAddingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        setupUI()
    }
    
    lazy var memoEditTextField: UITextField = {
        let textField = UITextField(frame: .zero, textColor: .label, bgColor: .clear, font: 24, placeholder: "", borderStyle: .roundedRect, isSecureTextEntry: false)
        
        return textField
    }()

    func setupUI() {
        self.view.addSubview(memoEditTextField)
        
        //约束
        memoEditTextField.horizontalAnchors == self.view.horizontalAnchors + kCustomGlobalMargin
        memoEditTextField.topAnchor == self.view.topAnchor + 100
        
    }
}
