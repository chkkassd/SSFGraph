//
//  ScatterViewController.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/6/7.
//  Copyright © 2018年 PETER SHI. All rights reserved.
//

import UIKit
import SSFGraphKit

class ScatterViewController: UIViewController {

    var graphView: SSFScatterGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let data = [("Shanghai", 2500.0),("Beijing", 3200.0),("Houston", 300.0),("New York", 1500.0),("Berlin", 1400.0)]
        graphView = SSFScatterGraphView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 400), sourceData: data)
//        graphView.barColor = UIColor.green   //折线图和散点图默认无法改这个属性
//        graphView.strokeColor = UIColor.black //折线图和散点图默认无法改这个属性
        graphView.textColor = UIColor.darkGray
        graphView.textFont = UIFont.systemFont(ofSize: 16)
//        graphView.lineWidth = 4.0
//        graphView.lineColor = UIColor.red
//        graphView.isOutstanding = true
        graphView.scatterColor = UIColor.orange
        graphView.scatterType = .circle
        self.view.addSubview(graphView)
    }

}
