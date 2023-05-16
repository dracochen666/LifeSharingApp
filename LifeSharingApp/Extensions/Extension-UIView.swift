//
//  Extension-UIView.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/9.
//

import UIKit

extension UIView {
    convenience init(frame: CGRect, bgColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        self.frame = frame
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
    }
    //扩展UIView，找到最上层UIViewController
    //返回该view所在VC
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}
