//
//  NoteWaterFallViewController.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/10.
//

import UIKit
import Anchorage

class NoteWaterFallViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupUI()
    }
    
    var noteWaterFallView: NoteWaterFallView = NoteWaterFallView()
    var labelBar: UILabel = {
        let label = UILabel(frame: .zero, text: "本地草稿", textColor: .label, bgColor: UIColor(named: kSecondLevelColor)!, font: 24, textAlignment: .center)
        label.layer.cornerRadius = 8
        return label
    }()
    func setupUI() {
        noteWaterFallView.isDraftNote = true
        noteWaterFallView.backgroundColor = UIColor(named: kThirdLevelColor)
        self.view.backgroundColor = UIColor(named: kThirdLevelColor)
        self.view.addSubview(labelBar)
        self.view.addSubview(noteWaterFallView)
        self.navigationController?.isNavigationBarHidden = false
        
        labelBar.topAnchor == self.view.topAnchor
        labelBar.horizontalAnchors == view.horizontalAnchors
        
        noteWaterFallView.topAnchor == labelBar.bottomAnchor + 5
        noteWaterFallView.horizontalAnchors == view.horizontalAnchors
        noteWaterFallView.bottomAnchor == view.bottomAnchor + kCustomGlobalMargin
    }
    
}
