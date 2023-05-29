//
//  DropDownMenuView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/27.
//

import UIKit
import Anchorage

protocol PassTopicDelegate {
    
    func passTopic(topic: String)
    
}
class DropDownMenuView: UIView {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var isMenuHidden = false
    var topicDelegate: PassTopicDelegate?
//    public lazy var menuButton: UIButton = {
//        let button = UIButton(cornerRadius: 8)
//        button.addTarget(self, action: #selector(toggleMenuDisplay), for: .touchUpInside)
//        return button
//    }()
    var currentTopicIndex: Int = 0
    public lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DropDownMenuCollectionViewCell.self, forCellWithReuseIdentifier: "DropDownMenuCollectionViewCell")
        collectionView.backgroundColor = UIColor(named: kSecondLevelColor)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = isMenuHidden
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    func setupUI() {
        self.backgroundColor = .systemRed
//        self.addSubview(menuButton)
        self.addSubview(menuCollectionView)
//
        menuCollectionView.verticalAnchors == self.verticalAnchors
        menuCollectionView.horizontalAnchors == self.horizontalAnchors
//        menuCollectionView.heightAnchor == 40
        
    }
}

extension DropDownMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        kTopicsExample.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DropDownMenuCollectionViewCell", for: indexPath) as! DropDownMenuCollectionViewCell
//        collectionView.cellForItem(at: )?.backgroundColor = .systemGray2
        if indexPath.item == 0 {
            cell.label.text = "全部"
            return cell
        }else {
            cell.label.text = kTopicsExample[indexPath.item - 1]
            return cell
        }
    }
    
}

extension DropDownMenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
        collectionView.cellForItem(at: IndexPath(row: currentTopicIndex, section: 0))?.backgroundColor = UIColor(named: kThirdLevelColor)
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .systemGray2
        currentTopicIndex = indexPath.item
        if indexPath.item == 0 {
            print("全部")
            self.topicDelegate?.passTopic(topic: "全部")
        }else {
            self.topicDelegate?.passTopic(topic: kTopicsExample[indexPath.item - 1])
            print(kTopicsExample[indexPath.item - 1])
        }
    }
    
}

extension DropDownMenuView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension DropDownMenuView {
    
    @objc func toggleMenuDisplay() {
        isMenuHidden = !isMenuHidden
//        DropDownMenuView.transition(with: menuCollectionView, duration: 0.4,
//                          options: .transitionCrossDissolve,
//                          animations: {
//            self.menuCollectionView.isHidden = self.isMenuDisplay
//                        })
        self.menuCollectionView.isHidden = self.isMenuHidden

    }
}

extension DropDownMenuView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view!.isDescendant(of: self.menuCollectionView) {
            return false
        }
        return true
    }
}

