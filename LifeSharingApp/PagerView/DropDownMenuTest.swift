//
//  DropDownMenuViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/27.
//

import UIKit

class DropdownMenuTest: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dropdownMenuItems: [String] = ["Item 1", "Item 2", "Item 3"]
    var dropdownMenuButton: UIButton!
    var dropdownMenuTableView: UITableView!
    var isDropdownMenuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropdownMenuButton = UIButton(type: .system)
        dropdownMenuButton.setTitle("Menu", for: .normal)
        dropdownMenuButton.addTarget(self, action: #selector(toggleDropdownMenu), for: .touchUpInside)
        view.addSubview(dropdownMenuButton)
        
        dropdownMenuTableView = UITableView()
        dropdownMenuTableView.delegate = self
        dropdownMenuTableView.dataSource = self
        dropdownMenuTableView.isHidden = true
        view.addSubview(dropdownMenuTableView)
        
        // 设置约束
        dropdownMenuButton.translatesAutoresizingMaskIntoConstraints = false
        dropdownMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dropdownMenuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        dropdownMenuTableView.translatesAutoresizingMaskIntoConstraints = false
        dropdownMenuTableView.topAnchor.constraint(equalTo: dropdownMenuButton.bottomAnchor).isActive = true
        dropdownMenuTableView.leadingAnchor.constraint(equalTo: dropdownMenuButton.leadingAnchor).isActive = true
        dropdownMenuTableView.trailingAnchor.constraint(equalTo: dropdownMenuButton.trailingAnchor).isActive = true
        dropdownMenuTableView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    @objc func toggleDropdownMenu() {
        isDropdownMenuVisible = !isDropdownMenuVisible
        dropdownMenuTableView.isHidden = !isDropdownMenuVisible
    }
    
    // MARK: - UITableView Delegate and DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = dropdownMenuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = dropdownMenuItems[indexPath.row]
        print("Selected item: \(selectedItem)")
        // 在这里执行你需要的操作
        
        toggleDropdownMenu()
    }
}

