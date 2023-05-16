//
//  LS-LoginViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/23.
//

import UIKit
import Anchorage
import Alamofire
import SwiftyJSON

var loginVC = UIViewController()

class LS_LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginVC = self
        self.setupUI()
        self.getAllUser()

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
    
    lazy var loginStackView: UIStackView = {
        let loginStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return loginStackView
    }()
    
    //MARK: 自定义方法
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        self.view.addSubview(loginStackView)
        self.view.addSubview(loginLabel)
        loginStackView.addArrangedSubview(userNameTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)
        loginStackView.addArrangedSubview(registerButton)
        
        let _ = Anchorage.batch(active: true) {
            
            loginStackView.centerXAnchor /==/ view.centerXAnchor
            loginStackView.centerYAnchor /==/ 2 * view.centerYAnchor / 3
            loginStackView.widthAnchor /==/ 2 * view.widthAnchor / 3
            loginStackView.heightAnchor /==/ view.heightAnchor / 4
            

            loginLabel.centerXAnchor /==/ view.centerXAnchor
            loginLabel.bottomAnchor /==/ loginStackView.topAnchor - 20
                        
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
    
    func getAllUser() {
        AF.request(kUrlGetAllUser, method: .get).responseString { response in
//            print("Response String: \(response.value)")
        }
    }
    
    func getAllUserJSON() {
        AF.request(kUrlGetAllUser, method: .get).response { response in
            //            debugPrint(response)
//            print(response.value)
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            if let result = response.value {
                print(result)
                do{
                    let data = try decoder.decode([User].self, from: result!)
                    print(data)
                }catch {
                    
                }
            }
            
//            let str = String(data: data, encoding: .utf8)
        }
    }
    
    func loginRequest(user: User, finishedCallback : @escaping( _ result : Any) -> ()) {
        AF.request(kUrlLogin,
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: Result.self) { response in
            if let data = response.data {
                finishedCallback(data)
            }
        }
    }
    @objc func tabToLogin() {
        print("login")
        self.showLoadingAni()
        var user = User()
        user.userName = userNameTextField.text
        user.password = passwordTextField.text
        self.loginRequest(user: user) { result in
            let result = try? JSON(data: result as! Data)
            if result!["code"] == "200" {
                self.showAlert(title: "登陆成功!", subtitle: "")
//                print("登录后：本地存储token：\(result!["data"]["userName"])", defaults.value(forKey: LoginInfo().token))
                defaults.set("\(result!["data"]["token"])", forKey: LoginInfo().token)
                
                print("登录后：本地存储token：\(result!["data"]["userName"])", defaults.value(forKey: LoginInfo().token))

                let userProfileVC = UserProfileViewController()
                aboutPageViewController.removeAllSubViewController()
                aboutPageViewController.addSubViewController(subVC: userProfileVC)

            }else {
                self.showAlert(title: "登录失败!", subtitle: "")
            }
        }
//        self.loadingAnimation()
//        let vc = LS_TabBarViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.hideAlert()
        self.hideLoadingAni()
    }
    
    @objc func tabToResgister() {
        self.getAllUserJSON()
        print("register")
    }
}

extension LS_LoginViewController {
    
    public static func getCurrentUserRequest(finished : @escaping( _ result : JSON) -> ()) {
        AF.request(kUrlGetCurrentUser,
                   method: .get,
                   headers: headers).responseDecodable(of: Result.self) { response in
            if let data = response.data {
                let result = try? JSON(data: data)
                finished(result!)
//                print(result!)
//                print(result!["data"])
            }
        }
    }
    
    public static func isLogin() -> Bool {
        var isLogin: Bool = true
        var code = 0
        AF.request(kUrlGetCurrentUser,
                   method: .get,
                   headers: headers).responseDecodable(of: Result.self) { response in
            if let data = response.data {
                let result = try? JSON(data: data)
                if result!["code"] == "200" {
                    isLogin = true
                    code = 200
                }else {
                    isLogin = false
                    code = 444
                }
                print("isLogin result:", result)
            }
        }
        print("isLoginTestResult-code:", code)
        print("isLoginTestResult-islogin: ", isLogin)
        return isLogin

//        getCurrentUserRequest { result in
////            print(result["data"])
//            if result["code"] == "200" {
//                isLogin = true
//            }else {
//                isLogin = false
//            }
//            print("isLogin result:", result)
//        }
    }
    
}
