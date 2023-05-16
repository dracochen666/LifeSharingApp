//
//  LS-PostPage-NotesPublishView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/28.
//

import UIKit
import Anchorage
import YPImagePicker

class LS_PostPage_NotePublishView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    var photos = [UIImage(named: "image0"), UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3"), UIImage(named: "image4")]
    lazy var imageResourcesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.footerReferenceSize = CGSize(width: 120, height: 120)
        layout.sectionInset = .init(top: 0, left: kCustomGlobalMargin - 3, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: kThirdLevelColor)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(NoteResourceCollectionViewCell.self, forCellWithReuseIdentifier: "NoteResourceCollectionViewCell")
        collectionView.register(NoteResourceCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "NoteResourceCollectionViewFooter")
        collectionView.layer.cornerRadius = kGlobalCornerRadius
        
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
    //存储传入笔记图片数量
    var photoCount: Int { photos.count }
    
    
    //MARK: 自定义方法
    func setupUI() {
        self.backgroundColor = UIColor(named: kSecondLevelColor)
        self.addSubview(imageResourcesCV)
        self.addSubview(titleTextField)
        self.addSubview(bodyTextView)
        
        imageResourcesCV.leftAnchor /==/ self.leftAnchor + kCustomGlobalMargin
        imageResourcesCV.rightAnchor /==/ self.rightAnchor - kCustomGlobalMargin
        imageResourcesCV.topAnchor /==/ self.topAnchor + kCustomGlobalMargin
//        imageResourcesCV.bottomAnchor /==/ self.layoutMarginsGuide.bottomAnchor
        imageResourcesCV.heightAnchor /==/ 130

        titleTextField.leftAnchor /==/ self.leftAnchor + kCustomGlobalMargin
        titleTextField.rightAnchor /==/ self.rightAnchor - kCustomGlobalMargin
        titleTextField.topAnchor /==/ imageResourcesCV.bottomAnchor + kCustomGlobalMargin

        bodyTextView.leftAnchor /==/ self.leftAnchor + kCustomGlobalMargin
        bodyTextView.rightAnchor /==/ self.rightAnchor - kCustomGlobalMargin
        bodyTextView.topAnchor /==/ self.titleTextField.bottomAnchor + kCustomGlobalMargin
        bodyTextView.heightAnchor /==/ 200
        
    }

}

//MARK: 代理方法
extension LS_PostPage_NotePublishView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteResourceCollectionViewCell", for: indexPath) as! NoteResourceCollectionViewCell

        cell.configure(image: photos[indexPath.row]!)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NoteResourceCollectionViewFooter", for: indexPath) as! NoteResourceCollectionViewFooter
        footer.button.setImage(UIImage(systemName: "plus"), for: .normal)
        footer.button.addTarget(self, action: #selector(addMore), for: .touchUpInside)
        
        return footer
    }
}

extension LS_PostPage_NotePublishView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    

}

//点击事件
extension LS_PostPage_NotePublishView {
    @objc private func addMore() {
        if photoCount < kPickerMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            config.albumName = "iSHARE Library"
            config.screens = [.library]
            //相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kPickerMaxPhotoCount - photoCount
            config.library.preSelectItemOnMultipleSelection = false
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                
                if let photo = items.singlePhoto {
                    print(photo.fromCamera) // Image source (camera or library)
                    print(photo.image) // Final image selected by the user
                    print(photo.originalImage) // original image selected by the user, unfiltered
                }
                picker.pushViewController(NoteEditViewController(), animated: true)
                
            }
            
//            present(picker, animated: true, completion: nil)
            
        }else {
            
        }
    }
}
