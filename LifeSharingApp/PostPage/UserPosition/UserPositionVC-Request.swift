//
//  UserPositionVC-Request.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/12.
//

import Foundation

extension UserPositionViewController {
    
    func locationRequest() {
        //网络请求，耗时任务,异步执行
        showLoadingAnimation()
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            self?.hideLoadingAnimation()
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
            
            if let location = location {
                poiVC.latitude = location.coordinate.latitude
                poiVC.longitude = location.coordinate.longitude
                
                //通过检索器与检索条件获取周边POI
                poiVC.aroundSearch?.aMapPOIAroundSearch(poiVC.aroundRequest)
            }
            
            if let reGeocode = reGeocode {
                print("reGeocode:", reGeocode)
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else {return}
                //判断是否为直辖市，若为直辖市则省级名称为空
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                let currentLocation = [
                    reGeocode.poiName ?? "未知地点",
                    "\(province)\(reGeocode.city ?? "")\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")"]
                poiVC.positions.append(currentLocation)
                print("当前地点：\(province)\(reGeocode.city!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")")
            }
            //因为这个请求是异步执行的耗时任务，在tableview初始化后可能请求仍未返回数据，所以需要在请求返回数据后对tableview的视图进行刷新。
            poiVC.positionTableView.reloadData()
        })
    }
}

extension UserPositionViewController: AMapLocationManagerDelegate {

}

extension UserPositionViewController: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.count == 0 {
                return
        }
        for index in 0..<response.count  {
            self.positions.append([response.pois[index].name, response.pois[index].address])
        }
        self.positionTableView.reloadData()
        
    }
    
    
}


