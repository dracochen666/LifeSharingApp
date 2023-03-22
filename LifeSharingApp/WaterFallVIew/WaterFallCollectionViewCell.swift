//
//  WaterFallCollectionViewCell.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/21.
//

import UIKit
import Anchorage

class WaterFallCollectionViewCell: UICollectionViewCell {
    
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
        return imageView
    }()
    
    func setupUI() {
        self.addSubview(imageView)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        imageView.leftAnchor /==/ self.leftAnchor
        imageView.rightAnchor /==/ self.rightAnchor
        imageView.topAnchor /==/ self.topAnchor
        imageView.bottomAnchor /==/ self.bottomAnchor

    }
    func configure(image: UIImage) {
        imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
