//
//  LoadBarGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LoadBarGraphViewController: LoadGraphViewController {
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(to: "Load Bar Graph")
    }
    
    
    // MARK: - Internal Members
    
    override internal func removeDataFromModel(atIndexPath indexPath: IndexPath) {
        GraphModel.shared.removeSavedBarGraph(atIndexPath: indexPath)
    }
    
    
    // MARK: - Private Members
    
    private var selectedBarGraphData: KeyAndBarGraphData? {
        didSet {
            loadButton.isEnabled = (selectedBarGraphData != nil)
        }
    }

    
    // MARK: - @objc Functions
    
    @objc override internal func loadGraph() {
        if let barGraphDataToLoad = selectedBarGraphData {
            let editBarGraphVC = EditBarGraphViewController()
            editBarGraphVC.setUpUsingSavedData(barGraphDataToLoad)
            editBarGraphVC.dismissClosure = {
                self.graphsTableView.reloadData()
                self.loadButton.isEnabled = false
                self.dismissGraphsPlusVC(editBarGraphVC)
            }
            self.presentGraphsPlusVC(editBarGraphVC)
        }
    }
    
    
    // MARK: - UITableViewDataSource Implementation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GraphModel.shared.getSavedBarGraphCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let barGraphCell = graphsTableView.dequeueReusableCell(withIdentifier: cellResuseID, for: indexPath) as? SavedGraphTableViewCell {
            let cellBGColor = ((indexPath.row % 2) == 0) ? DesignDefaults.bgMedGray : DesignDefaults.bgMedGray_High
            
            let savedBarGraphData = GraphModel.shared.getSavedBarGraph(atIndexPath: indexPath)
            
            barGraphCell.setMiddleLabelText(to: savedBarGraphData.key)
            barGraphCell.setInitialBackgroundColor(to: cellBGColor)
            
            return barGraphCell
        }
        
        return UITableViewCell(frame: CGRect.zero)
    }
    
    
    // MARK: - UITableViewDelegate Implementation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBarGraphData = GraphModel.shared.getSavedBarGraph(atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedBarGraphData = nil
    }
    
    
}
