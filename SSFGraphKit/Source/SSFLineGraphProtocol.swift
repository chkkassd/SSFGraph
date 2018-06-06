//
//  SSFLineGraphProtocol.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/5/22.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import Foundation
import UIKit

protocol SSFLineGraphProtocol {
    func lineGraph(diagram: Diagram, rect: CGRect) -> [CGPoint]
}

extension SSFLineGraphProtocol {

    //return every rectangle's top center point
    func lineGraph(diagram: Diagram, rect: CGRect) -> [CGPoint] {
        var points = [(CGPoint, CGRect)]()
        diagram.pointsOfPrimitive(rect, direction: .topBorder, primitiveType: .rectangle, points: &points)
        return points.map {$0.0}.reject {$0.x.isNaN || $0.y.isNaN}
    }
}

