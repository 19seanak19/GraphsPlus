//
//  LoadLineGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LoadLineGraphViewController: LoadGraphViewController {

    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(to: "Load Line Graph")
    }
    
    
    // MARK: - Internal Members
    
    override internal func removeDataFromModel(atIndexPath indexPath: IndexPath) {
        GraphModel.shared.removeSavedLineGraph(atIndexPath: indexPath)
    }
    
    
    // MARK: - Private Members
    
    private var selectedLineGraphData: KeyAndLineGraphData? {
        didSet {
            loadButton.isEnabled = (selectedLineGraphData != nil)
        }
    }
    
    
    // MARK: - @objc Functions
    
    @objc override internal func loadGraph() {
        if let lineGraphDataToLoad = selectedLineGraphData {
            let editLineGraphVC = EditLineGraphViewController()
            editLineGraphVC.setUpUsingSavedData(lineGraphDataToLoad)
            editLineGraphVC.dismissClosure = {
                self.graphsTableView.reloadData()
                self.loadButton.isEnabled = false
                self.dismissGraphsPlusVC(editLineGraphVC)
            }
            self.presentGraphsPlusVC(editLineGraphVC)
        }
    }
    
    
    // MARK: - UITableViewDataSource Implementation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GraphModel.shared.getSavedLineGraphCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let lineGraphCell = graphsTableView.dequeueReusableCell(withIdentifier: cellResuseID, for: indexPath) as? SavedGraphTableViewCell {
            let cellBGColor = ((indexPath.row % 2) == 0) ? DesignDefaults.bgMedGray : DesignDefaults.bgMedGray_High
            
            let savedLineGraphData = GraphModel.shared.getSavedLineGraph(atIndexPath: indexPath)
            
            lineGraphCell.setMiddleLabelText(to: savedLineGraphData.key)
            lineGraphCell.setInitialBackgroundColor(to: cellBGColor)
            
            return lineGraphCell
        }
        
        return UITableViewCell(frame: CGRect.zero)
    }
    
    
    // MARK: - UITableViewDelegate Implementation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLineGraphData = GraphModel.shared.getSavedLineGraph(atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedLineGraphData = nil
    }
    
}
