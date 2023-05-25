//
//  DraftWaterFallCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/10.
//

import UIKit
import Anchorage

class DraftWaterFallCollectionViewCell : UICollectionViewCell {
    static let identifier = "DraftWaterFallCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var draftNote: DraftNote? {
        didSet {
            guard let draftNote = draftNote else { return }
            
            titleLabel.text = draftNote.noteTitle!.isEmpty ? "无标题" : draftNote.noteTitle
            if #available(iOS 15.0, *) {
                dateLabel.text = draftNote.createTime?.formatted()
            } else {
                dateLabel.text = draftNote.createTime?.description
                
            }
            imageView.image = UIImage(data: draftNote.noteCoverPhoto)
            
            
        }
    }
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds =  true

        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "旅游风景照片", textColor: .label, bgColor: .clear, font: 14, textAlignment: .left)
        
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "5-15", textColor: .systemGray, bgColor: .clear, font: 14, textAlignment: .left)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let btn = UIButton(frame: .zero, tintColor: .systemRed, title: "", bgColor: .clear, cornerRadius: 8)
        btn.setImage(UIImage(systemName: "x.square.fill"), for: .normal)
        return btn
    }()
    
    lazy var noteInfoStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, spacing: 0, bgColor: .clear, isLayoutMargin: false, cornerRadius: kGlobalCornerRadius)
        return stackView
    }()
    lazy var noteStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 0, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: false, cornerRadius: kGlobalCornerRadius)
//        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    func setupUI() {
        self.clipsToBounds = true
        self.addSubview(noteStackView)
        
        noteInfoStackView.addArrangedSubview(dateLabel)
        noteInfoStackView.addArrangedSubview(deleteButton)
        
        noteStackView.addArrangedSubview(imageView)
        noteStackView.addArrangedSubview(titleLabel)
        noteStackView.addArrangedSubview(noteInfoStackView)
        
        noteStackView.edgeAnchors == self.edgeAnchors
        
        imageView.heightAnchor == self.frame.size.height * 0.85

    }
    func configure(image: UIImage) {
        self.imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
