//
//  SSFBarGraphProtocol.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/5/18.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import Foundation
import UIKit

protocol SSFBarGraphProtocol {
    func barGraph(sourceData: [(String, Double)], barColor: UIColor, textColor: UIColor, textFont: UIFont, strokeColor: UIColor) -> Diagram
    func spaceLineDistanceFromTop(diagram: Diagram, rect: CGRect) -> CGFloat?
}

extension SSFBarGraphProtocol {
    
    func barGraph(sourceData: [(String, Double)], barColor: UIColor, textColor: UIColor, textFont: UIFont, strokeColor: UIColor) -> Diagram {
        let values = sourceData.map {CGFloat($0.1)}
        let bars = values.normalized.map { x in
            return Diagram.rect(width: 1, height: 3 * x).stroked(strokeColor).filled(barColor).aligned(to: CGPoint.bottom)
            }.hcat
        let attribute = [TextAttribute.font: textFont, TextAttribute.textColor: textColor]
        let labels = sourceData.map { (string,_) in
            return Diagram.text(theText: string, width: 1, height: 0.3, textAttribute: attribute).aligned(to: CGPoint.top)
            }.hcat
        return bars---labels
    }
    
    func spaceLineDistanceFromTop(diagram:Diagram, rect: CGRect) -> CGFloat? {
        var points = [(CGPoint, CGRect)]()
        diagram.pointsOfPrimitive(rect, direction: .topBorder, primitiveType: .text("",[.textColor: UIColor.black]), points: &points)
        return points.map {$0.0}.reject {$0.x.isNaN || $0.y.isNaN}.first?.y
    }
}
