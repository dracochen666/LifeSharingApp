//
//  WaterFallViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/21.
//

import UIKit
import Anchorage
import CHTCollectionViewWaterfallLayout

//存储图片及高度的结构
struct Model {
    var imageName: String
    var imageHeight: CGFloat
}

class WaterFallViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
   

    
    //MARK: 变量区
    private lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
//        let layout = UICollectionViewFlowLayout()
        layout.itemRenderDirection = .shortestFirst
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 10
//        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(WaterFallCollectionViewCell.self, forCellWithReuseIdentifier: WaterFallCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    var imageModels = [Model]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = Array(1...12).map { "image\($0)"}
        imageModels = images.compactMap {
            let randNum = CGFloat.random(in: 200...300)
            return Model.init(imageName: $0, imageHeight: randNum)
        }
        self.setupUI()
    }

    //MARK: 自定义方法
    func setupUI() {
        self.view.addSubview(collectionView)
        
        collectionView.leftAnchor /==/ self.view.leftAnchor
        collectionView.rightAnchor /==/ self.view.rightAnchor
        collectionView.topAnchor /==/ self.view.topAnchor
        collectionView.bottomAnchor /==/ self.view.bottomAnchor

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterFallCollectionViewCell.identifier, for: indexPath) as? WaterFallCollectionViewCell else { fatalError() }

        cell.configure(image: UIImage(named: imageModels[indexPath.item].imageName)!)
        return cell
    }
    
    //CHT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rand = imageModels[indexPath.item].imageHeight
        return CGSize(width: view.frame.size.width/2, height: rand)
    }
    

}

//extension WaterFallTestViewController: UICollectionViewDataSource {
//
//}

//extension WaterFallTestViewController: UICollectionViewDelegateFlowLayout {
//
//}
