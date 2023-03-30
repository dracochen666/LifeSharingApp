//
//  NoteResourceCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/28.
//

import UIKit
import Anchorage

class NoteResourceCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func configure(image: UIImage) {
        self.imageView.image = image
    }
    func setupUI() {
        self.addSubview(imageView)
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = kGlobalCornerRadius
        self.clipsToBounds = true
        
        imageView.leftAnchor /==/ self.leftAnchor
        imageView.rightAnchor /==/ self.rightAnchor
        imageView.topAnchor /==/ self.topAnchor
        imageView.bottomAnchor /==/ self.bottomAnchor

    }
}
