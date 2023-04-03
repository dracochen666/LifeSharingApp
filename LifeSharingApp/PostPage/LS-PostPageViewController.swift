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
//        tap.delaysTouchesEnded = false
        tap.cancelsTouchesInView = false
        self.notePublishView.addGestureRecognizer(tap)

    }
    
    //MARK: 变量区
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = self.view.frame.size
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.delegate = self
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
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        
        return collectionView
    }()
    //信息输入区
    lazy var titleTextField: UITextField = {
        let textField = UITextField(frame: .zero,placeholder: "输入标题")
        textField.addTarget(self, action: #selector(textFieldDidchange), for: .editingChanged)
        return textField
    }()
    lazy var textFieldLabel = UILabel(frame: .zero, text: "0/\(kNoteTitleLimit)", font: 15, textAlignment: .right)
    lazy var contentTextView: UITextView = {
        let textView = UITextView(frame: .zero, bgColor: .clear, borderColor: UIColor.systemGray3.cgColor, borderWidth: 0.3, cornerRadius: 8)
        textView.delegate = self
        return textView
    }()
    lazy var textViewLabel: UILabel =  UILabel(frame: .zero, text: "0/\(kNoteContentLimit)", font: 15, textAlignment: .right)
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        let margin = kCustomGlobalMargin
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = margin / 3
        stackView.backgroundColor = UIColor(named: kThirdLevelColor)
        stackView.layer.cornerRadius = kGlobalCornerRadius
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: margin/2, left: margin/2, bottom: margin/2, right: margin/2)
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
        
        imageResourcesCV.dragInteractionEnabled = true
        
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
//CollectionView拖拽代理方法
extension LS_PostPageViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    //Drag
      //开始拖拽时
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("1")
        let photo = photos[indexPath.item]!
        let itemProvider = NSItemProvider(object: photo)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        //将拖拽Item存入dragItem中，在拖拽完毕后可通过coordinator获取。
        dragItem.localObject = photo
        return [dragItem]
    }
    //Drop
      //拖拽期间
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        print("2")
        //判断当前CollectionView是否处于正在拖拽状态并且拖拽项仍在该Section中
        if collectionView.hasActiveDrag {
            //return建议：用户操作为移动格子。 可以提高拖拽性能
            return UICollectionViewDropProposal(operation: .move,intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
        
    }
      //拖拽完毕
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("3")
        //四个条件：
        //1.判断是否为move操作
        //2.对coordinator解包，获取拖拽项item
        //3.根据item获取初始位置
        //4.通过coordinator获取拖拽终点
        if coordinator.proposal.operation == .move,
            let item = coordinator.items.first,
            let source = item.sourceIndexPath,
            let destination = coordinator.destinationIndexPath{
            collectionView.performBatchUpdates {
                photos.remove(at: source.item)
                photos.insert(item.dragItem.localObject as! UIImage, at: destination.item)
                collectionView.moveItem(at: source, to: destination)
            }
            coordinator.drop(item.dragItem, toItemAt: destination)
        }
    }
}
//TextView代理方法
extension LS_PostPageViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "输入正文" {
            textView.text = ""
            textView.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "输入正文"
            textView.textColor = .placeholderText
        }
    }
    func textViewDidChange(_ textView: UITextView) {

        //markedTextRange标记了当前输入框中临时输入文本（中文输入法拼写状态）
        //markedTextRange为nil时代表当前输入的是英文或中文输入结束状态
        if (textView.markedTextRange == nil) {
            //判断文本是否超出字数限制，若超出取字数限制大小子串并发出警告
            if textView.text.count > kNoteContentLimit {
                textView.text = String(textView.text.prefix(kNoteContentLimit))
                self.showAlert(title: "正文字数超限！", subtitle: "")
            }
            //修改计数Label内容
            self.textViewLabel.text = "\(textView.text.count)/\(kNoteContentLimit)"
        }
        
    }

}
extension LS_PostPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(false)
    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if targetContentOffset > 0
//    }
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
    
    //TextField输入变化
    @objc func textFieldDidchange() {
        if titleTextField.markedTextRange == nil {
            if titleTextField.text!.count > kNoteTitleLimit {
                titleTextField.text = String(titleTextField.text!.prefix(kNoteTitleLimit))
                self.showAlert(title: "标题字数超限！", subtitle: "")
            }
            self.textFieldLabel.text = "\(titleTextField.text!.count)/\(kNoteTitleLimit)"
        }
    }
}
