//
//  afTestViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/19.
//

import UIKit
import Alamofire
import Anchorage
import SwiftyJSON


class afTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(imageView)
        imageView.horizontalAnchors == self.view.horizontalAnchors - 100
        imageView.verticalAnchors == self.view.verticalAnchors - 100
        
        getCoverPhoto2()
    }
    
    var imageView = UIImageView()
    
    func getCoverPhoto() -> UIImage {
        let pageNum = 1
        let pageSize = 5
        var group = DispatchGroup()
        tabBarViewController.showLoadingAni()
        group.enter()
        var notes: [Note] = []
        
        AF.request(kUrlNotePages+"?pageNum=\(pageNum)&pageSize=\(pageSize)",
                   method: .get,
                   headers: headers).responseDecodable(of: [Note].self) { response in
            if let data = response.data {
                let result = try? JSON(data: data )
                let noteRecord = result!["records"].arrayValue[2]
                if let imageBase64 = noteRecord["noteCoverPhoto"].string {
                    print("file")
                    
                    let imageArray = NSData(base64Encoded: imageBase64)
                    //                        print(imageArray)
                    let imageData = Data(referencing: imageArray!)
                    self.imageView.image = UIImage(data: imageData) ?? UIImage(systemName: "xmark.icloud")
                } else {
                    print("missing `file` entry")
                }
            }

      
            group.leave()
            group.notify(queue: .main) {
                
            }
            
        }
        return UIImage()

    }
    
    func getCoverPhoto2() -> UIImage {
        let pageNum = 1
        let pageSize = 5
        var group = DispatchGroup()
        tabBarViewController.showLoadingAni()
        group.enter()
        var notes: [Note] = []
        
        AF.request(kUrlNotePages+"?pageNum=\(pageNum)&pageSize=\(pageSize)",
                   method: .get,
                   headers: headers).responseDecodable(of: [Note].self) { response in
            if let data = response.data {
                let result = try? JSON(data: data )
                let noteRecord = result!["records"].arrayValue[2]

                let decoder = JSONDecoder()
                if let imageBase64 = noteRecord["notePhotos"].string {
                    print("file")
                    let imageBase64 = NSData(base64Encoded: imageBase64)
                    let imageData = Data(referencing: imageBase64!)
                    let photosDataArr = try? decoder.decode([Data].self, from: imageData)
                    self.imageView.image = UIImage(data: photosDataArr![0])
                }
                
            }

      
            group.leave()
            group.notify(queue: .main) {
                
            }
            
        }
        return UIImage()

    }
}
