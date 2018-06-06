//
//  SSFGraph.swift
//  SSFGraph
//
//  Created by 赛峰 施 on 2018/5/9.
//  Copyright © 2018年 赛峰 施. All rights reserved.
//The most important point is that we firstly forcous on how to describe a graph, and then we draw it.

import Foundation
import UIKit
import CoreGraphics

//The primitive of a graph,such as rectangle,text and so on.
public enum Primitive {
    case ellipse
    case rectangle
    case text(String, [TextAttribute: Any])
    case line(CGPoint, CGPoint)
    
    var lineMonotonicity: Monotonicity {
        switch self {
        case let .line(sPoint, ePoint):
            if sPoint.y < ePoint.y {
                return .increase
            } else if sPoint.y == ePoint.y {
                return .none
            } else {
            return .decrease
            }
        default:
            return .none
        }
    }
}

//Use this enum to describe graph including size,poisition,attribute and so on.And we use recursion.
public indirect enum Diagram {
    case primitive(CGSize, Primitive)
    case beside(Diagram, Diagram)
    case below(Diagram, Diagram)
    case attribute(Attribute, Diagram)
    case align(CGPoint, Diagram)
}

//The attribute of a diagram
public enum Attribute {
    case fillColor(UIColor)
    case strokeColor(UIColor)
}

//The attribute of a text
public enum TextAttribute {
    case font
    case textColor
}

enum Monotonicity {
    case increase
    case decrease
    case none
}

//Represent the border of a rect
public enum BorderDirection {
    case topBorder
    case bottomBorder
    case leftBorder
    case rightBorder
}

extension Diagram {
    fileprivate var size: CGSize {
        switch self {
        case .primitive(let size, _):
            return size
        case .attribute(_, let d):
            return d.size
        case let .beside(l, r):
            return CGSize(width: l.size.width + r.size.width, height: max(l.size.height, r.size.height))
        case let .below(up, down):
            return CGSize(width: max(up.size.width, down.size.width), height: up.size.height + down.size.height)
        case .align(_, let d):
            return d.size
        }
    }
    
    //inital a nill graph
    public init() {
        self = .primitive(CGSize(width: 0, height: 0), .rectangle)
    }
    
    // convenience function
    static public func rect(width: CGFloat, height: CGFloat) -> Diagram {
        return .primitive(CGSize(width: width, height: height), .rectangle)
    }
    
    static public func circle(diameter: CGFloat) -> Diagram {
        return .primitive(CGSize(width: diameter, height: diameter), .ellipse)
    }
    
    static public func text(theText: String, width: CGFloat, height: CGFloat, textAttribute: [TextAttribute: Any]) -> Diagram {
        return .primitive(CGSize(width: width, height: height), .text(theText, textAttribute))
    }
    
    static public func square(side: CGFloat) -> Diagram {
        return rect(width: side, height: side)
    }
    
    static public func straightLine(startPoint: CGPoint, endPoint: CGPoint) -> Diagram {
        return .primitive(startPoint.sizeWithPoint(endPoint), .line(startPoint, endPoint))
    }
    
    public func filled(_ color: UIColor) -> Diagram {
        return .attribute(.fillColor(color), self)
    }
    
    public func stroked(_ color: UIColor) -> Diagram {
        return .attribute(.strokeColor(color), self)
    }
    
    public func aligned(to position: CGPoint) -> Diagram {
        return .align(position, self)
    }
    
