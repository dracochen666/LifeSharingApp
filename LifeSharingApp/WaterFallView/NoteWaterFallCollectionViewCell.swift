//
//  NoteWaterFallCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit
import Anchorage

class NoteWaterFallCollectionViewCell: UICollectionViewCell {
    static let identifier = "WaterFallCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds =  true
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "旅游风景照片", textColor: .label, bgColor: .clear, font: 14, textAlignment: .left)
        
        return label
    }()
    lazy var idLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "用户ID:1234", textColor: .systemGray, bgColor: .clear, font: 14, textAlignment: .left)
        
        return label
    }()
    lazy var iconTextView: IconTextView = {
        let image = UIImage(systemName: "heart")!
        let view = IconTextView(image: image, text: "999+",textColor: .systemGray, tintColor: .systemGray, bgColor: .clear, direction: .iconText)
        
        return view
    }()
    lazy var noteInfoStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, distribution: .fill, spacing: 0, bgColor: .clear, isLayoutMargin: false, cornerRadius: kGlobalCornerRadius)
        return stackView
    }()
    lazy var noteStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 0, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: false, cornerRadius: kGlobalCornerRadius)
        return stackView
    }()
    
    func setupUI() {
        self.clipsToBounds = true
        self.addSubview(noteStackView)
        noteInfoStackView.addArrangedSubview(idLabel)
        noteInfoStackView.addArrangedSubview(iconTextView)
        
        noteStackView.addArrangedSubview(imageView)
        noteStackView.addArrangedSubview(titleLabel)
        noteStackView.addArrangedSubview(noteInfoStackView)
        
        noteStackView.edgeAnchors == self.edgeAnchors
        
        imageView.heightAnchor == self.frame.size.height * 3 / 4

    }
    func configure(image: UIImage) {
        self.imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
