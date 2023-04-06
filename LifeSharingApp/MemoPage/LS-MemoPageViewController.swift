//
//  LS-MemoPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit
import Anchorage

class LS_MemoPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(named: kSecondLevelColor)
        setupUI()
    }
    

//MARK: 变量区
    var memos: [Memo] = [
        Memo(memoText: "7：00 起床", reminderDate: "2023/4/7", isChecked: false),
        Memo(memoText: "7：30 洗漱", reminderDate: "2023/4/7", isChecked: false),
        Memo(memoText: "8：00 吃早饭", reminderDate: "2023/4/7", isChecked: false), ]
    lazy var memosTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "MemoTableViewCell")
        tableView.backgroundColor = UIColor(named: kSecondLevelColor)
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    lazy var addMemoBtn: UIBarButtonItem = {
//        let btn = UIButton(frame: .zero, tintColor: .orange, buttonType: .system, title: "", bgColor: .systemBackground, cornerRadius: 0)
        let image = UIImage(systemName: "plus.circle.fill")
        let btn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addMemo))
        btn.tintColor = .orange
        return btn
    }()
    
//MARK: 自定义方法
    func setupUI() {
        self.view.addSubview(memosTableView)
        self.navigationItem.rightBarButtonItem = addMemoBtn

        //约束
        memosTableView.topAnchor == self.view.topAnchor
        memosTableView.bottomAnchor == self.view.bottomAnchor
        memosTableView.horizontalAnchors == self.view.safeAreaLayoutGuide.horizontalAnchors
    }

}

//MARK: 代理方法
extension LS_MemoPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as! MemoTableViewCell
        cell.backgroundColor = UIColor(named: kThirdLevelColor)
        cell.checkBtn.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        cell.memoLabel.text = "\(memos[indexPath.row].memoText)"
        return cell
    }
    
    
}
extension LS_MemoPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1")
        let vc = MemoAddingViewController()
        vc.memoEditTextField.text = memos[indexPath.row].memoText
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK: 事件
extension LS_MemoPageViewController {
    @objc func didClick() {
        print("Click")
    }
    
    @objc func addMemo() {
        print("yeah")
        self.navigationController?.pushViewController(MemoAddingViewController(), animated: false)

    }
}
