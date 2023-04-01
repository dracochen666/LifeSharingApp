//
//  ImageBrowserViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/1.
//

import UIKit
import Anchorage

class ImageBrowserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    
    //MARK: 变量区
    let imageView = UIImageView()

    //MARK: 自定义方法区
    
    func setupUI() {
        self.view.addSubview(imageView)

        // 设置图片视图
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 设置导航栏
        self.navigationItem.title = "预览图片"
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteImage))
        self.navigationItem.rightBarButtonItem = deleteButton
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: kSecondLevelColor)
        self.view.backgroundColor = UIColor(named: kThirdLevelColor)?.withAlphaComponent(0.95)
        
        
        //约束
        imageView.leftAnchor /==/ self.view.leftAnchor
        imageView.rightAnchor /==/ self.view.rightAnchor
        imageView.topAnchor /==/ self.view.topAnchor
        imageView.bottomAnchor /==/ self.view.bottomAnchor

    }
    
    // 设置图片
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    // 删除图片
    @objc func deleteImage() {
        imageView.image = nil
    }
}
