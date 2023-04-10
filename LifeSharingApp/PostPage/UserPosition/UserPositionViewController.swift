//
//  UserPositionViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/10.
//

import UIKit
import Anchorage

class UserPositionViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getLocation()
        
    }
    private let locationManager = AMapLocationManager()
    
    var positions = [["不显示位置", ""]]
    lazy var positionSearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 20
        searchBar.placeholder = "搜索位置"
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
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.locationTimeout = 2
        
        locationManager.reGeocodeTimeout = 2
        
        //网络请求，耗时任务,异步执行
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                    
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            //对weak修饰的self进行解包
            guard let poiVC = self else { return }
            
            if let reGeocode = reGeocode {
                print("reGeocode:", reGeocode)
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else {return}
                //判断是否为直辖市，若为直辖市则省级名称为空
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                let currentLocation = [reGeocode.poiName!,"\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")"]
                poiVC.positions.append(currentLocation)
                print("当前地点：\(province)\(reGeocode.city!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")")
            }
            //因为这个请求是异步执行的耗时任务，在tableview初始化后可能请求仍未返回数据，所以需要在请求返回数据后对tableview的视图进行刷新。
            poiVC.positionTableView.reloadData()
        })
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
    
}

extension UserPositionViewController: AMapLocationManagerDelegate {
    
}

