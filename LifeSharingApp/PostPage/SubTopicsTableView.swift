//
//  SubTopicsTableView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/4.
//

import UIKit
import Anchorage

class SubTopicsTableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var subTopics: [String] = ["#意式咖啡", "#制作冰美式", "#如何在家制作蛋糕", "#果汁","#果汁","#意式咖啡", "#制作冰美式", "#如何在家制作蛋糕", "#果汁","#果汁","#意式咖啡", "#制作冰美式", "#如何在家制作蛋糕", "#果汁","#果汁","#意式咖啡", "#制作冰美式", "#如何在家制作蛋糕", "#果汁","#果汁","#意式咖啡", "#制作冰美式", "#如何在家制作蛋糕", "#果汁","#果汁",]
    lazy var subTopicTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(SubTopicsTableViewCell.self, forCellReuseIdentifier: "SubTopicsTableViewCell")
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = UIColor(named: kThirdLevelColor)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    func setupUI() {
        self.addSubview(subTopicTableView)
        self.backgroundColor = .clear
        //约束
//        subTopicTableView.edgeAnchors == self.edgeAnchors
        subTopicTableView.leftAnchor == self.leftAnchor + kCustomGlobalMargin
        subTopicTableView.rightAnchor == self.rightAnchor - kCustomGlobalMargin
        subTopicTableView.topAnchor == self.topAnchor + kCustomGlobalMargin
        subTopicTableView.bottomAnchor == self.safeAreaLayoutGuide.bottomAnchor

    }
}

extension SubTopicsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTopicsTableViewCell", for: indexPath) as! SubTopicsTableViewCell
        cell.subTopicLabel.text = subTopics[indexPath.row]
        return cell
    }
    
}
extension SubTopicsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(tableView.cellForRow(at: indexPath)!)
        print(subTopics[indexPath.row])
         
    }
}
