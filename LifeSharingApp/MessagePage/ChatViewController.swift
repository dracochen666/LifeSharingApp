//
//  ChatViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/13.
//
import UIKit
import Anchorage

class ChatViewController: UIViewController {

    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        self.view.addGestureRecognizer(swipeRight)
    }
    
    //MARK: Properties
    var messages: [String] = []
    
    //MARK: UI Elements
    let messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: kThirdLevelColor)
        return tableView
    }()
    
    let messageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your message"
        textField.returnKeyType = .done
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    

    
    func setupUI() {
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(messageTableView)
        
        messageTextField.delegate = self
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
        messageTextField.leftAnchor == self.view.leftAnchor + kCustomGlobalMargin
        messageTextField.bottomAnchor == self.view.safeAreaLayoutGuide.bottomAnchor -  kCustomGlobalMargin
        messageTextField.rightAnchor == sendButton.rightAnchor + kCustomGlobalMargin
        
        sendButton.rightAnchor == self.view.rightAnchor
        sendButton.centerYAnchor == messageTextField.centerYAnchor
        
        messageTableView.horizontalAnchors == self.view.horizontalAnchors + kCustomGlobalMargin
        messageTableView.topAnchor == self.view.safeAreaLayoutGuide.topAnchor
        messageTableView.bottomAnchor == messageTextField.topAnchor - kCustomGlobalMargin
    }

}
extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    //MARK: UITableViewDelegate、 UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
}
extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
//        sendButtonTapped()
        return true
    }
}

//MARK: 点击事件
extension ChatViewController {
    @objc func sendButtonTapped() {
        guard let message = messageTextField.text else { return }
        if message.isEmpty {
            return
        }
        messages.append(message)
        messageTableView.reloadData()
        messageTextField.text = ""
    }
    
    @objc func swipeRight() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
