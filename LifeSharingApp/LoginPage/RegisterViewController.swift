//
//  RegisterViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/24.
//

import UIKit
import Anchorage
import SwiftyJSON
import Alamofire

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: 变量区
    let registerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "注册"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    let userNameTextField = UITextField.init(frame: .zero, placeholder: "输入用户名")
    let passwordTextField = UITextField(frame: .zero, placeholder: "输入密码", borderStyle: .roundedRect, isSecureTextEntry: true)
    let confirmPasswordTextField = UITextField(frame: .zero, placeholder: "输入确认密码", borderStyle: .roundedRect, isSecureTextEntry: true)
    let registerButton = UIButton(frame: .zero, title: "点击注册", bgColor: .systemBlue, cornerRadius: 10)
    let backToLoginButton = UIButton(frame: .zero, title: "返回登录", bgColor: .systemBlue, cornerRadius: 10)
    
    lazy var registerInfoStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()
    
    lazy var registerBtnStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20, bgColor: .clear, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()
    
    //MARK: 自定义方法
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        self.view.addSubview(registerLabel)
        self.view.addSubview(registerInfoStackView)
        self.view.addSubview(registerBtnStackView)
        
        registerInfoStackView.addArrangedSubview(userNameTextField)
        registerInfoStackView.addArrangedSubview(passwordTextField)
        registerInfoStackView.addArrangedSubview(confirmPasswordTextField)
        
        registerBtnStackView.addArrangedSubview(registerButton)
        registerBtnStackView.addArrangedSubview(backToLoginButton)
        
        let _ = Anchorage.batch(active: true) {
            
            registerInfoStackView.centerXAnchor /==/ view.centerXAnchor
            registerInfoStackView.centerYAnchor /==/ 2 * view.centerYAnchor / 3
            registerInfoStackView.widthAnchor /==/ 2 * view.widthAnchor / 3
            registerInfoStackView.heightAnchor /==/ view.heightAnchor / 6
            
            registerBtnStackView.topAnchor == registerInfoStackView.bottomAnchor + kCustomGlobalMargin
            registerBtnStackView.leftAnchor == view.leftAnchor + 70
            registerBtnStackView.rightAnchor == view.rightAnchor - 70
            registerBtnStackView.heightAnchor /==/ 100
            
            registerLabel.centerXAnchor /==/ view.centerXAnchor
            registerLabel.bottomAnchor /==/ registerInfoStackView.topAnchor - 20
            
            
            
        }
        
        registerButton.addTarget(self, action: #selector(tapToRegister), for: .touchUpInside)
        backToLoginButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
    }
    
    func registerRequest(user: User, finishedCallback : @escaping( _ result : Any) -> ()) {
        AF.request(kUrlRegister,
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: Result.self) { response in
            if let data = response.data {
                finishedCallback(data)
            }
        }
    }
}

extension RegisterViewController {
    
    @objc func tapToRegister() {
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.showAlert(title: "用户名或密码为空", subtitle: "")
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            self.showAlert(title: "密码与确认密码不一致", subtitle: "")
            return
        }
        
        let user = User()
        user.userName = userNameTextField.text
        user.password = passwordTextField.text
        let group = DispatchGroup()
        
        group.enter()
        self.showLoadingAni()
        self.registerRequest(user: user) { result in
            let result = try? JSON(data: result as! Data)
            if result!["code"] == "200" {
                print("注册实体：",result!["data"])
                group.leave()
                group.notify(queue: .main) {
                    self.hideLoadingAni()
                    self.showAlert(title: "注册成功", subtitle: "请前往登录")
                }
            }else if result!["code"] == "400"{
                self.hideLoadingAni()
                self.showAlert(title: "注册失败", subtitle: "用户名或密码为空!")
            }else if result!["code"] == "600"{
                self.hideLoadingAni()
                self.showAlert(title: "注册失败", subtitle: "用户名已存在")
            }else {
                self.hideLoadingAni()
                self.showAlert(title: "注册失败!", subtitle: "未知原因")
            }
        }
    }
        
    @objc func backToLogin() {
        print("backToLogin")
        let loginVC = LS_LoginViewController()
        aboutPageViewController.removeAllSubViewController()
        aboutPageViewController.addSubViewController(subVC: loginVC)
    }
    
    @objc func endEdit() {
        self.view.endEditing(false)
    }
}
