//
//  UserProfileViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/13.
//

import UIKit
import Anchorage

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    lazy var displayDraftsBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "本地草稿", bgColor: .systemBackground, cornerRadius: 8)
        btn.addTarget(self, action: #selector(displayDrafts), for: .touchUpInside)
        return btn
    }()
    lazy var avatarImageView: UIImageView = {
        let image = UIImage(systemName: "person.circle.fill")!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var userIdLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 14, textAlignment: .left)
        label.text = "用户ID: \(defaults.string(forKey: AccountInfo().userId) ?? "无")"
        return label
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 14, textAlignment: .left)
        label.text = "用户名称: \(defaults.string(forKey: AccountInfo().userName) ?? "无")"
        return label
    }()
    lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 0, bgColor: .clear, cornerRadius: 8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero, bgColor: .clear, cornerRadius: 8)
        scrollView.contentSize = self.view.frame.size
        scrollView.delegate = self
 
        return scrollView
    }()

    lazy var logoutBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "点击注销", bgColor: .systemBackground, cornerRadius: 8)
        btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return btn
    }()
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(sizeConfiguration: .fillEqually(height: 44, spacing: 0))
//        viewPager.pagedView.collectionViewc
        let view1 = NoteWaterFallView(requestType: .getDraft)
        view1.isDraftNote = true
        view1.backgroundColor = UIColor(named: kThirdLevelColor)
        view1.collectionView.bounces = false
        
        let view2 = NoteWaterFallView(requestType: .getPublished)
        view2.isGetPublished = true
        view2.collectionView.bounces = false
        
        let view3 = NoteWaterFallView(requestType: .getLiked)
        view3.isGetLiked = true
        view3.collectionView.bounces = false
//
        viewPager.pagedView.pages = [view1,view2,view3]
        viewPager.tabbedView.tabs = [
            TabbedItem(title: "本地草稿"),
            TabbedItem(title: "我的发布"),
            TabbedItem(title: "我的点赞")
        ]
//        viewPager.tabbedView.backgroundColor = UIColor(named: kThirdLevelColor)
        
        return viewPager
    }()
    func setupUI() {
        self.view.backgroundColor = .systemBackground
//        view.addSubview(displayDraftsBtn)
//        view.addSubview(logoutBtn)
        view.addSubview(scrollView)
        userInfoStackView.addArrangedSubview(avatarImageView)
        userInfoStackView.addArrangedSubview(userIdLabel)
        userInfoStackView.addArrangedSubview(userNameLabel)
        userInfoStackView.addArrangedSubview(logoutBtn)
        view.addSubview(userInfoStackView)
        scrollView.addSubview(viewPager)
//
//
        scrollView.horizontalAnchors == view.horizontalAnchors
        scrollView.topAnchor == view.topAnchor + 200
        scrollView.bottomAnchor == view.bottomAnchor - 90

        userInfoStackView.topAnchor == view.topAnchor
        userInfoStackView.centerXAnchor == view.centerXAnchor
//        userInfoStackView.leftAnchor == scrollView.leftAnchor
//        userInfoStackView.rightAnchor == scrollView.rightAnchor
//        userInfoStackView.heightAnchor == 100
//        userInfoStackView.sizeAnchors == scrollView.sizeAnchors

        
//        displayDraftsBtn.horizontalAnchors == view.horizontalAnchors
//        displayDraftsBtn.topAnchor == view.topAnchor + 200
//
//        logoutBtn.horizontalAnchors == view.horizontalAnchors
//        logoutBtn.topAnchor == displayDraftsBtn.bottomAnchor + 20
//        viewPager.sizeAnchors == scrollView.sizeAnchors
        
//        viewPager.widthAnchor == scrollView.widthAnchor
        
        viewPager.widthAnchor == scrollView.widthAnchor
        viewPager.heightAnchor == scrollView.heightAnchor
//        viewPager.bottomAnchor == scrollView.bottomAnchor - 50
//        viewPager.topAnchor == scrollView.topAnchor + 100
        

        
    }

}

//点击事件
extension UserProfileViewController {
    @objc func displayDrafts() {
        let vc = NoteWaterFallViewController()
        self.present(vc, animated: true)
    }
    
    @objc func logout() {
        let loginVC = LS_LoginViewController()
        defaults.set("", forKey: LoginInfo().token)
        print("注销后：本地存储token：\(defaults.value(forKey: LoginInfo().token))", defaults.value(forKey: LoginInfo().token))
        aboutPageViewController.removeAllSubViewController()
        aboutPageViewController.addSubViewController(subVC: loginVC)
    }
}

extension UserProfileViewController: UIScrollViewDelegate {
    
}
