//
//  UserProfileViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/13.
//

import UIKit
import Anchorage
import Alamofire

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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var userIdLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 14, textAlignment: .center)
        label.text = "用户ID: \(defaults.string(forKey: AccountInfo().userId) ?? "无")"
        return label
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero, text: "", textColor: .label, bgColor: .clear, font: 14, textAlignment: .center)
        label.text = "用户名称: \(defaults.string(forKey: AccountInfo().userName) ?? "无")"
        return label
    }()
    lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 5, bgColor: UIColor(named: kSecondLevelColor)!, cornerRadius: 8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero, bgColor: .clear, cornerRadius: 8)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 80)
        scrollView.delegate = self
 
        return scrollView
    }()

    
    lazy var changeUserInfoBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "修改用户信息", bgColor: UIColor(named: kThirdLevelColor)!, cornerRadius: 8)
        btn.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
        return btn
    }()
    lazy var changeUserPasswordBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "修改用户密码", bgColor: UIColor(named: kThirdLevelColor)!, cornerRadius: 8)
        btn.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return btn
    }()
    lazy var logoutBtn: UIButton = {
        let btn = UIButton(frame: .zero,title: "点击注销", bgColor: UIColor(named: kThirdLevelColor)!, cornerRadius: 8)
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
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)

        view.addSubview(scrollView)
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(userInfoStackView)
        scrollView.addSubview(viewPager)
        
        scrollView.horizontalAnchors == view.horizontalAnchors
        scrollView.topAnchor == view.safeAreaLayoutGuide.topAnchor
        scrollView.bottomAnchor == view.bottomAnchor - 90
        
        avatarImageView.widthAnchor == self.view.widthAnchor / 5
        avatarImageView.heightAnchor == self.view.widthAnchor / 5
        avatarImageView.topAnchor == scrollView.topAnchor
        avatarImageView.centerXAnchor == scrollView.centerXAnchor
        
        
        userInfoStackView.addArrangedSubview(userIdLabel)
        userInfoStackView.addArrangedSubview(userNameLabel)
        userInfoStackView.addArrangedSubview(changeUserPasswordBtn)
        userInfoStackView.addArrangedSubview(logoutBtn)

        
        userInfoStackView.topAnchor == avatarImageView.bottomAnchor
        userInfoStackView.horizontalAnchors == self.view.horizontalAnchors
        userInfoStackView.heightAnchor == 120
        
        viewPager.topAnchor == scrollView.topAnchor + 220
        viewPager.horizontalAnchors == self.view.horizontalAnchors
        viewPager.heightAnchor == scrollView.heightAnchor
        
    }

}

//点击事件
extension UserProfileViewController {
    @objc func displayDrafts() {
        let vc = NoteWaterFallViewController()
        self.present(vc, animated: true)
    }
    
    @objc func logout(_ isForceLogout: Bool = false) {
        
        if isForceLogout {
            let loginVC = LS_LoginViewController()
            defaults.set("", forKey: LoginInfo().token)
            print("注销后：本地存储token：\(defaults.value(forKey: LoginInfo().token))", defaults.value(forKey: LoginInfo().token))
            aboutPageViewController.removeAllSubViewController()
            aboutPageViewController.addSubViewController(subVC: loginVC)
            return
        }
        
        let alert = UIAlertController(title: "警告", message: "确定要退出登录吗", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let deleteAction = UIAlertAction(title: "退出", style: .destructive) { _ in
            let loginVC = LS_LoginViewController()
            defaults.set("", forKey: LoginInfo().token)
            print("注销后：本地存储token：\(defaults.value(forKey: LoginInfo().token))", defaults.value(forKey: LoginInfo().token))
            aboutPageViewController.removeAllSubViewController()
            aboutPageViewController.addSubViewController(subVC: loginVC)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        self.present(alert, animated: true)

    }
    
    @objc func changeInfo() {
        let changePasswordVC = ChangeUserInfoViewController()
        changePasswordVC.didChangedInfo = {
//            self.logout(true)
//            tabBarViewController.showAlert(title: "您已修改密码，请重新登录!", subtitle: "")
        }
        self.modalPresentationStyle = .overFullScreen
        self.present(changePasswordVC, animated: true)
    }
    
    @objc func changePassword() {
        let changePasswordVC = ChangeUserPasswordViewController()
        //传入闭包，在成功修改密码后推出登录
        changePasswordVC.didChangedPassword = {
            self.logout(true)
            tabBarViewController.showAlert(title: "您已修改密码，请重新登录!", subtitle: "")
        }
        self.modalPresentationStyle = .overFullScreen
        self.present(changePasswordVC, animated: true)
    }
}

extension UserProfileViewController: UIScrollViewDelegate {
    
}
