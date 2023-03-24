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
    let userNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "输入用户名"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "输入密码"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("登录", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    let registerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("注册", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    
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
            
            loginLabel.centerXAnchor /==/ view.centerXAnchor
            loginLabel.bottomAnchor /==/ stackView.topAnchor - 20
//            loginButton.leftAnchor /==/ stackView.leftAnchor + 50
//            loginButton.rightAnchor /==/ stackView.rightAnchor - 50
            
        }
        
        loginButton.addTarget(self, action: #selector(tabToLogin), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(tabToResgister), for: .touchUpInside)
    }
    
    @objc func tabToLogin() {
        print("login")
        let vc = LS_TabBarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tabToResgister() {
        print("register")
    }
}
