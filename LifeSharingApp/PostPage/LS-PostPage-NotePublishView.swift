//
//  LS-PostPage-NotesPublishView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/28.
//

import UIKit
import Anchorage

class LS_PostPage_NotePublishView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    lazy var imageResourcesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var titleTextField: UITextField = {
       let textField = UITextField(frame: .zero, placeholder: "请填写标题")
        textField.textColor = .label
        return textField
    }()
    lazy var bodyTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.textColor = .label
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 8
        
        return textView
    }()
    
    
    //MARK: 自定义方法
    func setupUI() {
        self.backgroundColor = UIColor(named: "SecondaryMainColor")
        self.addSubview(imageResourcesCV)
        self.addSubview(titleTextField)
        self.addSubview(bodyTextView)
        
        imageResourcesCV.leftAnchor /==/ self.leftAnchor + customGlobalMargin
        imageResourcesCV.rightAnchor /==/ self.rightAnchor - customGlobalMargin
        imageResourcesCV.topAnchor /==/ self.topAnchor + customGlobalMargin
//        imageResourcesCV.bottomAnchor /==/ self.layoutMarginsGuide.bottomAnchor
        imageResourcesCV.heightAnchor /==/ 120

        titleTextField.leftAnchor /==/ self.leftAnchor + customGlobalMargin
        titleTextField.rightAnchor /==/ self.rightAnchor - customGlobalMargin
        titleTextField.topAnchor /==/ imageResourcesCV.bottomAnchor + customGlobalMargin

        bodyTextView.leftAnchor /==/ self.leftAnchor + customGlobalMargin
        bodyTextView.rightAnchor /==/ self.rightAnchor - customGlobalMargin
        bodyTextView.topAnchor /==/ self.titleTextField.bottomAnchor + customGlobalMargin
        bodyTextView.heightAnchor /==/ 200
        
    }

}

//MARK: 代理方法
extension LS_PostPage_NotePublishView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
}

extension LS_PostPage_NotePublishView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
