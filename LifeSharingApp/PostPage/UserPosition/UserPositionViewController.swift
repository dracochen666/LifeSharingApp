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
            
//            if let location = location {
//                print("location:", location)
//            }
            
            if let reGeocode = reGeocode {
                print("reGeocode:", reGeocode)
//  reGeocode: AMapLocationReGeocode:{formattedAddress:北京市朝阳区北四环中路靠近学四公寓; country:中国;province:北京市; city:北京市; district:朝阳区; citycode:010; adcode:110105; street:北四环中路; number:33号院; POIName:学四公寓; AOIName:学四公寓;}
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else {return}
                //判断是否为直辖市，若为直辖市则省级名称为空
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                print("当前地点：\(province)\(reGeocode.city!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")")
            }
        })
    }
    
}

extension UserPositionViewController: AMapLocationManagerDelegate {
    
}
