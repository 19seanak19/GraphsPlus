//
//  EditBarGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class EditBarGraphViewController: NewBarGraphViewController {
    
    // MARK: - Public Members
    
    public func setUpUsingSavedData(_ savedBarGraph: KeyAndBarGraphData) {
        initialKey = savedBarGraph.key
        
        graphNameTextField.text = savedBarGraph.data.graphTitle
        xAxisTextField.text = savedBarGraph.data.xAxisTitle
        yAxisTextField.text = savedBarGraph.data.yAxisTitle
        
        barNamesToggle.isToggled = savedBarGraph.data.showNames
        
        minYAxisTextField.text = "\(savedBarGraph.data.minY)"
        maxYAxisTextField.text = "\(savedBarGraph.data.maxY)"
        
        barData = savedBarGraph.data.barData
        
        graphStyleLabel.labelText = savedBarGraph.data.graphStyle
        graphStyleName = savedBarGraph.data.graphStyle
    }
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(to: "Edit Bar Graph")
        
        createGraphButton.setTitle("   \u{2713} Save   ", for: .normal)
    }
    
    
    // MARK: - Private Members
    
    private var initialKey: String?
    
    
    // MARK: - @objc Functions
    
    @objc override internal func createGraph() {
        cancelButton.setTitle("   \u{2039} Back   ", for: .normal)
        
        setCurrentGraphDataToInput()
        
        if let initialKey = initialKey {
            GraphModel.shared.updateBarGraph(withKey: initialKey)
        } else {
            GraphModel.shared.addCurrentBarGraph()
        }
        
        presentGraphDisplayVC()
    }
    
}
