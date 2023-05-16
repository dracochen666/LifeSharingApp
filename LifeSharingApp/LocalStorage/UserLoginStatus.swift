//
//  UserLoginStatus.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/16.
//

import Foundation

class UserLoginStatus {
    
    public static func isLogin() -> Bool{
        print("UserStatus:", defaults.string(forKey: LoginInfo().token))
        if defaults.value(forKey: LoginInfo().token) as! String != "" {
            return true
        }else {
            return false
        }
    }
}