    //return every primitive's top(bottom or left or right) border center point according the rect
    public func pointsOfPrimitive(_ rect: CGRect, direction: BorderDirection, primitiveType: Primitive, points: inout [(CGPoint, CGRect)]) {
        switch self {
        case let .primitive(size, primitive):
            let bounds = size.fit(into: rect, alignment: CGPoint.center)
            switch primitiveType {
            case .ellipse:
                if case .ellipse = primitive {
                    let point = bounds.borderCenterPoint(direction)
                    points.append(point)
                }
            case .rectangle:
                if case .rectangle = primitive {
                    let point = bounds.borderCenterPoint(direction)
                    points.append(point)
                }
            case .text(_):
                if case .text = primitive {
                    let point = bounds.borderCenterPoint(direction)
                    points.append(point)
                }
            case .line(_, _):
                if case .line = primitive {
                    let point = bounds.borderCenterPoint(direction)
                    points.append(point)
                }
            }
        case let .align(alignment, diagram):
            let bounds = diagram.size.fit(into: rect, alignment: alignment)
            diagram.pointsOfPrimitive(bounds, direction: direction, primitiveType: primitiveType, points: &points)
        case let .beside(left, right):
            let (lbounds, rbounds) = rect.split(ratio: left.size.width/self.size.width, edge: .minXEdge)
            left.pointsOfPrimitive(lbounds, direction: direction, primitiveType: primitiveType, points: &points)
            right.pointsOfPrimitive(rbounds, direction: direction, primitiveType: primitiveType, points: &points)
        case let .below(up, down):
            let (upBounds, downBounds) = rect.split(ratio: up.size.height/self.size.height, edge: .minYEdge)
            up.pointsOfPrimitive(upBounds, direction: direction, primitiveType: primitiveType, points: &points)
            down.pointsOfPrimitive(downBounds, direction: direction, primitiveType: primitiveType, points: &points)
        case let .attribute(_, diagram):
            diagram.pointsOfPrimitive(rect, direction: direction, primitiveType: primitiveType, points: &points)
        }
    }
}

//MARK: Fit
extension CGSize {
    /**
     Fit a size to a rect,and make sure that the width height ratio stays the same,and then sacle it based on the incoming rectangle, and then adjust the position.
     - Parameters:
        - rect: The incoming rectangle,size is sacled based on it.
        - alignment: The position of scaled size.(x,y),0<=x<=1,0<=y<=1.x=0 represents align left,x=1 represents align right,y=0 represents align top,y=1 represents align bottom.
     - Returns: The rect which has been scaled and adjust accroding incoming rect and alignment.
     - Authors:
     PETER SHI
     - date: 2018.5.10
     */
    fileprivate func fit(into rect: CGRect, alignment: CGPoint) -> CGRect {
        let scale = min(rect.width/self.width, rect.height/self.height)
        let targetSize = scale * self
        let spacerSize = alignment.size * (rect.size - targetSize)
        return CGRect(origin: rect.origin + spacerSize.point, size: targetSize)
    }

    fileprivate var point: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
}

extension CGPoint {
    //discrible the align
    static public let top = CGPoint(x: 0.5, y: 0)
    static public let bottom = CGPoint(x: 0.5, y: 1)
    static public let center = CGPoint(x: 0.5, y: 0.5)
    static public let left = CGPoint(x: 0, y: 0.5)
    static public let right = CGPoint(x: 1, y: 0.5)
    
    fileprivate var size: CGSize {
        return CGSize(width: self.x, height: self.y)
    }
    
    fileprivate func sizeWithPoint(_ anotherPoint: CGPoint) -> CGSize {
        return CGSize(width: abs(self.x - anotherPoint.x), height: abs(self.y - anotherPoint.y))
    }
}

fileprivate func *(l: CGFloat, r: CGSize) -> CGSize {
    return CGSize(width: r.width * l, height: r.height * l)
}

fileprivate func *(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: r.width * l.width, height: r.height * l.height)
}

fileprivate func -(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width - r.width, height: l.height - r.height)
}

fileprivate func +(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x + r.x, y: l.y + r.y)
}

//MARK: Draw
extension CGContext {
    public func draw(_ primitive: Primitive, in frame: CGRect) {
        switch primitive {
        case .rectangle:
            stroke(frame)
            fill(frame)
        case .ellipse:
            strokeEllipse(in: frame)
            fillEllipse(in: frame)
        case let .text(text, textAttribute):
            let font = textAttribute[.font] as! UIFont
            let color = textAttribute[.textColor] as! UIColor
            let attributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(in: frame)
        case let .line(startPoint, endPoint):
            move(to: startPoint)
            addLine(to: endPoint)
            strokePath()
        }
    }
    
