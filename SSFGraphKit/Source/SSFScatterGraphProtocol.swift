//
//  SSFScatterGraphProtocol.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/6/1.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//

import Foundation
import UIKit

protocol SSFScatterGraphViewProtocol {
    func scatterGraph(diagram: Diagram, rect: CGRect) -> [(CGPoint, CGFloat)]
}

extension SSFScatterGraphViewProtocol {
    func scatterGraph(diagram: Diagram, rect: CGRect) -> [(CGPoint, CGFloat)] {
        var points = [(CGPoint, CGRect)]()
        diagram.pointsOfPrimitive(rect, direction: .topBorder, primitiveType: .rectangle, points: &points)
        return points.map {($0.0, $0.1.width)}.reject {$0.0.x.isNaN || $0.0.y.isNaN}
    }
}
