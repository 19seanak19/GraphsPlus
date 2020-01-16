//
//  LineGraphView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LineGraphView: GraphView {

    // MARK: - Initializers
    
    override public init() {
        super.init()
        
        graph = LineGraph()
        
        configureWithCurrentGraphData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Members
    
    override public func configureWithCurrentGraphData() {
        let graphStyleName = GraphModel.shared.currentLineGraphData.graphStyle
        let graphStyle = GraphModel.shared.getGraphStyle(named: graphStyleName)
        let currentLineGraphData = GraphModel.shared.currentLineGraphData
        
        configureWithGraphStyle(graphStyle)
        
        let graphTitle = graphStyle.showGraphTitle ? currentLineGraphData.graphTitle : nil
        let yAxisTitle = graphStyle.showXAxisTitle ? currentLineGraphData.yAxisTitle : nil
        let xAxisTitle = graphStyle.showYAxisTitle ? currentLineGraphData.xAxisTitle : nil
        
        configureTitles(graph: graphTitle, xAxis: xAxisTitle, yAxis: yAxisTitle)
        
        let yMaxLabel = "\(currentLineGraphData.maxY)"
        let yMinLabel = "\(currentLineGraphData.minY)"
        let xMaxLabel = "\(currentLineGraphData.maxX)"
        let xMinLabel = "\(currentLineGraphData.minX)"
        
        configureAxisMinMax(xMin: xMinLabel, xMax: xMaxLabel, yMin: yMinLabel, yMax: yMaxLabel)
    }
    
    
    // MARK: - Private Members
    
    
    // MARK: - Subviews and Constraints
    
    
}
