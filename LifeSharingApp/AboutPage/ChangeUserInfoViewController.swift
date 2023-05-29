//
//  ChangeUserInfoViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/25.
//

import UIKit
import Anchorage
import Alamofire

class ChangeUserInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    var didChangedInfo: ()->() = {}

    
    let changePasswordLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "修改用户信息"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()

    let usernameTextField = UITextField(frame: .zero, placeholder: "输入用户名", borderStyle: .roundedRect, isSecureTextEntry: true)

    let changeInfoButton = UIButton(frame: .zero, title: "确认修改", bgColor: .systemRed, cornerRadius: 10)
    let cancelChangeInfoButton = UIButton(frame: .zero, title: "返回主页", bgColor: .systemBlue, cornerRadius: 10)
    
    lazy var changeInfoStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 10, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()

    lazy var changeInfoButtonStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 10, bgColor: .clear, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()
    //MARK: 自定义方法
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        self.view.addSubview(changePasswordLabel)
        self.view.addSubview(changeInfoStackView)
        self.view.addSubview(changeInfoButtonStackView)

        
        changeInfoStackView.addArrangedSubview(usernameTextField)
        
        changeInfoButtonStackView.addArrangedSubview(changeInfoButton)
        changeInfoButtonStackView.addArrangedSubview(cancelChangeInfoButton)
 
        changeInfoStackView.centerXAnchor /==/ view.centerXAnchor
        changeInfoStackView.centerYAnchor /==/ 2 * view.centerYAnchor / 3
        changeInfoStackView.widthAnchor /==/ 2 * view.widthAnchor / 3
        changeInfoStackView.heightAnchor /==/ view.heightAnchor / 10

        changeInfoButtonStackView.topAnchor == changeInfoStackView.bottomAnchor + kCustomGlobalMargin
        changeInfoButtonStackView.leftAnchor == view.leftAnchor + 70
        changeInfoButtonStackView.rightAnchor == view.rightAnchor - 70
        changeInfoButtonStackView.heightAnchor /==/ 90
        
        changePasswordLabel.centerXAnchor /==/ view.centerXAnchor
        changePasswordLabel.bottomAnchor /==/         changeInfoStackView.topAnchor - 20

        
        changeInfoButton.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
        cancelChangeInfoButton.addTarget(self, action: #selector(cancelChangeInfo), for: .touchUpInside)
    }
    
    func changeInfoRequest(user: User, finishedCallback : @escaping( _ result : Any) -> ()) {
        AF.request(kUrlChangeInfo,
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


extension ChangeUserInfoViewController {
    
    @objc func changeInfo() {
        
    }
    
    @objc func cancelChangeInfo() {
       dismiss(animated: true)
    }
}
