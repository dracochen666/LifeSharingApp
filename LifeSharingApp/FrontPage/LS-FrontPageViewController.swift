//
//  LS-FrontPageViewController.swift
//  LifeSharing
//
//  Created by 陈龙 on 2023/3/14.
//

import UIKit

class LS_FrontPageViewController:UIViewController {

    override func viewDidLoad() {
        let pageView = PagedView()
        self.view.addSubview(pageView)
    }

//    override func calculateStretchedCellWidths(_ minimumCellWidths: [CGFloat], suggestedStretchedCellWidth: CGFloat, previousNumberOfLargeCells: Int) -> CGFloat {
//        return 10
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
