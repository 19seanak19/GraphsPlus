//
//  EditLineGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class EditLineGraphViewController: NewLineGraphViewController {

    // MARK: - Public Members
    
    public func setUpUsingSavedData(_ savedLineGraph: KeyAndLineGraphData) {
        initialKey = savedLineGraph.key
        
        graphNameTextField.text = savedLineGraph.data.graphTitle
        xAxisTextField.text = savedLineGraph.data.xAxisTitle
        yAxisTextField.text = savedLineGraph.data.yAxisTitle
        
        minXAxisTextField.text = "\(savedLineGraph.data.minX)"
        maxXAxisTextField.text = "\(savedLineGraph.data.maxX)"
        minYAxisTextField.text = "\(savedLineGraph.data.minY)"
        maxYAxisTextField.text = "\(savedLineGraph.data.maxY)"
        
        lineData = savedLineGraph.data.lineData
        graphStyleLabel.labelText = savedLineGraph.data.graphStyle
        graphStyleName = savedLineGraph.data.graphStyle
    }
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(to: "Edit Line Graph")
        
        createGraphButton.setTitle("   \u{2713} Save   ", for: .normal)
    }

    
    // MARK: - Private Members
    
    private var initialKey: String?
    
    
    // MARK: - @objc Functions
    
    @objc override internal func createGraph() {
        cancelButton.setTitle("   \u{2039} Back   ", for: .normal)
        
        setCurrentGraphDataToInput()
        
        if let initialKey = initialKey {
            GraphModel.shared.updateLineGraph(withKey: initialKey)
        } else {
            GraphModel.shared.addCurrentLineGraph()
        }
        
        presentGraphDisplayVC()
    }
}
