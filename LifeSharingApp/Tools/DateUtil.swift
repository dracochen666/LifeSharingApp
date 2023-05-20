//
//  DateUtil.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/20.
//

import Foundation

class DateUtil {
    /// 日期字符串转化为Date类型
      ///
      /// - Parameters:
      ///   - string: 日期字符串
      ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
      /// - Returns: Date类型
      static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-ddHH:mm:ss") -> Date {
          let dateFormatter = DateFormatter.init()
          dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
          let date = dateFormatter.date(from: string)
          if let date = date {
              return date
          }else {
              return Date()
          }
      }
}
