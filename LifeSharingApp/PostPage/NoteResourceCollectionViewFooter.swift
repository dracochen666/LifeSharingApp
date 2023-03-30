//
//  NoteResourceCollectionViewFooter.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/30.
//

import UIKit
import Anchorage

class NoteResourceCollectionViewFooter: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
//        button.backgroundColor = .clear
        button.tintColor = .systemGray3
        return button
    }()
    

    func setupUI() {
        self.addSubview(button)
        button.layer.cornerRadius = kGlobalCornerRadius
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor

        button.leftAnchor /==/ self.leftAnchor
        button.rightAnchor /==/ self.rightAnchor
        button.topAnchor /==/ self.topAnchor + kCustomGlobalMargin/2
        button.bottomAnchor /==/ self.bottomAnchor - kCustomGlobalMargin/2
    }
}
