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
import AVKit

class LS_PostPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        //        tap.delaysTouchesBegan = false
//        tap.delaysTouchesEnded = false
        tap.cancelsTouchesInView = false
        self.notePublishView.addGestureRecognizer(tap)

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
    var videoURL: URL?
    var isVideo: Bool { videoURL != nil }
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
    //信息输入区
    lazy var titleTextField: UITextField = {
        let textField = UITextField(frame: .zero,placeholder: "输入标题")
        textField.delegate = self
        return textField
    }()
    lazy var textFieldLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "0/\(kNoteTitleLimit)", font: 15)
        return label
    }()
    lazy var textViewLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "0/\(kNoteContentLimit)", font: 15)
        return label
    }()
    lazy var contentTextView: UITextView = {
        let textView = UITextView(frame: .zero, textColor: .label, bgColor: .clear, borderColor: UIColor.systemGray3.cgColor, borderWidth: 0.3, cornerRadius: 8)
        textView.delegate = self
        return textView
    }()
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        let margin = kCustomGlobalMargin / 2
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = margin
        stackView.backgroundColor = UIColor(named: kThirdLevelColor)
        stackView.layer.cornerRadius = kGlobalCornerRadius
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        return stackView
    }()
    //存储传入笔记图片数量
    var photoCount: Int { photos.count }

    lazy var notePublishView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: kSecondLevelColor)
        return view
    }()

    
    //MARK: 自定义方法
    func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(notePublishView)
        notePublishView.addSubview(imageResourcesCV)
        notePublishView.addSubview(textStackView)
        textStackView.addArrangedSubview(titleTextField)
        textStackView.addArrangedSubview(textFieldLabel)
        textStackView.addArrangedSubview(contentTextView)
        textStackView.addArrangedSubview(textViewLabel)
        
        imageResourcesCV.dragInteractionEnabled = false
        
        //play video
        let playBtn = UIButton(type: .system)
        playBtn.backgroundColor = .label
        playBtn.setTitle("PLAY", for: .normal)
        playBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        playBtn.layer.cornerRadius = 10
        notePublishView.addSubview(playBtn)
        playBtn.centerXAnchor /==/ notePublishView.centerXAnchor
        playBtn.centerYAnchor /==/ 1.5 * notePublishView.centerYAnchor

        
        //
        
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

        textStackView.leftAnchor == notePublishView.leftAnchor + kCustomGlobalMargin
        textStackView.rightAnchor == notePublishView.rightAnchor - kCustomGlobalMargin
        textStackView.topAnchor == imageResourcesCV.bottomAnchor + kCustomGlobalMargin
        textStackView.heightAnchor == self.view.frame.size.height / 3



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
extension LS_PostPageViewController: UICollectionViewDelegate {
    
    //用户选中某一个Cell后，识别选中类型是photo还是video决定调用预览方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isVideo {
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL!)
            playerVC.player?.play()
            self.present(playerVC, animated: true)

        }else {
            let vc = ImageBrowserViewController(imageIndex: indexPath.item)
            vc.setImage(photos[indexPath.item]!)
            vc.delegate = self
            let navi = UINavigationController(rootViewController: vc)
            self.present(navi, animated: true)
        }
    }

}
//图片预览代理方法
extension LS_PostPageViewController: UITextFieldDelegate, UITextViewDelegate {
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        print(textField.text!)
//        return true
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(textField.text?.count)
//    }
//
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text
//        let selectRange = textView.markedTextRange
//        let newText = textView.text(in: selectRange!)!
//        print(newText.count)
//        if (newText.count != nil) {
//            self.titleTextField.placeholder = "\(textView.text.count)/\(kNoteContentLimit)"
//        }
//        print("selectrange:",textView.markedTextRange ?? .none)
//        let selectRange = textView.markedTextRange!
//        let newText = textView.text(in: selectRange)
//        print(newText)
//        if let selectRange = textView.markedTextRange,
//           ,newText.count == 0{
//            self.titleTextField.placeholder = "\(textView.text.count)/\(kNoteContentLimit)"
//            if textView.text.count > kNoteContentLimit {
//                let str =  textView.text.prefix(kNoteContentLimit)
//                textView.text = String(str)
//                //                textView.text.startIndex
//            }
//        }else {
//
//        }
//        let selectRange: UITextRange = textView.markedTextRange
//        let newText = textView.text(in: selectRange)!
//        if (newText.count != 0) {
//            self.titleTextField.placeholder = "\(textView.text.count)/200"
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        print(textView.text)
//        print(textView.text.count)
        
    }

    

}
//图片预览自定义代理方法
extension LS_PostPageViewController: ImageBrowserDelegate {
    //点击预览窗口导航栏的删除按钮后调用代理方法
    func deleteImage(index: Int) {
        if photos.count > 1 {
            photos.remove(at: index)
            self.imageResourcesCV.reloadData()
            self.dismiss(animated: true)
        }else {
            self.dismiss(animated: true)
            self.showAlert(title: "提示", subtitle: "无法删除！笔记中至少包含 一张图片。")
        }

    }
    
    
}

//MARK: 点击事件
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
        self.view.endEditing(false)
    }
    
    @objc func playVideo() {
        let playerVC = AVPlayerViewController()
        playerVC.player = AVPlayer(url: Bundle.main.url(forResource: "illusion-or-magic", withExtension: "mp4")!)
        playerVC.player?.play()
        self.present(playerVC, animated: true)
        
    }
}
