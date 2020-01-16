//
//  LineGraph.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LineGraph: Graph {
    
    // MARK: - Initializers
    
    override public init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Members
    
    public var yMax: Double = GraphModel.shared.currentLineGraphData.maxY
    public var yMin: Double = GraphModel.shared.currentLineGraphData.minY
    
    public var xMax: Double = GraphModel.shared.currentLineGraphData.maxX
    public var xMin: Double = GraphModel.shared.currentLineGraphData.minX
    
    override public func create() {
        let lineData = GraphModel.shared.currentLineGraphData.lineData
        for line in lineData {
            let encodedExpression = line.encodedExpression
            let lineStyle = GraphModel.shared.getLineStyle(named: line.lineStyle)
            
            let lineLayer = CAShapeLayer()
            lineLayer.frame = self.bounds
            lineLayer.masksToBounds = true
            lineLayer.path = pathForLine(withExpression: encodedExpression.expression)
            lineLayer.strokeColor = lineStyle.lineColor.uiColor.cgColor
            lineLayer.lineWidth = lineStyle.lineWidth
            lineLayer.lineJoin = CAShapeLayerLineJoin.round
            self.layer.addSublayer(lineLayer)
        }
    }
    
    
    // MARK: - Private Members
    
    private var maxXBounds: Int { return Int(self.bounds.maxX) }
    private var minXBounds: Int { return Int(self.bounds.minX) }
    
    private func pathForLine(withExpression lineExpression: String) -> CGPath {
        let linePath = UIBezierPath()
        
        let startXVarValue = varValueFrom(xPosition: minXBounds)
        let startYPos = yPositionFrom(expressionValue: evaluateExpression(lineExpression, forVarValue: startXVarValue))
        let startPoint = CGPoint(x: 0.0, y: startYPos)
        
        linePath.move(to: startPoint)
        
        guard maxXBounds != minXBounds else { return linePath.cgPath }
        
        for xPos in (minXBounds + 1)...maxXBounds {
            let xVarValue = varValueFrom(xPosition: xPos)
            let yPos = yPositionFrom(expressionValue: evaluateExpression(lineExpression, forVarValue: xVarValue))
            let nextPoint = CGPoint(x: CGFloat(xPos), y: yPos)
            
            linePath.addLine(to: nextPoint)
            linePath.move(to: nextPoint)
        }
        
        return linePath.cgPath
    }
    
    private func varValueFrom(xPosition xPos: Int) -> Double {
        guard maxXBounds != 0 else { return 0.0 }
        
        let xProportion: Double = Double(xPos) / Double(maxXBounds)
        let xDifference = xMax - xMin
        return xMin + (xProportion * xDifference)
    }
    
    private func evaluateExpression(_ expression: String, forVarValue varValue: Double) -> Double {
        guard expression.count > 0 else { return 0.0 }
        
        let decodedExpression = expression.replacingOccurrences(of: ExpressionEncoding.variable, with: String(varValue))
        let expression = NSExpression(format: decodedExpression)
        
        if let expressionValue = expression.expressionValue(with: nil, context: nil) as? Double {
            return expressionValue
        }
        
        return 0.0
    }
    
    private func yPositionFrom(expressionValue yVal: Double) -> CGFloat {
        let yDifference = yMax - yMin
        
        guard yDifference != 0 else { return 0.0 }
        
        let yProportion: CGFloat = CGFloat(yVal) / CGFloat(yDifference)
        let yBoundsDifference = self.bounds.height
        return self.bounds.maxY - (yProportion * yBoundsDifference)
    }
    
}
