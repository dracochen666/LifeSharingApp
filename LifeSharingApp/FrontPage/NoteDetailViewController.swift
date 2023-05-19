//
//  NoteDetailViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/13.
//

import UIKit

class NoteDetailViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK:
    
    var note: Note?
    var imageUrls: [String] = ["image0","image1","image2","image3","image4","image5","image6","image7"]
    var currentIndex: Int = 0
        
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
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(dateLabel)
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            likeButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            
            commentButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16),
            commentButton.widthAnchor.constraint(equalToConstant: 30),
            commentButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
//        imageUrls = note.imageUrls
        
        titleLabel.text = "风景"
        bodyLabel.text = "壮丽的山脉屹立在远处，山川纵横，云雾缭绕。茂密的森林覆盖在山脚下，青翠欲滴。清澈的溪流在山间穿梭，发出优美的流水声。这里是一处令人心旷神怡的山景。壮丽的山脉屹立在远处，山川纵横，云雾缭绕。茂密的森林覆盖在山脚下，青翠欲滴。清澈的溪流在山间穿梭，发出优美的流水声。这里是一处令人心旷神怡的山景。壮丽的山脉屹立在远处，山川纵横，云雾缭绕。茂密的森林覆盖在山脚下，青翠欲滴。清澈的溪流在山间穿梭，发出优美的流水声。这里是一处令人心旷神怡的山景。壮丽的山脉屹立在远处，山川纵横，云雾缭绕。茂密的森林覆盖在山脚下，青翠欲滴。清澈的溪流在山间穿梭，发出优美的流水声。这里是一处令人心旷神怡的山景。"
        dateLabel.text = "编辑于: 2023/4/13"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        currentIndex = Int(x / w)
    }

    // MARK: Actions

    @objc func likeButtonTapped(_ sender: UIButton) {
    }

    @objc func commentButtonTapped(_ sender: UIButton) {
        
    }

}

class ImageCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
//        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(named: imageUrls[indexPath.row])
        print("1111")
        return cell
    }
    
}

extension NoteDetailViewController {
    @objc func handleSwipe() {
        self.navigationController?.popViewController(animated: true)
    }
}
