//
//  ChangeUserInfoViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/25.
//

import UIKit
import Anchorage
import Alamofire
import SwiftyJSON

class ChangeUserPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    var didChangedPassword: ()->() = {}

    
    let changePasswordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "修改密码"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()

    let oldPasswordTextField = UITextField(frame: .zero, placeholder: "输入旧密码", borderStyle: .roundedRect, isSecureTextEntry: true)
    let newPasswordTextField = UITextField(frame: .zero, placeholder: "输入确认密码", borderStyle: .roundedRect, isSecureTextEntry: true)
    let changePasswordButton = UIButton(frame: .zero, title: "确认修改", bgColor: .systemRed, cornerRadius: 10)
    let cancelChangePasswordButton = UIButton(frame: .zero, title: "返回主页", bgColor: .systemBlue, cornerRadius: 10)
    
    lazy var changePasswordStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 10, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()

    lazy var changePasswordButtonStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 10, bgColor: .clear, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()
    //MARK: 自定义方法
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        self.view.addSubview(changePasswordLabel)
        self.view.addSubview(changePasswordStackView)
        self.view.addSubview(changePasswordButtonStackView)

        
        changePasswordStackView.addArrangedSubview(oldPasswordTextField)
        changePasswordStackView.addArrangedSubview(newPasswordTextField)
        
        changePasswordButtonStackView.addArrangedSubview(changePasswordButton)
        changePasswordButtonStackView.addArrangedSubview(cancelChangePasswordButton)
 
        changePasswordStackView.centerXAnchor /==/ view.centerXAnchor
        changePasswordStackView.centerYAnchor /==/ 2 * view.centerYAnchor / 3
        changePasswordStackView.widthAnchor /==/ 2 * view.widthAnchor / 3
        changePasswordStackView.heightAnchor /==/ view.heightAnchor / 9

        changePasswordButtonStackView.topAnchor == changePasswordStackView.bottomAnchor + kCustomGlobalMargin
        changePasswordButtonStackView.leftAnchor == view.leftAnchor + 70
        changePasswordButtonStackView.rightAnchor == view.rightAnchor - 70
        changePasswordButtonStackView.heightAnchor /==/ 90
        
        changePasswordLabel.centerXAnchor /==/ view.centerXAnchor
        changePasswordLabel.bottomAnchor /==/         changePasswordStackView.topAnchor - 20

        
        changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        cancelChangePasswordButton.addTarget(self, action: #selector(cancelChangePassword), for: .touchUpInside)
    }
    
    func changePasswordRequest(user: User, finishedCallback : @escaping( _ result : Any) -> ()) {
        AF.request(kUrlChangePassword,
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).response { response in
            if let data = response.data {
                finishedCallback(data)
            }
        }
    }
}

extension ChangeUserPasswordViewController {
    
    @objc func changePassword() {

        if oldPasswordTextField.text!.isEmpty || newPasswordTextField.text!.isEmpty {
            self.showAlert(title: "旧密码或新密码为空", subtitle: "")
            return
        }
        let user = User()
        user.userName = defaults.string(forKey: AccountInfo().userName)
        user.password = oldPasswordTextField.text
        user.newPassword = newPasswordTextField.text
        changePasswordRequest(user: user) { result in
            if let resultJSON = try? JSON(data: result as! Data) {
                if resultJSON["code"] == "200" {
                    self.showAlert(title: "密码修改成功！", subtitle: "")
                    self.dismiss(animated: true)
                    self.didChangedPassword()
                }else if resultJSON["code"] == "600" {
                    self.showAlert(title: "密码修改失败!", subtitle: "密码错误")
                }else {
                    self.showAlert(title: "密码修改失败!", subtitle: "未知原因")
                }
            }
        }
    }
    
    @objc func cancelChangePassword() {
       dismiss(animated: true)
    }
}
