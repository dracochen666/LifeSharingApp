//
//  WaterFallViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/21.
//

import UIKit
import Anchorage
import CHTCollectionViewWaterfallLayout

class WaterFallViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
//        let layout = UICollectionViewFlowLayout()
        layout.itemRenderDirection = .shortestFirst
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 20
//        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(WaterFallCollectionViewCell.self, forCellWithReuseIdentifier: WaterFallCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    func setupUI() {
        self.view.addSubview(collectionView)
        
        collectionView.leftAnchor /==/ self.view.leftAnchor
        collectionView.rightAnchor /==/ self.view.rightAnchor
        collectionView.topAnchor /==/ self.view.topAnchor
        collectionView.bottomAnchor /==/ self.view.bottomAnchor

    }
    
    //MARK:
    //DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterFallCollectionViewCell.identifier, for: indexPath) as? WaterFallCollectionViewCell else { fatalError() }
//        let view = UIView()
//        view.backgroundColor = .red
//        cell.view = view
        return cell
    }
    
    //CHT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2, height: CGFloat.random(in: 150...300))
    }
    

}

//extension WaterFallTestViewController: UICollectionViewDataSource {
//
//}

//extension WaterFallTestViewController: UICollectionViewDelegateFlowLayout {
//
//}
