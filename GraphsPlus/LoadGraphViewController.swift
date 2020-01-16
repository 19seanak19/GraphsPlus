//
//  LoadGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LoadGraphViewController: GraphsPlusViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphsTableView.dataSource = self
        graphsTableView.delegate = self
        graphsTableView.separatorStyle = .none
        graphsTableView.bounces = false
        graphsTableView.allowsSelection = true
        
        graphsTableView.register(SavedGraphTableViewCell.self, forCellReuseIdentifier: cellResuseID)
        
        cancelButton.addTarget(self, action: #selector(dismissByClosure), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadGraph), for: .touchUpInside)
        
        loadButton.isEnabled = false
    }
    
    private var tableRowHeightNotSet = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableRowHeightNotSet {
            graphsTableView.rowHeight = mainContainer.bounds.height * DesignDefaults.buttonHeightMultiplier
            graphsTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graphsTableView.reloadData()
    }
    
    
    // MARK: - Internal Members
    
    internal let cellResuseID = "GraphsTableCell"
    
    internal func removeDataFromModel(atIndexPath indexPath: IndexPath) {
        // Implemented by subclasses
    }
    
    
    // MARK: - UITableViewDataSource Implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Implemented by subclasses
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Implemented by subclasses
        return UITableViewCell(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (deleteAction, indexPath) in
            let deleteAlert = UIAlertController(title: "Are You Sure?", message: "This graph will be deleted forever!", preferredStyle: .alert)
            
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            deleteAlert.addAction(cancelAlertAction)
            
            let deleteAlertAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (deleteAlertAction) in
                self.removeDataFromModel(atIndexPath: indexPath)
                
                CATransaction.begin()
                self.graphsTableView.beginUpdates()
                CATransaction.setCompletionBlock({
                    UIView.animate(withDuration: DesignDefaults.colorShiftInterval, animations: {
                        for (index, visibleCell) in self.graphsTableView.visibleCells.enumerated() {
                            let cellBGColor = ((index % 2) == 0) ? DesignDefaults.bgMedGray : DesignDefaults.bgMedGray_High
                            visibleCell.backgroundColor = cellBGColor
                        }
                    })
                    self.loadButton.isEnabled = false
                })
                self.graphsTableView.deleteRows(at: [indexPath], with: .automatic)
                self.graphsTableView.endUpdates()
                CATransaction.commit()
            })
            deleteAlert.addAction(deleteAlertAction)
            
            self.present(deleteAlert, animated: true, completion: nil)
            
        }
        deleteAction.backgroundColor = DesignDefaults.deleteRed
        
        return [deleteAction]
    }
    
    
    // MARK: - UITableViewDelegate Implementation
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPath = graphsTableView.indexPathForSelectedRow {
            if selectedIndexPath == indexPath {
                graphsTableView.deselectRow(at: indexPath, animated: true)
                loadButton.isEnabled = false
                return nil
            }
        }
        return indexPath
    }
    
    
    // MARK: - @objc Functions
    
    @objc internal func loadGraph() {
        // Implemented by subclasses
    }
    
    
    // MARK: - UI Elements and Constraints
    
    internal let savedGraphsLabel: UILabel = DesignDefaults.makeLabel(withText: "Saved Graphs:")
    internal let graphsTableView: UITableView = DesignDefaults.makeTable(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: DesignDefaults.bgDarkGray)
    
    private let cancelButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2715} Cancel")
    internal let loadButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2713} Load")
    
    override internal func addUI() {
        super.addUI()
        
        view.addSubview(savedGraphsLabel)
        view.addSubview(graphsTableView)
        view.addSubview(cancelButton)
        view.addSubview(loadButton)
    }
    
    
    override internal func constrainUI() {
        super.constrainUI()
        
        savedGraphsLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: DesignDefaults.padding).isActive = true
        savedGraphsLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        
        graphsTableView.topAnchor.constraint(equalTo: savedGraphsLabel.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        graphsTableView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -DesignDefaults.padding).isActive = true
        graphsTableView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        graphsTableView.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: mainContainerLeft.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        loadButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        loadButton.centerXAnchor.constraint(equalTo: mainContainerRight.centerXAnchor).isActive = true
        loadButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
    }
    
}
