//
//  Extentsion-String.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/8.
//

import Foundation
import DateToolsSwift

extension String {
    
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}

extension Date {
    var formattedDate: String {
        let currentYear = Date().year
        if year == currentYear {
            if isToday {
                return "今天\(format(with: "HH:mm"))"
            }else if isYesterday {
                return "昨天\(format(with: "HH:mm"))"
            }else {
                return format(with: "mm-dd")
            }
        }else {
            return format(with: "yyyy-mm-dd")
        }
    }
}
