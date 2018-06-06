//
//  GraphView.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/5/16.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import UIKit

public class SSFBarGraphView: UIView, SSFBarGraphProtocol {
    
    //sourceData's element is tuple type.(text, value),text represents the bar label,value represents the bar values.
    public init(frame: CGRect, sourceData: [(String, Double)]) {
        super.init(frame: frame)
        self.sourceData = sourceData
        self.backgroundColor = UIColor.clear
        combinedDiagram = barGraph(sourceData: sourceData, barColor: barColor, textColor: textColor, textFont: textFont, strokeColor: strokeColor)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var combinedDiagram: Diagram?
    
    private var sourceData: [(String, Double)]?
    
    //color of bar graph
    public var barColor: UIColor = UIColor.black {
        didSet {
            guard barColor != oldValue, let data = sourceData else {return}
            combinedDiagram = barGraph(sourceData: data, barColor: barColor, textColor: textColor, textFont: textFont, strokeColor: strokeColor)
            setNeedsDisplay()
        }
    }
    
    //color of bar graph's path
    public var strokeColor: UIColor = UIColor.black {
        didSet {
            guard barColor != oldValue, let data = sourceData else {return}
            combinedDiagram = barGraph(sourceData: data, barColor: barColor, textColor: textColor, textFont: textFont, strokeColor: strokeColor)
            setNeedsDisplay()
        }
    }

    public var textColor: UIColor = UIColor.black {
        didSet {
            guard textColor != oldValue, let data = sourceData else {return}
            combinedDiagram = barGraph(sourceData: data, barColor: barColor, textColor: textColor, textFont: textFont, strokeColor: strokeColor)
            setNeedsDisplay()
        }
    }
    
    public var textFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            guard textFont != oldValue, let data = sourceData else {return}
            combinedDiagram = barGraph(sourceData: data, barColor: barColor, textColor: textColor, textFont: textFont, strokeColor: strokeColor)
            setNeedsDisplay()
        }
    }
    
    override public func draw(_ rect: CGRect) {
        guard let diagram = combinedDiagram else {return}
        let context = UIGraphicsGetCurrentContext()
        context?.draw(diagram, in: rect)
    }
}
