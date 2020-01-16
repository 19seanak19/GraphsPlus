//
//  BarGraph.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/13/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class BarGraph: Graph {

    // MARK: - Initializers
    
    override public init() {
        super.init()
        
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Members
    
    public var barViews: [UIView] = []
    
    public var yMax: Double = GraphModel.shared.currentBarGraphData.maxY
    public var yMin: Double = GraphModel.shared.currentBarGraphData.minY
    
    public var xMax: Double = GraphModel.shared.currentBarGraphData.maxX
    public var xMin: Double = GraphModel.shared.currentBarGraphData.minX
    
    override public func create() {
        let barCount = barData.count
        let barSpacerWidthMultiplier: CGFloat = 1.0 / CGFloat(barCount)
        
        for (index, bar) in barData.enumerated() {
            let thisBarSpacer = SpacerView()
            self.addSubview(thisBarSpacer)
            
            thisBarSpacer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            thisBarSpacer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            thisBarSpacer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: barSpacerWidthMultiplier).isActive = true
            
            if index == 0 {
                thisBarSpacer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            } else {
                thisBarSpacer.leftAnchor.constraint(equalTo: barSpacers[index - 1].rightAnchor).isActive = true
            }
            
            barSpacers.append(thisBarSpacer)
            
            let barStyle = GraphModel.shared.getBarStyle(named: bar.barStyle)
            let barColor = barStyle.barColor
            let thisBarWidthMultiplier = barStyle.barWidth
            
            let thisBarView = DesignDefaults.makeView(withBGColor: barColor.uiColor, andBorderColor: nil)
            self.addSubview(thisBarView)
            
            let thisBarHeightMultiplier: CGFloat = 2.0 * CGFloat((bar.value - yMin) / (yMax - yMin))
            
            thisBarView.centerXAnchor.constraint(equalTo: thisBarSpacer.centerXAnchor).isActive = true
            thisBarView.widthAnchor.constraint(equalTo: thisBarSpacer.widthAnchor, multiplier: thisBarWidthMultiplier).isActive = true
            thisBarView.centerYAnchor.constraint(equalTo: thisBarSpacer.bottomAnchor).isActive = true
            thisBarView.heightAnchor.constraint(equalTo: thisBarSpacer.heightAnchor, multiplier: thisBarHeightMultiplier).isActive = true
            
            barViews.append(thisBarView)
        }
    }
    
    public func setBarCornerRadius() {
        for (index, bar) in barData.enumerated() {
            let barStyle = GraphModel.shared.getBarStyle(named: bar.barStyle)
            let barRoundnessMultiplier = barStyle.barRoundness
            
            let thisBarView = barViews[index]
            let barRoundness = thisBarView.bounds.width * barRoundnessMultiplier
            thisBarView.layer.cornerRadius = barRoundness
        }
    }
    
    
    // MARK: - Private Members
    
    private var barSpacers: [SpacerView] = []
    
    private var barData: [BarData] {
        get {
            return GraphModel.shared.currentBarGraphData.barData
        }
    }

}
