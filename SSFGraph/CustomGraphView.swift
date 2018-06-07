//
//  CustomGraphView.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/6/7.
//  Copyright © 2018年 PETER SHI. All rights reserved.
//

import UIKit
import SSFGraphKit

class CustomGraphView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        //rect
        let blueRect = Diagram.rect(width: 30.0, height: 15.0).filled(UIColor.blue).stroked(UIColor.black).aligned(to: CGPoint.top)
        //square
        let redSquare = Diagram.square(side: 50.0).filled(UIColor.red).stroked(UIColor.black).aligned(to: CGPoint.top)
        //circle
        let greenCircle = Diagram.circle(diameter: 80.0).filled(UIColor.green).stroked(UIColor.black).aligned(to: CGPoint.top)
        //text
        let orangeText = Diagram.text(theText: "James Harden", width: 50.0, height: 10.0, textAttribute: [TextAttribute.font: UIFont.systemFont(ofSize: 20.0), TextAttribute.textColor: UIColor.orange]).aligned(to: CGPoint.top)
        let combinedDiagram = blueRect|||redSquare|||greenCircle---orangeText
        
        let context = UIGraphicsGetCurrentContext()
        context?.draw(combinedDiagram, in: rect)
    }

}