    public func draw(_ diagram: Diagram, in bounds: CGRect) {
        switch diagram {
        case let .primitive(size, .line(sPoint, ePoint)):
            let bounds = size.fit(into: bounds, alignment: CGPoint.center)
            let (fitPoint1, fitPoint2) = bounds.fitPoints(monotonicity: Primitive.line(sPoint, ePoint).lineMonotonicity)
            draw(.line(fitPoint1, fitPoint2), in: bounds)
        case let .primitive(size, primitive):
            let bounds = size.fit(into: bounds, alignment: CGPoint.center)
            draw(primitive, in: bounds)
        case let .align(alignment, diagram):
            let bounds = diagram.size.fit(into: bounds, alignment: alignment)
            draw(diagram, in: bounds)
        case let .beside(left, right):
            let (lbounds, rbounds) = bounds.split(ratio: left.size.width/diagram.size.width, edge: .minXEdge)
            draw(left, in: lbounds)
            draw(right, in: rbounds)
        case let .below(up, down):
            let (upBounds, downBounds) = bounds.split(ratio: up.size.height/diagram.size.height, edge: .minYEdge)
            draw(up, in: upBounds)
            draw(down, in: downBounds)
        case let .attribute(attribute, diagram):
            saveGState()
            switch attribute {
            case let .fillColor(color):
                color.setFill()
            case let .strokeColor(color):
                color.setStroke()
            }
            draw(diagram, in: bounds)
            restoreGState()
        }
    }
}

extension CGRect {
    fileprivate func split(ratio: CGFloat, edge: CGRectEdge) -> (CGRect, CGRect) {
        let length = edge.isHorizontal ? width : height
        return divided(atDistance:length * ratio, from:edge)
    }
    
    fileprivate func fitPoints(monotonicity: Monotonicity) -> (CGPoint, CGPoint) {
        switch monotonicity {
        case .increase:
            return (CGPoint(x: self.origin.x, y: self.origin.y + self.size.height), CGPoint(x: self.origin.x + self.size.width, y: self.origin.y))
        case .decrease:
            return (self.origin, CGPoint(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height))
        case .none:
            return (self.origin, CGPoint(x: self.origin.x + self.size.width, y: self.origin.y))
        }
    }
    
    fileprivate func borderCenterPoint(_ direction: BorderDirection) -> (CGPoint, CGRect) {
        switch direction {
        case .topBorder:
            return (self.origin + CGPoint(x: self.width/2, y: 0.0), self)
        case .rightBorder:
            return (self.origin + CGPoint(x: self.width, y: self.height/2), self)
        case .bottomBorder:
            return (self.origin + CGPoint(x: self.width/2, y: self.height), self)
        case .leftBorder:
            return (self.origin + CGPoint(x: 0.0, y: self.height/2), self)
        }
    }
}

extension CGRectEdge {
    fileprivate var isHorizontal: Bool {
        return self == .maxXEdge || self == .minXEdge
    }
}

//MARK: Combinator
precedencegroup VerticalCombination {
    associativity: left
}

precedencegroup HorizontalCombination {
    higherThan: VerticalCombination
    associativity: left
}

infix operator ||| : HorizontalCombination

public func |||(l: Diagram, r: Diagram) -> Diagram {
    return .beside(l, r)
}

infix operator --- : VerticalCombination

public func ---(top: Diagram, bottom: Diagram) -> Diagram {
    return .below(top, bottom)
}

extension Sequence where Iterator.Element == Diagram {
    //combine diagram of a sequence in horizontal
    public var hcat: Diagram {
        return reduce(Diagram(), |||)
    }
    
    //combine diagram of a sequence in vertical
    public var vcat: Diagram {
        return reduce(Diagram(), ---)
    }
}

extension Sequence where Iterator.Element == CGFloat {
    //normalize the value of input, the max is 1.
    public var normalized: [CGFloat] {
        let maxValue = reduce(0, Swift.max)
        return map {$0/maxValue}
    }
}
