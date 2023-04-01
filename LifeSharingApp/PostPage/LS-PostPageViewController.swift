//
//  LS-PostPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage
import YPImagePicker
import MBProgressHUD

class LS_PostPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        self.notePublishView.addGestureRecognizer(tap)
//        self.navigationController?.navigationItem.leftBarButtonItem.ad
//        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: 变量区
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = self.view.frame.size
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
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

    var notePublishView = UIView(frame: .zero)

    
    //MARK: 自定义方法
    func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(notePublishView)
        notePublishView.backgroundColor = UIColor(named: kSecondLevelColor)
        notePublishView.addSubview(imageResourcesCV)
        notePublishView.addSubview(titleTextField)
        notePublishView.addSubview(bodyTextView)
        
        
        scrollView.leftAnchor /==/ self.view.leftAnchor
        scrollView.rightAnchor /==/ self.view.rightAnchor
        scrollView.topAnchor /==/ self.view.topAnchor + 50
        scrollView.bottomAnchor /==/ self.view.bottomAnchor
        
        notePublishView.centerXAnchor /==/ scrollView.centerXAnchor
        notePublishView.centerYAnchor /==/ scrollView.centerYAnchor
        notePublishView.widthAnchor /==/ scrollView.widthAnchor
        notePublishView.heightAnchor /==/ scrollView.heightAnchor
        
        imageResourcesCV.leftAnchor /==/ notePublishView.leftAnchor + kCustomGlobalMargin
        imageResourcesCV.rightAnchor /==/ notePublishView.rightAnchor - kCustomGlobalMargin
        imageResourcesCV.topAnchor /==/ notePublishView.topAnchor + kCustomGlobalMargin
        imageResourcesCV.heightAnchor /==/ 130

        titleTextField.leftAnchor /==/ notePublishView.leftAnchor + kCustomGlobalMargin
        titleTextField.rightAnchor /==/ notePublishView.rightAnchor - kCustomGlobalMargin
        titleTextField.topAnchor /==/ imageResourcesCV.bottomAnchor + kCustomGlobalMargin

        bodyTextView.leftAnchor /==/ notePublishView.leftAnchor + kCustomGlobalMargin
        bodyTextView.rightAnchor /==/ notePublishView.rightAnchor - kCustomGlobalMargin
        bodyTextView.topAnchor /==/ titleTextField.bottomAnchor + kCustomGlobalMargin
        bodyTextView.heightAnchor /==/ 200
        


    }
}


//MARK: 代理方法
extension LS_PostPageViewController: UICollectionViewDataSource {
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

extension LS_PostPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    

}

//点击事件
extension LS_PostPageViewController {
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
            picker.didFinishPicking { [unowned picker] items, isCancelled in
                for item in items {
                    if case let .photo(p: photo) = item {
                        self.photos.append(photo.image)
                    }
                }
                self.imageResourcesCV.reloadData()
                picker.dismiss(animated: true)
            }
            
            present(picker, animated: true, completion: nil)
            
        }else {
            self.showAlert(title: "提示", subtitle: "只能选择9张图片或单个视频")
        }
    }
    
    @objc func endEdit() {
        self.view.endEditing(true)
    }
}
