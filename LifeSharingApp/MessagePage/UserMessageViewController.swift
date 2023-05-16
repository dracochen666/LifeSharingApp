//
//  UserMessageViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/15.
//

import UIKit

class UserMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    let cellIdentifier = "MessageTableViewCell"
    var messageData = [("avatar1", "小明", "2小时前"), ("avatar2", "小红", "1天前"), ("avatar3", "小绿", "3天前"), ("avatar4", "小黄", "1周前")]

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

  
    func setupUI() {
        // 添加tableView到视图中
        view.addSubview(tableView)
        
        // 设置tableView的约束
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // 注册TableViewCell
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // 设置TableView的数据源和委托
        tableView.dataSource = self
        tableView.delegate = self
    }

}

//MARK: 代理方法
extension UserMessageViewController: UITableViewDataSource{
    // 返回TableViewCell的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
    // 配置TableViewCell的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        cell.avatarImageView.image = UIImage(systemName: "person.circle.fill")
        cell.usernameLabel.text = messageData[indexPath.row].1
        cell.lastChatTimeLabel.text = messageData[indexPath.row].2
        
        return cell
    }
}

extension UserMessageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ChatViewController(), animated: true)
        
    }
}
