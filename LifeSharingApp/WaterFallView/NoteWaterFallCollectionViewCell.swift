//
//  NoteWaterFallCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit
import Anchorage

class NoteWaterFallCollectionViewCell: UICollectionViewCell {
//    static let identifier = "NoteWaterFallCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds =  true
        return imageView
    }()
    
    var note: Note? {
        didSet {
            guard let note = note else { return }
            titleLabel.text = note.noteTitle.isEmpty ? "无标题" : note.noteTitle
//            dateLabel.text = note.createTime?.formattedDate
            idLabel.text = "用户ID: \(note.noteOwner!)"
//            print(note.noteCoverPhoto!)
            iconTextView.label.text = "\(note.noteLikedNumber!)"
            if let coverPhotoData = note.noteCoverPhoto {
                imageView.image = UIImage(data: note.noteCoverPhoto)
            }else {
                imageView.image =  UIImage(systemName: "exclamationmark.icloud.fill")
            }

            
            
        }
    }
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
        let view = IconTextView(image: image, text: "",textColor: .systemGray, tintColor: .systemGray, bgColor: .clear, direction: .iconText)
        
        return view
    }()
    lazy var noteInfoStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, spacing: 0, bgColor: .clear, isLayoutMargin: false, cornerRadius: kGlobalCornerRadius)
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
