//
//  IconTextView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/3.
//

import UIKit
import Anchorage

class IconTextView: UIView {
    
    enum IconTextDirection {
        case iconText
        case textIcon
    }

    init(image: UIImage, text: String, bgColor: UIColor = .clear, direction: IconTextDirection = .iconText) {
        super.init(frame: .zero)
        self.imageView.image = image
        self.label.text = text
        self.stackView.backgroundColor = bgColor
        self.iconTextDirection = direction
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var image: UIImage?
    var text: String?
    var bgColor: UIColor?
    var iconTextDirection: IconTextDirection = .iconText
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero, text: "TEXT", textColor: .label, bgColor: .clear, font: 14)
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, distribution: .fill, spacing: 0, layoutMargins:  UIEdgeInsets(top: kCustomGlobalMargin/2, left: kCustomGlobalMargin/2, bottom: kCustomGlobalMargin/2, right: kCustomGlobalMargin/2 + 5))
        return stackView
    }()
    
    private func setupUI(){
        self.addSubview(stackView)

        if iconTextDirection == .iconText {
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(label)
        }else {
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(imageView)
        }
        
        stackView.leftAnchor == self.leftAnchor
        stackView.rightAnchor == self.rightAnchor
        stackView.topAnchor == self.topAnchor
        stackView.bottomAnchor == self.bottomAnchor
        
    }
}
