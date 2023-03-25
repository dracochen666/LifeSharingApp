//
//  LS-LoginViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/23.
//

import UIKit
import Anchorage

class LS_LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    //MARK: 变量区
    let loginLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "登录"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()

    let userNameTextField = UITextField.init(frame: .zero, placeholder: "输入用户名")
    let passwordTextField = UITextField(frame: .zero, placeholder: "输入密码", borderStyle: .roundedRect, isSecureTextEntry: true)
    let loginButton = UIButton(frame: .zero, title: "登录", bgColor: .systemBlue, cornerRadius: 10)
    let registerButton = UIButton(frame: .zero, title: "注册", bgColor: .systemBlue, cornerRadius: 10)
    
    //MARK: 自定义方法
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField, loginButton, registerButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .systemGray5
        stackView.spacing = 20
        stackView.layer.shadowOpacity = 0.05
        stackView.layer.shadowRadius = 10
        self.view.addSubview(stackView)
        self.view.addSubview(loginLabel)
        self.view.backgroundColor = .systemGray6
        
        let constraint = Anchorage.batch(active: true) {
            
            stackView.centerXAnchor /==/ view.centerXAnchor
            stackView.centerYAnchor /==/ 2 * view.centerYAnchor / 3
            stackView.widthAnchor /==/ 2 * view.widthAnchor / 3
            stackView.heightAnchor /==/ view.heightAnchor / 4
            
            self.loadingAnimation()

            loginLabel.centerXAnchor /==/ view.centerXAnchor
            loginLabel.bottomAnchor /==/ stackView.topAnchor - 20
            
            
        }

        loginButton.addTarget(self, action: #selector(tabToLogin), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(tabToResgister), for: .touchUpInside)
    }
    func loadingAnimation() {
        // 创建一个UIImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        // 设置图片
        let image = UIImage(systemName: "arrow.clockwise")
        image!.withTintColor(.systemGray3)
        imageView.image = image
        // 设置旋转动画
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2 * 4)
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        // 将imageView添加到视图中
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        imageView.centerXAnchor /==/ self.view.centerXAnchor
        imageView.centerYAnchor /==/ self.view.centerYAnchor + 200
//        print("yes")
    }
    
    @objc func tabToLogin() {
        print("login")
        let vc = LS_TabBarViewController()
        self.loadingAnimation()
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tabToResgister() {
        print("register")
    }
}
