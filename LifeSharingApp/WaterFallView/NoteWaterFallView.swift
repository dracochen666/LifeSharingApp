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

class NoteWaterFallView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    
    private var imageModels = [imageModel]()
    var notes: [Note] = [] 
    var drafts: [DraftNote] = []
    var isDraftNote: Bool = false
    

    @objc func refreshView() {
//        tabBarViewController.hideLoadingAni()
        self.collectionView.reloadData()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let images = Array(0...11).map { "image\($0)"}
//        imageModels = images.compactMap {
//            let randNum = CGFloat.random(in: 200...300)
//            return imageModel.init(imageName: $0, imageHeight: randNum)
//        }
//        let group = DispatchGroup()
//        group.enter()
        
        self.setupUI()
//        tabBarViewController.showLoadingAni()
        self.getNotes()
//        tabBarViewController.hideLoadingAni()

//        self.notes = self.getNotes()
//        group.leave()
        getDraftNotes()

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
        collectionView.register(DraftWaterFallCollectionViewCell.self, forCellWithReuseIdentifier: "DraftWaterFallCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isDraftNote ? drafts.count : notes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDraftNote {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DraftWaterFallCollectionViewCell", for: indexPath) as! DraftWaterFallCollectionViewCell
            cell.draftNote = drafts[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteDraftAlert), for: .touchUpInside)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteWaterFallCollectionViewCell", for: indexPath) as! NoteWaterFallCollectionViewCell
//            print(notes.count)
            cell.note = notes[indexPath.item]
//            let photosDataArr = try? JSONDecoder().decode([Data].self, from: photosData)
//            //                var photos: [UIImage] = []
//            //                for data in photosDataArr! {
//            //                    photos.append(((UIImage(data: data) ?? UIImage(systemName: "x.circle.fill"))!))
//            //                }
//            let photos = photosDataArr?.map({ data in
//                UIImage(data: data) ?? UIImage(systemName: "x.circle.fill")!
//            })
            
            print(notes[indexPath.item].noteCoverPhoto)
            let image = UIImage(data: notes[indexPath.item].noteCoverPhoto)
            if let image = image {
                cell.configure(image: image)
            }else {
                cell.configure(image: UIImage(systemName: "xmark.icloud")!)
            }
            
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDraftNote {
            let draft  = drafts[indexPath.item]
            if let photosData = draft.notePhotos {
                let photosDataArr = try? JSONDecoder().decode([Data].self, from: photosData)
                //                var photos: [UIImage] = []
                //                for data in photosDataArr! {
                //                    photos.append(((UIImage(data: data) ?? UIImage(systemName: "x.circle.fill"))!))
                //                }
                let photos = photosDataArr?.map({ data in
                    UIImage(data: data) ?? UIImage(systemName: "x.circle.fill")!
                })
                
                let vc = NoteEditViewController()
                vc.photos = photos!
                vc.draftNote = draft
                vc.updateDraftFinished = {
                    self.getDraftNotes()
                    self.collectionView.reloadData()
                }
                
                self.firstViewController()?.present(vc , animated: true)
                
            }else {
                self.firstViewController()?.showAlert(title: "", subtitle: "草稿图片加载失败")
                return
            }

        }else {
            self.showNoteDetailDelegate?.showDetail()
        }
    }
    //CHT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let rand = imageModels[indexPath.item].imageHeight
        if isDraftNote {
            let viewWidth = Float(self.frame.size.width/2)
            let image = UIImage(data: drafts[indexPath.item].noteCoverPhoto)
            let prop =  Float(image?.size.width ?? 3) / Float(image?.size.height ?? 2)
            let noteHeight = CGFloat(viewWidth / prop)
            print("宽:",CGFloat(viewWidth))
            print("高:",noteHeight)
            print("比例:",prop)
            let rand = CGFloat.random(in: 0...50)
            return prop > 2 ? CGSize(width: CGFloat(viewWidth), height: noteHeight) :  CGSize(width: CGFloat(viewWidth), height: noteHeight + rand)
//            return  CGSize(width: CGFloat(viewWidth), height: noteHeight + rand)
        }else {
            let image = UIImage(data: notes[indexPath.item].noteCoverPhoto)
            let rand = (image?.size.height ?? 200) + 40
            return CGSize(width: self.frame.size.width/2, height: rand)
        }

//        let rand = CGFloat.random(in: 200...300)
    }
    
}

extension NoteWaterFallView {
    @objc func deleteDraftAlert(sender: UIButton) {
        let index = sender.tag
        let alert = UIAlertController(title: "警告", message: "草稿删除后无法恢复", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
            self.deleteDraft(index: index)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        if let vc = self.firstViewController() { //寻找view属于哪一个VC
            vc.present(alert, animated: true)
        }
    }
    
    @objc func deleteDraft(index: Int) {
        let draft = drafts[index]
        context.delete(draft)
        appDelegate.saveContext()
        drafts.remove(at: index)
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
