//
//  LS-PostPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage

class LS_PostPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupUI()
    }
    
    //MARK: 变量区
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
//        scrollView.contentSize = self.view.safeAreaLayoutGuide.layoutFrame.size
        scrollView.contentSize = self.view.frame.size
        return scrollView
    }()
    
    var notePublishView = LS_PostPage_NotePublishView(frame: .zero)

    
    //MARK: 自定义方法
    func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(notePublishView)
//        notePublishView.frame = scrollView.frame
        //
        scrollView.leftAnchor /==/ self.view.safeAreaLayoutGuide.leftAnchor
        scrollView.rightAnchor /==/ self.view.safeAreaLayoutGuide.rightAnchor
        scrollView.topAnchor /==/ self.view.topAnchor
        scrollView.bottomAnchor /==/ self.view.bottomAnchor
        
        //
        notePublishView.widthAnchor /==/ scrollView.widthAnchor
        notePublishView.heightAnchor /==/ scrollView.heightAnchor
//        notePublishView.leftAnchor /==/ scrollView.leftAnchor
//        notePublishView.rightAnchor /==/ scrollView.rightAnchor
//        notePublishView.topAnchor /==/ scrollView.topAnchor
//        notePublishView.bottomAnchor /==/ scrollView.bottomAnchor


        

//        self.view.addSubview(notePublishView)
//        notePublishView.leftAnchor /==/ self.view.leftAnchor
//        notePublishView.rightAnchor /==/ self.view.rightAnchor
//        notePublishView.topAnchor /==/ self.view.topAnchor
//        notePublishView.bottomAnchor /==/ self.view.bottomAnchor
        

    }
}
