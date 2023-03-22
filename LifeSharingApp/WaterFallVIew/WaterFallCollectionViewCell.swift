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
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false 
        return view
    }()
    
    func setupUI() {
        self.addSubview(view)
        
        view.leftAnchor /==/ self.leftAnchor
        view.rightAnchor /==/ self.rightAnchor
        view.topAnchor /==/ self.topAnchor
        view.bottomAnchor /==/ self.bottomAnchor

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
