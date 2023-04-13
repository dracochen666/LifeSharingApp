//
//  WaterFallView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/23.
//

import UIKit
import Anchorage
import CHTCollectionViewWaterfallLayout

//存储图片及高度的结构
struct imageModel {
    var imageName: String
    var imageHeight: CGFloat
}

protocol ShowNoteDetailDelegate: AnyObject {
    
    func showDetail()
}

class WaterFallView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    
    private var imageModels = [imageModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let images = Array(0...11).map { "image\($0)"}
        imageModels = images.compactMap {
            let randNum = CGFloat.random(in: 200...300)
            return imageModel.init(imageName: $0, imageHeight: randNum)
        }
        
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 变量区
    var showNoteDetailDelegate: ShowNoteDetailDelegate?
    lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
//        let layout = UICollectionViewFlowLayout()
        layout.itemRenderDirection = .shortestFirst
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 10
//        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground

        collectionView.register(WaterFallCollectionViewCell.self, forCellWithReuseIdentifier: WaterFallCollectionViewCell.identifier)
        collectionView.register(NoteWaterFallCollectionViewCell.self, forCellWithReuseIdentifier: "NoteWaterFallCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
   

    //MARK: 自定义方法
    func setupUI() {
        self.addSubview(collectionView)
        
        collectionView.leftAnchor /==/ self.leftAnchor
        collectionView.rightAnchor /==/ self.rightAnchor
        collectionView.topAnchor /==/ self.topAnchor
        collectionView.bottomAnchor /==/ self.bottomAnchor

    }
    
    //MARK: 代理方法
    //DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterFallCollectionViewCell.identifier, for: indexPath) as? WaterFallCollectionViewCell else { fatalError() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteWaterFallCollectionViewCell", for: indexPath) as! NoteWaterFallCollectionViewCell
        let image = UIImage(named: imageModels[indexPath.item].imageName)
        cell.configure(image: image!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showNoteDetailDelegate?.showDetail()
    }
    //CHT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rand = imageModels[indexPath.item].imageHeight
        return CGSize(width: self.frame.size.width/2, height: rand)
    }
}
