//
//  Extension-UIImage.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//
import UIKit

extension UIImage {
    class func generateImageWithColor(color:UIColor,size:CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    convenience init?(data: Data?) {//可失败便利构造器，传入可选型Data，返回UIimage
        if let unwrappedData = data {
            self.init(data: unwrappedData)
        }else {
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat {
        case low =  0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    
    func JPEGDataWithQuality(_ quality: JPEGQuality) -> Data? {
       return jpegData(compressionQuality: quality.rawValue)
    }
}
