//
//  Base64.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/19.
//

import Foundation

public class Base64Util {
    //Base64转UIImage
      public static func convertStrToImage(_ imageStr:String) ->UIImage?{
           if let data: NSData = NSData(base64Encoded: imageStr, options:NSData.Base64DecodingOptions.ignoreUnknownCharacters)
           {
               if let image: UIImage = UIImage(data: data as Data)
               {
                   return image
               }
           }
           return nil
       }
    
       
       //UIImage转Base64
    public static func getStrFromImage(_ image: UIImage, isMediumQuality: Bool = false) -> String{
        let imageOrigin = image
        var dataTmp: Data?
        if isMediumQuality {
            dataTmp = image.JPEGDataWithQuality(.medium)
        }else {
            dataTmp = image.pngData()
        }
        if let data = dataTmp {
           let imageStrTT = data.base64EncodedString()
           return imageStrTT
        }

           return ""
       }
}
