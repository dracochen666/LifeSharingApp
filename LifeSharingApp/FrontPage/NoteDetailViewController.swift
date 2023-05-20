//
//  NoteDetailViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/13.
//

import UIKit

class NoteDetailViewController: UIViewController, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        self.setupUI()
        self.note = getNoteById(noteId!)
        
    }
    
    // MARK:
    var noteId: Int?

    var note: Note?
//    {
//        didSet {
//            titleLabel.text = note?.noteTitle
//            bodyLabel.text = note?.noteContent
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            dateLabel.text = formatter.string(for: note?.createTime)
//        }
//    }
//    var imageUrls: [String] = ["image0","image1","image2","image3","image4","image5","image6","image7"]
    var currentIndex: Int = 0
    var showNoteDetailFinished: (()->())?

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
    
    
 

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

    func setupUI() {
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
        
        
        titleLabel.text = ""
        bodyLabel.text = ""
        dateLabel.text = "编辑于: "
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
            print("1111")
            let image = UIImage(data: imageDataArr![indexPath.item])
            cell.imageView.image = image
            return cell
            
        }else {
            cell.imageView.image = UIImage(systemName: "exclamationmark.icloud.fill")
            return cell
            
        }
        
        
    }
    
}



extension NoteDetailViewController {
    @objc func handleSwipe() {
        self.navigationController?.popViewController(animated: true)
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
