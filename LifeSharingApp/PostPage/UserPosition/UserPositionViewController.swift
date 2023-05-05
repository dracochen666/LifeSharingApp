//
//  UserPositionViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/10.
//

import UIKit
import Anchorage

protocol PassLocationFromUserPositionVC: AnyObject {
    func passLocation(location: String, isDisplayPosition: Bool)
}

class UserPositionViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        //获取当前定位信息
        getLocation()
        //获取周边POI
        getSurroundingPOI()
        aroundSearch?.delegate = self
    }
    //用于获取定位数据
    lazy var locationManager = AMapLocationManager()
    //用于获取周边数据
        //检索器
    lazy var aroundSearch = AMapSearchAPI()
        //检索条件
    lazy var aroundRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: latitude, longitude: longitude)
        return request
    }()
    lazy var keywordsRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = keywords
        return request
    }()
    var positions = [["", ""]]
    //经纬度 在定位回调函数中获取，用于检索周边数据
    var latitude = 0.0
    var longitude = 0.0
    var keywords: String = ""
    
    weak var passPositionDelegate: PassLocationFromUserPositionVC?
    lazy var positionSearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 20
        searchBar.placeholder = "搜索位置"
        searchBar.delegate = self
        return searchBar
    }()
    lazy var positionTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.layer.cornerRadius = kGlobalCornerRadius
        tableView.backgroundColor = UIColor(named: kThirdLevelColor)
        tableView.register(UserPositionTableViewCell.self, forCellReuseIdentifier: "UserPositionTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setupUI() {
        self.view.backgroundColor = UIColor(named: kSecondLevelColor)
        self.view.addSubview(positionSearchBar)
        self.view.addSubview(positionTableView)
        
        //MARK: 约束
        //搜索栏
        positionSearchBar.horizontalAnchors == self.view.horizontalAnchors + kCustomGlobalMargin
        positionSearchBar.topAnchor == self.view.topAnchor + kCustomGlobalMargin
        positionSearchBar.heightAnchor == 60
        
        //位置显示视图
        positionTableView.horizontalAnchors == self.view.horizontalAnchors + kCustomGlobalMargin
        positionTableView.topAnchor == positionSearchBar.bottomAnchor + kCustomGlobalMargin
        positionTableView.bottomAnchor == self.view.safeAreaLayoutGuide.bottomAnchor - kCustomGlobalMargin
        
    }
    
    func getLocation() {
        config()
        locationRequest()
    
    }
    
    func getSurroundingPOI() {
    }
    
    func showLoadingAnimation(title: String = "") {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = title
    }
    func hideLoadingAnimation() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        
    }
}

//MARK: 代理
extension UserPositionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserPositionTableViewCell") as! UserPositionTableViewCell
        cell.poiLabel.text = positions[indexPath.row][0]
        cell.addressLabel.text = positions[indexPath.row][1]

        cell.separatorInset = .init(top: 0, left: kCustomGlobalMargin, bottom: 0, right: kCustomGlobalMargin)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
extension UserPositionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.passPositionDelegate?.passLocation(location: "不显示位置", isDisplayPosition: false)
            return
        }
        let location = positions[indexPath.row][0]
        self.passPositionDelegate?.passLocation(location: location, isDisplayPosition: true)
    }
    
}

//SearchBar代理
extension UserPositionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText.isEmpty {
            print(1)
            aroundSearch?.aMapPOIAroundSearch(aroundRequest)
            return
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
//        positions = [["不显示位置", ""]]
        keywords = searchText
        positions.removeAll()
        showLoadingAnimation()
        print(keywords)
        keywordsRequest.keywords = keywords
        aroundSearch?.aMapPOIKeywordsSearch(keywordsRequest)
        hideLoadingAnimation()
    }
}




