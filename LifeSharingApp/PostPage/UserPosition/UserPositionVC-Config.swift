//
//  UserPositionVC-Config.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/12.
//

import Foundation

extension UserPositionViewController {
    
    func config() {
        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.locationTimeout = 2
        
        locationManager.reGeocodeTimeout = 2
        
    }
}


