//
//  SSFScatterGraphView.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/6/1.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import UIKit

public class SSFScatterGraphView: SSFBarGraphView, SSFScatterGraphViewProtocol {
    
    //draw the scatters with these source
    private var drawScatters: [(CGPoint, CGFloat)]?
    
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
    
    public var scatterColor: UIColor = UIColor.black {
        didSet {
            if scatterColor != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    public var scatterType: ScatterType = .circle {
        didSet {
            if scatterType.rawValue != oldValue.rawValue {
                setNeedsDisplay()
            }
        }
    }
    
    public enum ScatterType: Int {
        case circle = 1
        case square
    }
    
    //sourceData's element is tuple type.(text, value),text represents the bar label,value represents the bar values.
    override public init(frame: CGRect, sourceData: [(String, Double)]) {
        super.init(frame: frame, sourceData: sourceData)
        guard let diagram = combinedDiagram else { return }
        drawScatters = scatterGraph(diagram: diagram, rect: self.bounds)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        guard let diagram = combinedDiagram, let scatters = drawScatters else {return}
        let context = UIGraphicsGetCurrentContext()
        context?.draw(diagram, in: rect)
        context?.draw(scatters: scatters, scatterColor: scatterColor, scatterType: scatterType)
    }
}

extension CGContext {
    //draw the scatters with attribute
    func draw(scatters: [(CGPoint, CGFloat)], scatterColor: UIColor, scatterType: SSFScatterGraphView.ScatterType) {
        guard scatters.count > 0 else {return}
        saveGState()
        scatterColor.set()
        scatters.forEach { (point, radius) in
            switch scatterType {
            case .circle:
                fillEllipse(in: CGRect(x:point.x - radius/6 , y: point.y - radius/6, width: radius/3, height: radius/3))
            case .square:
                fill(CGRect(x:point.x - radius/6 , y: point.y - radius/6, width: radius/3, height: radius/3))
            }
        }
        restoreGState()
    }
}
