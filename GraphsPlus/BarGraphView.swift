//
//  BarGraphView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/13/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class BarGraphView: GraphView {

    // MARK: - Initializers
    
    override public init() {
        super.init()
        
        graph = BarGraph()
        
        configureWithCurrentGraphData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Members
    
    override public func drawGraph() {
        super.drawGraph()
        if let barGraph = graph as? BarGraph {
            UIView.animate(withDuration: 0.05, animations: {
                barGraph.setNeedsLayout()
            }, completion: {_ in
                barGraph.setBarCornerRadius()
            })
            if GraphModel.shared.currentBarGraphData.showNames {
                let barViews = barGraph.barViews
                let barData = GraphModel.shared.currentBarGraphData.barData
                
                for (index, bar) in barData.enumerated() {
                    if barViews.indices.contains(index) {
                        let thisBarView = barViews[index]
                        
                        let thisNameLabel = DesignDefaults.makeLabel(withText: bar.name)
                        thisNameLabel.textColor = DesignDefaults.secondaryText
                        
                        self.addSubview(thisNameLabel)
                        thisNameLabel.centerXAnchor.constraint(equalTo: thisBarView.centerXAnchor).isActive = true
                        thisNameLabel.bottomAnchor.constraint(equalTo: xAxisTitle.topAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
                        if index == 0 {
                            xAxisBottomConstraint?.isActive = false
                            xAxisBottomConstraint = xAxis.bottomAnchor.constraint(equalTo: thisNameLabel.topAnchor, constant: -0.5 * DesignDefaults.padding)
                            xAxisBottomConstraint?.isActive = true
                        }
                    }
                }
            }
        }
    }
    
    override public func configureWithCurrentGraphData() {
        let graphStyleName = GraphModel.shared.currentBarGraphData.graphStyle
        let graphStyle = GraphModel.shared.getGraphStyle(named: graphStyleName)
        let currentBarGraphData = GraphModel.shared.currentBarGraphData
        
        configureWithGraphStyle(graphStyle)
        
        let graphTitle = graphStyle.showGraphTitle ? currentBarGraphData.graphTitle : nil
        let yAxisTitle = graphStyle.showXAxisTitle ? currentBarGraphData.yAxisTitle : nil
        let xAxisTitle = graphStyle.showYAxisTitle ? currentBarGraphData.xAxisTitle : nil
        
        configureTitles(graph: graphTitle, xAxis: xAxisTitle, yAxis: yAxisTitle)
        
        let yMaxLabel = "\(currentBarGraphData.maxY)"
        let yMinLabel = "\(currentBarGraphData.minY)"
        
        configureAxisMinMax(xMin: nil, xMax: nil, yMin: yMinLabel, yMax: yMaxLabel)
    }
    
    // MARK: - Private Members
    
    
    // MARK: - Subviews and Constraints
    
    
}
