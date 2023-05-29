//
//  NoteDetailViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/13.
//

import UIKit
import Alamofire
import Anchorage

class NoteDetailViewController: UIViewController, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        self.setupUI()
        self.note = getNoteById(noteId!)
        self.getNoteCommentById(noteId: noteId!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK:
    var noteId: Int?

    var note: Note?

    var noteComments: [NoteComment] = []
    
    var currentIndex: Int = 0

    var isLiked: Bool = false
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.view.frame.width, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let userIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        
        label.backgroundColor = UIColor(named: kThirdLevelColor)
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let commentDisplayButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var commentTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor(named: kThirdLevelColor)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView.clipsToBounds = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
 
    lazy var commentTextField: UITextField = {
        let textField = UITextField(frame: .zero, textColor: .label, bgColor: .clear, font: 16, placeholder: "输入评论", borderStyle: .roundedRect, isSecureTextEntry: false)
        
        return textField
    }()
    
    lazy var sendCommentButton: UIButton = {
        let button = UIButton(frame: .zero, tintColor: .label, buttonType: .roundedRect, title: "发送", bgColor: .systemRed, cornerRadius: kGlobalCornerRadius)
        
        return button
    }()
    
    lazy var sendCommentView: UIView = {
        let view = UIView(frame: .zero, bgColor: UIColor(named: kThirdLevelColor)!, cornerRadius: kGlobalCornerRadius)
        
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

    func setupUI() {
        view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(dateLabel)
        view.addSubview(userIdLabel)
        view.addSubview(likeButton)
        view.addSubview(commentDisplayButton)
        
        view.addSubview(sendCommentView)
        view.addSubview(commentTableView)

        sendCommentView.addSubview(commentTextField)
        sendCommentView.addSubview(sendCommentButton)

        collectionView.topAnchor == view.safeAreaLayoutGuide.topAnchor
        collectionView.horizontalAnchors == view.horizontalAnchors
        collectionView.heightAnchor == 300
        
        titleLabel.topAnchor == collectionView.bottomAnchor + 16
        titleLabel.horizontalAnchors == view.horizontalAnchors + 16
        
        bodyLabel.topAnchor == titleLabel.bottomAnchor + 16
        bodyLabel.horizontalAnchors == view.horizontalAnchors + 16
        
        dateLabel.topAnchor == bodyLabel.bottomAnchor + 16
        dateLabel.leftAnchor == view.leftAnchor + 16
        
        userIdLabel.topAnchor == dateLabel.bottomAnchor + 16
        userIdLabel.leftAnchor == view.leftAnchor + 16
        
        likeButton.topAnchor == userIdLabel.bottomAnchor + 16
        likeButton.leftAnchor == view.leftAnchor + 16
        likeButton.widthAnchor == 30
        likeButton.heightAnchor == 30
        
        commentDisplayButton.topAnchor == userIdLabel.bottomAnchor + 16
        commentDisplayButton.leftAnchor == likeButton.rightAnchor + 16
        commentDisplayButton.widthAnchor == 30
        commentDisplayButton.heightAnchor == 30
        
        

        sendCommentView.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - kCustomGlobalMargin
        sendCommentView.horizontalAnchors == view.horizontalAnchors + 16
        sendCommentView.heightAnchor == 40
        
        commentTextField.verticalAnchors == sendCommentView.verticalAnchors + 5
        commentTextField.leftAnchor == sendCommentView.leftAnchor + kCustomGlobalMargin
        commentTextField.widthAnchor == sendCommentView.widthAnchor * 0.80
        
        sendCommentButton.verticalAnchors == sendCommentView.verticalAnchors + 5
        sendCommentButton.leftAnchor == commentTextField.rightAnchor + kCustomGlobalMargin
        sendCommentButton.rightAnchor == sendCommentView.rightAnchor -  kCustomGlobalMargin
        
        commentTableView.bottomAnchor == sendCommentView.topAnchor - kCustomGlobalMargin
        commentTableView.horizontalAnchors == view.horizontalAnchors + 16
        commentTableView.heightAnchor == 200
        
        titleLabel.text = ""
        bodyLabel.text = ""
        dateLabel.text = "编辑于: "
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        currentIndex = Int(x / w)
    }


    

}



extension NoteDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let decoder = JSONDecoder()
        if let photosData = note?.notePhotos {
            let imageDataArr = try? decoder.decode([Data].self, from: photosData)
            return imageDataArr?.count ?? 0
        }else {
            return 0
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        let decoder = JSONDecoder()
        if let photosData = note?.notePhotos {
            let imageDataArr = try? decoder.decode([Data].self, from: (note?.notePhotos)!)
            let image = UIImage(data: imageDataArr![indexPath.item])
            cell.imageView.image = image
            return cell
            
        }else {
            cell.imageView.image = UIImage(systemName: "exclamationmark.icloud.fill")
            return cell
            
        }
        
        
    }
    
}

extension NoteDetailViewController: UITableViewDelegate {
    
}

extension NoteDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        let commentUserId = noteComments[indexPath.item].commentUserId.description
        let commentContent = noteComments[indexPath.item].comment
        cell.commentFromLabel.text = "id " + commentUserId + ": "
        cell.commentLabel.text = commentContent
        
        return cell
    }
    
    
}

extension NoteDetailViewController {
    
    func likeNote() {
        let userId = defaults.integer(forKey: AccountInfo().userId)

        if let noteId = noteId {
            if isLiked {//通过isLiked判断是点赞请求还是取消点赞请求
                AF.request(kUrlDislikeNote+"?userId=\(userId)&noteId=\(noteId)", method: .get).responseString { response in
                    self.showAlert(title: "取消点赞成功!", subtitle: "")
                }
                print("dislike")
            }else {
                AF.request(kUrlLikeNote+"?userId=\(userId)&noteId=\(noteId)", method: .get).responseString { response in
                    self.showAlert(title: "点赞成功!", subtitle: "")
                }
                print("like")
            }
            isLiked = !isLiked
            updateLikedNumber()
        }else {
            self.showAlert(title: "未知笔记ID", subtitle: "")
        }

        
    }
    
    func updateLikedNumber() {//更新数据库内的笔记点赞数量
        AF.request(kUrlUpdateLikedNumber, method: .get).responseString { response in }
    }
    
    @objc func handleSwipe() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        likeNote()
    }

    @objc func commentButtonTapped(_ sender: UIButton) {
        commentTableView.isHidden = commentTableView.isHidden ? false : true
        sendCommentView.isHidden = sendCommentView.isHidden ? false : true
        if !commentTableView.isHidden {
            commentTableView.reloadData()
        }
    }
    
    @objc func endEdit() {
        self.view.endEditing(false)
    }
    
}




class ImageCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
//        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        imageView.topAnchor == contentView.topAnchor
        imageView.leftAnchor == contentView.leftAnchor
        imageView.edgeAnchors == contentView.edgeAnchors
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

