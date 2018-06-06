//
//  SSFGraphView.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/6/4.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import UIKit

public class SSFGraphView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var combinedDiagram: Diagram?
    
    public var barColor: UIColor = UIColor.black
    
    
    public var textColor: UIColor = UIColor.black
    //sourceData's element is tuple type.(text, value),text represents the bar label,value represents the bar values.
    convenience public init(frame: CGRect, backgroundColor: UIColor, sourceData: [(String, Double)]) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
//        combinedDiagram = barGraph(sourceData: sourceData)
    }
    
    override public func draw(_ rect: CGRect) {
        guard let diagram = combinedDiagram else {return}
        let context = UIGraphicsGetCurrentContext()
        context?.draw(diagram, in: rect)
    }
}
