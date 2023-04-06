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
        let image = UIImage.generateImageWithColor(color: UIColor(named: kSecondLevelColor)!, size: CGSize(width: 400, height: 50))
        
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .any, barMetrics: .default)
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
        scrollView.backgroundColor = UIColor(named: kSecondLevelColor)
        scrollView.delegate = self
        return scrollView
    }()
    
    var photos = [UIImage(named: "image0"), UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3"), UIImage(named: "image4")]
    var videoURL: URL?
    var isVideo: Bool { videoURL != nil }
    var currentContentTextCount = 0
    var isContentTextLimitExceeded: BooleanLiteralType { currentContentTextCount > kNoteContentLimit }
    
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
    lazy var textFieldLabel = UILabel(frame: .zero, text: "\(kNoteTitleLimit)", font: 15, textAlignment: .right)
    lazy var contentTextView: UITextView = {
        let textView = UITextView(frame: .zero, bgColor: .clear, placeholder: kContentTextViewPlaceholder, borderColor: UIColor.systemGray3.cgColor, borderWidth: 0.3, cornerRadius: 8)
        textView.delegate = self
        return textView
    }()
    var isContentTextViewEmpty: Bool { self.contentTextView.text == kContentTextViewPlaceholder }
    lazy var textViewLabel: UILabel =  UILabel(frame: .zero, text: "\(kNoteContentLimit)", font: 15, textAlignment: .right)
    
    lazy var topicsTextView: UITextView = {
        let textView = UITextView(frame: .zero,textColor: .systemBlue, bgColor: .clear, placeholder: "笔记话题: ", borderColor: UIColor.systemGray3.cgColor, borderWidth: 0, cornerRadius: 8)
        
        textView.isEditable = false
        textView.delegate = self
        return textView
    }()
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, distribution: .fill, spacing: kCustomGlobalMargin/3, bgColor: UIColor(named: kThirdLevelColor)!)
        return stackView
    }()
    
    //话题选择区
    lazy var topicView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = kGlobalCornerRadius
        view.backgroundColor = UIColor(named: kThirdLevelColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(topicSelect))
        view.addGestureRecognizer(tap)
        return view
    }()
    lazy var topicSelectIconText: IconTextView = {
        let image = UIImage(systemName: "number")!
        let view = IconTextView(image: image, text: "话题", direction: .iconText)
        return view
    }()
    lazy var topicGuideIconText: IconTextView = {
        let image = UIImage(systemName: "chevron.right")!
        let view = IconTextView(image: image, text: "点击选择", direction: .textIcon)
        return view
    }()
    //用户定位区
    //发布笔记区
    lazy var saveDraftButton: UIButton = {
        let button = UIButton(frame: .zero, title: "存草稿", bgColor: .secondarySystemBackground, cornerRadius: 10)
        
        return button
    }()
    lazy var publishNoteButton: UIButton = {
        let button = UIButton(frame: .zero, title: "发布笔记", bgColor: .systemYellow, cornerRadius: kGlobalCornerRadius)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        return button
    }()
    lazy var publishNoteStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, spacing: 20, bgColor: .clear, cornerRadius: kGlobalCornerRadius)
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
        //输入框区
        notePublishView.addSubview(textStackView)
        textStackView.addArrangedSubview(titleTextField)
        textStackView.addArrangedSubview(textFieldLabel)
        textStackView.addArrangedSubview(contentTextView)
        textStackView.addArrangedSubview(textViewLabel)
        textStackView.addArrangedSubview(topicsTextView)
        //话题区
        notePublishView.addSubview(topicView)
        topicView.addSubview(topicSelectIconText)
        topicView.addSubview(topicGuideIconText)
        //定位区
        //发布笔记区
        self.view.addSubview(publishNoteStackView)
        publishNoteStackView.addArrangedSubview(saveDraftButton)
        publishNoteStackView.addArrangedSubview(publishNoteButton)
        
        //play video
        let playBtn = UIButton(type: .system)
        playBtn.backgroundColor = .purple
        playBtn.setTitle("weird button", for: .normal)
        playBtn.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        playBtn.layer.cornerRadius = 10
        notePublishView.addSubview(playBtn)
        playBtn.centerXAnchor == 0.2 * notePublishView.centerXAnchor
        playBtn.centerYAnchor == 1.6 * notePublishView.centerYAnchor

        
        //MARK: 控件约束
        
        scrollView.leftAnchor == self.view.leftAnchor
        scrollView.rightAnchor == self.view.rightAnchor
        scrollView.topAnchor == self.view.topAnchor
        scrollView.bottomAnchor == self.view.bottomAnchor
        
        notePublishView.centerAnchors == scrollView.centerAnchors
        notePublishView.sizeAnchors == scrollView.sizeAnchors
        //笔记图片
        imageResourcesCV.leftAnchor == notePublishView.leftAnchor + kCustomGlobalMargin
        imageResourcesCV.rightAnchor == notePublishView.rightAnchor - kCustomGlobalMargin
        imageResourcesCV.topAnchor == notePublishView.topAnchor + kCustomGlobalMargin
        imageResourcesCV.heightAnchor == 130

 
        //输入区框约束
        let stackViewProp: CGFloat = 2/5 * self.view.frame.size.height
        let stackViewNormalHeight: CGFloat = 30
        textStackView.leftAnchor == notePublishView.leftAnchor + kCustomGlobalMargin
        textStackView.rightAnchor == notePublishView.rightAnchor - kCustomGlobalMargin
        textStackView.topAnchor == imageResourcesCV.bottomAnchor + kCustomGlobalMargin
        textStackView.heightAnchor == stackViewProp
        
        titleTextField.heightAnchor == 30
        contentTextView.heightAnchor == (stackViewProp - 4 * stackViewNormalHeight) + 5
        topicsTextView.heightAnchor == 30

        //话题区约束
        topicView.leftAnchor == notePublishView.leftAnchor + kCustomGlobalMargin
        topicView.rightAnchor == notePublishView.rightAnchor - kCustomGlobalMargin
        topicView.topAnchor == textStackView.bottomAnchor + kCustomGlobalMargin
        topicView.heightAnchor == self.view.frame.size.height / 25
        
        topicSelectIconText.leftAnchor == topicView.leftAnchor + kCustomGlobalMargin
        topicSelectIconText.widthAnchor == 60
        topicSelectIconText.topAnchor == topicView.topAnchor + kCustomGlobalMargin
        topicSelectIconText.bottomAnchor == topicView.bottomAnchor - kCustomGlobalMargin

        topicGuideIconText.rightAnchor == topicView.rightAnchor - kCustomGlobalMargin
        topicGuideIconText.widthAnchor == 100
        topicGuideIconText.topAnchor == topicView.topAnchor + kCustomGlobalMargin
        topicGuideIconText.bottomAnchor == topicView.bottomAnchor - kCustomGlobalMargin

        //发布笔记区约束
        publishNoteStackView.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor
        publishNoteStackView.rightAnchor == self.view.safeAreaLayoutGuide.rightAnchor
        publishNoteStackView.bottomAnchor == self.view.safeAreaLayoutGuide.bottomAnchor
        publishNoteStackView.heightAnchor == self.view.frame.size.height / 20
        
        saveDraftButton.widthAnchor == self.view.frame.size.width / 5
        publishNoteButton.widthAnchor == 7 * self.view.frame.size.width / 10


        
        
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
        //判断当前CollectionView是否处于正在拖拽状态并且拖拽项仍在该Section中
        if collectionView.hasActiveDrag {
            //return建议：用户操作为移动格子。 可以提高拖拽性能
            return UICollectionViewDropProposal(operation: .move,intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
        
    }
      //拖拽完毕
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
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
        if textView.text == kContentTextViewPlaceholder {
            textView.text = ""
            textView.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = kContentTextViewPlaceholder
            textView.textColor = .placeholderText
        }
        self.currentContentTextCount = textView.text.count
    }
    func textViewDidChange(_ textView: UITextView) {

        //markedTextRange标记了当前输入框中临时输入文本（中文输入法拼写状态）
        //markedTextRange为nil时代表当前输入的是英文或中文输入结束状态
        if (textView.markedTextRange == nil) {
            //判断文本是否超出字数限制，字数统计改为红色
            if textView.text.count > kNoteContentLimit {
                self.textViewLabel.text = "\(kNoteContentLimit - textView.text.count)"
                self.textViewLabel.textColor = .systemRed
            }else {
                if textViewLabel.textColor == .systemRed {
                    textViewLabel.textColor = .systemGray3
                }
                //修改计数Label内容
                self.textViewLabel.text = "\(kNoteContentLimit - textView.text.count)"
            }
        }
        
    }

}
extension LS_PostPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(false)
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
extension LS_PostPageViewController: PassValueFromTopicSelectViewController {
    func passSubTopic(subTopic: String) {
//        //如果正文输入框为空则清空输入框内的“输入正文”提示
//        if isContentTextViewEmpty {
//            self.contentTextView.text = ""
//            self.contentTextView.textColor = .label
//        }
//        self.contentTextView.text += subTopic
//        self.dismiss(animated: true)
        self.topicsTextView.text += subTopic + " "
        self.dismiss(animated: true)
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
            self.textFieldLabel.text = "\(kNoteTitleLimit - titleTextField.text!.count)"
        }
    }
    
    @objc func topicSelect() {
        let topicSelectionVC = TopicSelectionViewController(isSearchViewVisable: true)
        topicSelectionVC.passSubTopicFromVCDelegate = self
        self.present(topicSelectionVC, animated: true)
    }
    
    //发布笔记相关
    @objc func saveNote() {
        if isContentTextLimitExceeded {
            self.showAlert(title: "笔记无法发布", subtitle: "正文内容字数超出限制!")

        }else {
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.pushViewController(LS_TabBarViewController(), animated: true)
        }
    }
}
