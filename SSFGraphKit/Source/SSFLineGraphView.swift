//
//  SSFLineGraphView.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/5/18.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import UIKit

public class SSFLineGraphView: SSFBarGraphView, SSFLineGraphProtocol {
    
    //Draw the line with these points
    private var drawPoints: [CGPoint]?
    
    //bar color is awayls clear in line graph
    override public var barColor: UIColor {
        get {
            return UIColor.clear
        }
        set {}
    }
    
    //stroke color is awayls clear in line graph
    override public var strokeColor: UIColor {
        get {
            return UIColor.clear
        }
        set {}
    }
    
    public var lineWidth: CGFloat = 1.0 {
        didSet {
            if lineWidth != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    public var lineColor: UIColor = UIColor.black {
        didSet {
            if lineColor != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    //Highlight the line join if true, otherwise do not highlight
    public var isOutstanding: Bool = false {
        didSet {
            if isOutstanding != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    //sourceData's element is tuple type.(text, value),text represents the bar label,value represents the bar values.
    override public init(frame: CGRect, sourceData: [(String, Double)]) {
        super.init(frame: frame, sourceData: sourceData)
        guard let diagram = combinedDiagram else { return }
        drawPoints = lineGraph(diagram: diagram, rect: self.bounds)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        guard let diagram = combinedDiagram, let points = drawPoints else {return}
        let context = UIGraphicsGetCurrentContext()
        context?.draw(diagram, in: rect)
        context?.draw(points: points, lineColor: lineColor, lineWidth: lineWidth, isOutStanding: isOutstanding)
    }
}

extension CGContext {
    //draw the line with attribute
    func draw(points: [CGPoint], lineColor: UIColor, lineWidth: CGFloat, isOutStanding: Bool) {
        guard points.count > 0 else {return}
        saveGState()
        lineColor.set()
        setLineWidth(lineWidth)
        setLineJoin(.round)
        setLineCap(.round)
        self.move(to: points.first!)
        points.dropFirst().forEach {
            self.addLine(to: $0)
        }
        self.strokePath()
        
        if isOutStanding {
            points.forEach { point in
                fillEllipse(in: CGRect(x: point.x - lineWidth, y: point.y - lineWidth, width: 2.0*lineWidth, height: 2.0*lineWidth))
            }
        }
        restoreGState()
    }
}
