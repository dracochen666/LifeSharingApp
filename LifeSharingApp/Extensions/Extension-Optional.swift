//
//  Extension-Optional.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/8.
//

import Foundation

extension Optional where Wrapped == String {
    
    var unwrappedText: String { self ?? "" }
    
}
