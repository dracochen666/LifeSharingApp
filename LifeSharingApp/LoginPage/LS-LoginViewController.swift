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
    let goToRegisterButton = UIButton(frame: .zero, title: "注册", bgColor: .systemBlue, cornerRadius: 10)
    
    lazy var loginInfoStackView: UIStackView = {
        let loginStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20, bgColor: UIColor(named: kThirdLevelColor)!, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return loginStackView
    }()
    
    lazy var loginBtnStackView: UIStackView = {
        let StackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20, bgColor: .clear, isLayoutMargin: true, layoutMargins: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), cornerRadius: 8)
        return StackView
    }()
    
    //MARK: 自定义方法
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        
        self.view.addSubview(loginInfoStackView)
        self.view.addSubview(loginLabel)
        self.view.addSubview(loginBtnStackView)
        loginInfoStackView.addArrangedSubview(userNameTextField)
        loginInfoStackView.addArrangedSubview(passwordTextField)
        
        loginBtnStackView.addArrangedSubview(loginButton)
        loginBtnStackView.addArrangedSubview(goToRegisterButton)
        
        let _ = Anchorage.batch(active: true) {
            
            loginInfoStackView.centerXAnchor /==/ view.centerXAnchor
            loginInfoStackView.centerYAnchor /==/ 2 * view.centerYAnchor / 3
            loginInfoStackView.widthAnchor /==/ 2 * view.widthAnchor / 3
            loginInfoStackView.heightAnchor /==/ view.heightAnchor / 9
            
            
            loginLabel.centerXAnchor /==/ view.centerXAnchor
            loginLabel.bottomAnchor /==/ loginInfoStackView.topAnchor - 20
            
            loginBtnStackView.topAnchor == loginInfoStackView.bottomAnchor + kCustomGlobalMargin
            loginBtnStackView.leftAnchor == view.leftAnchor + 70
            loginBtnStackView.rightAnchor == view.rightAnchor - 70
            loginBtnStackView.heightAnchor /==/ 100
                    }
        
        loginButton.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        goToRegisterButton.addTarget(self, action: #selector(goToResgister), for: .touchUpInside)
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
    @objc func tapToLogin() {
        print("login")
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.showAlert(title: "用户名或密码为空", subtitle: "")
            return
        }
        
        let user = User()
        user.userName = userNameTextField.text
        user.password = passwordTextField.text
        let group = DispatchGroup()
        
        group.enter()
        self.showLoadingAni()
        self.loginRequest(user: user) { result in
            let result = try? JSON(data: result as! Data)
            if result!["code"] == "200" {
                let userId = String(result!["data"]["userId"].int ?? -2)
                defaults.set("\(result!["data"]["token"])", forKey: LoginInfo().token)
                defaults.set("\(userId)", forKey: AccountInfo().userId)
                defaults.set("\(result!["data"]["userName"])", forKey: AccountInfo().userName)
                defaults.set("\(result!["data"]["password"])", forKey: AccountInfo().password)

                print("登录成功:")
                print("本地存储信息LoginInfo", defaults.value(forKey: LoginInfo().token)!)
                print("本地存储信息AcountInfo", defaults.value(forKey: AccountInfo().userId)!)
                print("本地存储信息AcountInfo", defaults.value(forKey: AccountInfo().userName)!)
                print("本地存储信息AcountInfo", defaults.value(forKey: AccountInfo().password)!)
                      
                
                self.hideLoadingAni()
                group.leave()
                group.notify(queue: .main) {
                    let userProfileVC = UserProfileViewController()
                    aboutPageViewController.removeAllSubViewController()
                    aboutPageViewController.addSubViewController(subVC: userProfileVC)
                    aboutPageViewController.showAlert(title: "登陆成功！", subtitle: "")
                    self.hideLoadingAni()
                }
                
            }else if result!["code"] == "600"{
                self.hideLoadingAni()
                self.showAlert(title: "用户名或密码错误!", subtitle: "")
            }else {
                self.hideLoadingAni()
                self.showAlert(title: "登录失败!", subtitle: "")

            }
        }

    }
    
    @objc func goToResgister() {
//        self.getAllUserJSON()
        print("register")
        let registerVC = RegisterViewController()
        aboutPageViewController.removeAllSubViewController()
        aboutPageViewController.addSubViewController(subVC: registerVC)
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
