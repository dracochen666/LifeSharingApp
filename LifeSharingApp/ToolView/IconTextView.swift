//
//  IconTextView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/3.
//

import UIKit
import Anchorage

class IconTextView: UIView {


    init(image: UIImage, text: String) {
        super.init(frame: .zero)
        
        self.imageView.image = image
        self.label.text = text
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var image: UIImage?
    var text: String?
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
        let stackView = UIStackView(axis: .horizontal, distribution: .equalCentering, spacing: 0, bgColor: .systemGray3)
        return stackView
    }()
    
    private func setupUI(){
        self.addSubview(stackView)
//        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        stackView.leftAnchor == self.leftAnchor
        stackView.rightAnchor == self.rightAnchor
        stackView.topAnchor == self.topAnchor
        stackView.bottomAnchor == self.bottomAnchor
        


    }
}
