//
//  GraphView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class GraphView: ComplexView {
    
    // MARK: - Initializers
    
    override public init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Members
    
    public func drawGraph() {
        graph.create()
    }
    
    public func configureWithCurrentGraphData() {
        // Implemented by subclasses
    }
    
    
    // MARK: - Internal Members
    
    internal func configureWithGraphStyle(_ graphStyle: GraphStyle) {
        self.backgroundColor = graphStyle.primaryBGColor.uiColor
        graphSpacer.backgroundColor = graphStyle.secondaryBGColor.uiColor
        yAxis.backgroundColor = graphStyle.primaryAxisColor.uiColor
        xAxis.backgroundColor = graphStyle.primaryAxisColor.uiColor
        
        let secondaryAxisColor = graphStyle.secondaryAxisColor
        
        if graphStyle.drawSecondaryYAxis {
            yLeftSecondaryAxis.isHidden = false
            yMiddleSecondaryAxis.isHidden = false
            yRightSecondaryAxis.isHidden = false
            
            yLeftSecondaryAxis.backgroundColor = secondaryAxisColor.uiColor
            yMiddleSecondaryAxis.backgroundColor = secondaryAxisColor.uiColor
            yRightSecondaryAxis.backgroundColor = secondaryAxisColor.uiColor
        } else {
            yLeftSecondaryAxis.isHidden = true
            yMiddleSecondaryAxis.isHidden = true
            yRightSecondaryAxis.isHidden = true
        }
        
        if graphStyle.drawSecondaryXAxis {
            xUpperSecondaryAxis.isHidden = false
            xMiddleSecondaryAxis.isHidden = false
            xLowerSecondaryAxis.isHidden = false
            
            xUpperSecondaryAxis.backgroundColor = secondaryAxisColor.uiColor
            xMiddleSecondaryAxis.backgroundColor = secondaryAxisColor.uiColor
            xLowerSecondaryAxis.backgroundColor = secondaryAxisColor.uiColor
        } else {
            xUpperSecondaryAxis.isHidden = true
            xMiddleSecondaryAxis.isHidden = true
            xLowerSecondaryAxis.isHidden = true
        }
    }
    
    internal func configureTitles(graph: String?, xAxis: String?, yAxis: String?) {
        graphTitle.text = graph
        yAxisTitle.text = yAxis
        xAxisTitle.text = xAxis
    }
    
    internal func configureAxisMinMax(xMin: String?, xMax: String?, yMin: String?, yMax: String?) {
        yMaxLabel.text = yMax
        yMinLabel.text = yMin
        xMaxLabel.text = xMax
        xMinLabel.text = xMin
    }
    
    
    // MARK: - Private Members
    
    
    // MARK: - Subviews and Constraints
    
    private let graphTitle = DesignDefaults.makeLabel(withText: "Graph")
    
    internal let yAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let yAxisTitle = DesignDefaults.makeLabel(withText: "Y")
    
    internal let xAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    internal var xAxisBottomConstraint: NSLayoutConstraint?
    internal let xAxisTitle = DesignDefaults.makeLabel(withText: "X")
    
    private let yMaxLabel = DesignDefaults.makeLabel(withText: "y1")
    private let yMinLabel = DesignDefaults.makeLabel(withText: "y0")
    
    internal let xMaxLabel = DesignDefaults.makeLabel(withText: "x1")
    private let xMinLabel = DesignDefaults.makeLabel(withText: "x0")
    
    private let graphSpacer = SpacerView()
    private let graphUpperLeftSpacer = SpacerView()
    private let graphLowerRightSpacer = SpacerView()
    
    private let yLeftSecondaryAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let yMiddleSecondaryAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let yRightSecondaryAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    
    private let xUpperSecondaryAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let xMiddleSecondaryAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let xLowerSecondaryAxis: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    
    internal var graph = Graph() {
        willSet {
            if graph.superview != nil {
                graph.removeFromSuperview()
            }
        }
        didSet {
            addAndConstrainGraph()
        }
    }
    
    private func addAndConstrainGraph() {
        if graph.superview != nil { graph.removeFromSuperview() }
        
        self.addSubview(graph)
        
        graph.topAnchor.constraint(equalTo: graphSpacer.topAnchor).isActive = true
        graph.leftAnchor.constraint(equalTo: graphSpacer.leftAnchor).isActive = true
        graph.bottomAnchor.constraint(equalTo: graphSpacer.bottomAnchor).isActive = true
        graph.rightAnchor.constraint(equalTo: graphSpacer.rightAnchor).isActive = true
    }
    
    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(graphSpacer)
        self.addSubview(graphTitle)
        self.addSubview(yAxis)
        self.addSubview(yAxisTitle)
        self.addSubview(xAxis)
        self.addSubview(xAxisTitle)
        self.addSubview(yMaxLabel)
        self.addSubview(yMinLabel)
        self.addSubview(xMaxLabel)
        self.addSubview(xMinLabel)
        self.addSubview(graphUpperLeftSpacer)
        self.addSubview(graphLowerRightSpacer)
        self.addSubview(yLeftSecondaryAxis)
        self.addSubview(yMiddleSecondaryAxis)
        self.addSubview(yRightSecondaryAxis)
        self.addSubview(xUpperSecondaryAxis)
        self.addSubview(xMiddleSecondaryAxis)
        self.addSubview(xLowerSecondaryAxis)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        graphTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        graphTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        yAxisTitle.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        yAxisTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        yAxisTitle.centerYAnchor.constraint(equalTo: yAxis.centerYAnchor).isActive = true
        
        yMaxLabel.topAnchor.constraint(equalTo: yAxis.topAnchor).isActive = true
        yMaxLabel.leftAnchor.constraint(equalTo: yAxisTitle.rightAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        
        yMinLabel.bottomAnchor.constraint(equalTo: yAxis.bottomAnchor).isActive = true
        yMinLabel.rightAnchor.constraint(equalTo: yMaxLabel.rightAnchor).isActive = true
        
        yAxis.topAnchor.constraint(equalTo: graphTitle.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        yAxis.bottomAnchor.constraint(equalTo: xAxis.bottomAnchor).isActive = true
        yAxis.leftAnchor.constraint(equalTo: yMaxLabel.rightAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        yAxis.widthAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        xAxisTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        xAxisTitle.centerXAnchor.constraint(equalTo: xAxis.centerXAnchor).isActive = true
        
        xMaxLabel.bottomAnchor.constraint(equalTo: xAxisTitle.topAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        xMaxLabel.rightAnchor.constraint(equalTo: xAxis.rightAnchor).isActive = true
        
        xMinLabel.topAnchor.constraint(equalTo: xMaxLabel.topAnchor).isActive = true
        xMinLabel.leftAnchor.constraint(equalTo: xAxis.leftAnchor).isActive = true
        
        xAxis.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        xAxis.leftAnchor.constraint(equalTo: yAxis.leftAnchor).isActive = true
        xAxisBottomConstraint = xAxis.bottomAnchor.constraint(equalTo: xMaxLabel.topAnchor, constant: -0.5 * DesignDefaults.padding)
        xAxisBottomConstraint?.isActive = true
        xAxis.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        graphSpacer.leftAnchor.constraint(equalTo: yAxis.rightAnchor).isActive = true
        graphSpacer.rightAnchor.constraint(equalTo: xAxis.rightAnchor).isActive = true
        graphSpacer.topAnchor.constraint(equalTo: yAxis.topAnchor).isActive = true
        graphSpacer.bottomAnchor.constraint(equalTo: xAxis.topAnchor).isActive = true
        
        graphUpperLeftSpacer.leftAnchor.constraint(equalTo: graphSpacer.leftAnchor).isActive = true
        graphUpperLeftSpacer.rightAnchor.constraint(equalTo: graphSpacer.centerXAnchor).isActive = true
        graphUpperLeftSpacer.topAnchor.constraint(equalTo: graphSpacer.topAnchor).isActive = true
        graphUpperLeftSpacer.bottomAnchor.constraint(equalTo: graphSpacer.centerYAnchor).isActive = true
        
        graphLowerRightSpacer.leftAnchor.constraint(equalTo: graphSpacer.centerXAnchor).isActive = true
        graphLowerRightSpacer.rightAnchor.constraint(equalTo: graphSpacer.rightAnchor).isActive = true
        graphLowerRightSpacer.topAnchor.constraint(equalTo: graphSpacer.centerYAnchor).isActive = true
        graphLowerRightSpacer.bottomAnchor.constraint(equalTo: graphSpacer.bottomAnchor).isActive = true
        
        yLeftSecondaryAxis.topAnchor.constraint(equalTo: graphSpacer.topAnchor).isActive = true
        yLeftSecondaryAxis.bottomAnchor.constraint(equalTo: graphSpacer.bottomAnchor).isActive = true
        yLeftSecondaryAxis.centerXAnchor.constraint(equalTo: graphUpperLeftSpacer.centerXAnchor).isActive = true
        yLeftSecondaryAxis.widthAnchor.constraint(equalTo: yAxis.widthAnchor).isActive = true
        
        yMiddleSecondaryAxis.topAnchor.constraint(equalTo: graphSpacer.topAnchor).isActive = true
        yMiddleSecondaryAxis.bottomAnchor.constraint(equalTo: graphSpacer.bottomAnchor).isActive = true
        yMiddleSecondaryAxis.centerXAnchor.constraint(equalTo: graphSpacer.centerXAnchor).isActive = true
        yMiddleSecondaryAxis.widthAnchor.constraint(equalTo: yAxis.widthAnchor).isActive = true
        
        yRightSecondaryAxis.topAnchor.constraint(equalTo: graphSpacer.topAnchor).isActive = true
        yRightSecondaryAxis.bottomAnchor.constraint(equalTo: graphSpacer.bottomAnchor).isActive = true
        yRightSecondaryAxis.centerXAnchor.constraint(equalTo: graphLowerRightSpacer.centerXAnchor).isActive = true
        yRightSecondaryAxis.widthAnchor.constraint(equalTo: yAxis.widthAnchor).isActive = true
        
        xUpperSecondaryAxis.leftAnchor.constraint(equalTo: graphSpacer.leftAnchor).isActive = true
        xUpperSecondaryAxis.rightAnchor.constraint(equalTo: graphSpacer.rightAnchor).isActive = true
        xUpperSecondaryAxis.centerYAnchor.constraint(equalTo: graphUpperLeftSpacer.centerYAnchor).isActive = true
        xUpperSecondaryAxis.heightAnchor.constraint(equalTo: xAxis.heightAnchor).isActive = true
        
        xMiddleSecondaryAxis.leftAnchor.constraint(equalTo: graphSpacer.leftAnchor).isActive = true
        xMiddleSecondaryAxis.rightAnchor.constraint(equalTo: graphSpacer.rightAnchor).isActive = true
        xMiddleSecondaryAxis.centerYAnchor.constraint(equalTo: graphSpacer.centerYAnchor).isActive = true
        xMiddleSecondaryAxis.heightAnchor.constraint(equalTo: xAxis.heightAnchor).isActive = true
        
        xLowerSecondaryAxis.leftAnchor.constraint(equalTo: graphSpacer.leftAnchor).isActive = true
        xLowerSecondaryAxis.rightAnchor.constraint(equalTo: graphSpacer.rightAnchor).isActive = true
        xLowerSecondaryAxis.centerYAnchor.constraint(equalTo: graphLowerRightSpacer.centerYAnchor).isActive = true
        xLowerSecondaryAxis.heightAnchor.constraint(equalTo: xAxis.heightAnchor).isActive = true
    }
}
