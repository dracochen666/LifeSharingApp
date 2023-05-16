//
//  NetworkTools.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/15.
//

import UIKit
import Alamofire
import SwiftyJSON

//两种网络请求方式: get / post
enum MethodType {
    case get
    case post
}

//封装网络请求工具类
class NetworkTools: NSObject {
    
    //类方法
//    class func requestData(URLString : String, type : MethodType, parameters : [String : Any]? = nil, finishedCallback : @escaping( _ result : Any) -> ()) {
//        //将枚举类型的get／post转换成http请求的get／post
//        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
//        //Alamofire请求方法
//        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
//            //打印数据
//            print(response)
//            //校检服务器返回的数据类型是否正确
//            guard let result = response.result.value else { return }
//            //将结果回调出去
//            finishedCallback(result)
//        }
//        AF.request(URLString,
//                   method: type,
//                   parameters: parameters,
//                   encoder: JSONParameterEncoder.default).responseDecodable(of: Result.self) { response in
//            if let data = response.data {
//                let dataJSON = try? JSON(data: data)
//                debugPrint(dataJSON!["data"]["userId"])
//                debugPrint("token: ",dataJSON!["data"]["token"])
//                finishedCallback(dataJSON!)
//            }
//        }
//    }
}
