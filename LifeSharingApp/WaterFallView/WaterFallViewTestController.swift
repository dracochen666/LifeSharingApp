//
//  WaterFallViewTestController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/23.
//

import UIKit
import Anchorage

class WaterFallViewTestController: UIViewController {

    let waterFall = NoteWaterFallView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.view.addSubview(waterFall)
        
        waterFall.leftAnchor /==/ self.view.leftAnchor
        waterFall.rightAnchor /==/ self.view.rightAnchor
        waterFall.topAnchor /==/ self.view.topAnchor
        waterFall.bottomAnchor /==/ self.view.bottomAnchor

    }

}
