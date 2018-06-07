//
//  CustomViewController.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/6/7.
//  Copyright © 2018年 PETER SHI. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let customGraphView = CustomGraphView(frame: CGRect(x: 0.0, y: 150.0, width: UIScreen.main.bounds.width, height: 400.0))
        self.view.addSubview(customGraphView)
    }

}
