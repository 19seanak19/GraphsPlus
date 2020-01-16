//
//  NewGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/2/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class GraphData: Codable {
    var graphTitle: String?
    var xAxisTitle: String?
    var yAxisTitle: String?
    var minX: Double = 0.0
    var maxX: Double = 10.0
    var minY: Double = 0.0
    var maxY: Double = 10.0
    var graphStyle: String = "Default"
}

class NewGraphViewController: GraphsPlusViewController, UITableViewDataSource, UITableViewDelegate, AddDataViewDelegate {

    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFields()
        
        addDataButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
        editDataButton.addTarget(self, action: #selector(toggleDataTableEdit), for: .touchUpInside)
        
        graphStyleLabel.labelTextColor = DesignDefaults.secondaryText
        graphStyleButton.addTarget(self, action: #selector(editGraphStyle), for: .touchUpInside)
        
        cancelButton.addTarget(self, action: #selector(dismissByClosure), for: .touchUpInside)
        createGraphButton.addTarget(self, action: #selector(createGraph), for: .touchUpInside)
        
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.separatorStyle = .none
        dataTableView.bounces = false
        dataTableView.allowsSelection = false
        
        dataTableView.register(GraphDataTableViewCell.self, forCellReuseIdentifier: cellResuseID)
        
        self.view.bringSubviewToFront(addDataViewShade)
        addDataViewShade.alpha = 0.6
        addDataViewShade.isHidden = true
        
        let dismissDataKeyboardTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        addDataViewShade.addGestureRecognizer(dismissDataKeyboardTapRecognizer)
        
        let dismissDataKeyboardSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        dismissDataKeyboardSwipeRecognizer.direction = .down
        addDataViewShade.addGestureRecognizer(dismissDataKeyboardSwipeRecognizer)
    }
    
    private var tableRowHeightNotSet = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableRowHeightNotSet {
            dataTableView.rowHeight = mainContainer.bounds.height * DesignDefaults.buttonHeightMultiplier
            dataTableView.reloadData()
        }
    }
    
    
    // MARK: - Internal Members
    
    override internal func bringTextFieldsToFront() {
        self.view.bringSubviewToFront(keyboardShade)
        self.view.bringSubviewToFront(graphNameTextField)
        self.view.bringSubviewToFront(xAxisTextField)
        self.view.bringSubviewToFront(yAxisTextField)
        self.view.bringSubviewToFront(xLimitSpacer)
        self.view.bringSubviewToFront(yLimitSpacer)
    }
    
    
    // MARK: - Private Members
    
    private func setUpTextFields() {
        graphNameTextField.attributedPlaceholder = NSAttributedString(string: "Graph Title", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        graphNameTextField.delegate = self
        
        xAxisTextField.attributedPlaceholder = NSAttributedString(string: "X-Axis Title", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        xAxisTextField.delegate = self
        
        yAxisTextField.attributedPlaceholder = NSAttributedString(string: "Y-Axis Title", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        yAxisTextField.delegate = self
        
        xLimitSpacer.isUserInteractionEnabled = true
        xLimitSpacer.clipsToBounds = true
        
        yLimitSpacer.isUserInteractionEnabled = true
        yLimitSpacer.clipsToBounds = true
        
        minXAxisTextField.layer.cornerRadius = 0.0
        minXAxisTextField.keyboardType = .decimalPad
        minXAxisTextField.attributedPlaceholder = NSAttributedString(string: "Min. X", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        minXAxisTextField.delegate = self
        
        maxXAxisTextField.layer.cornerRadius = 0.0
        maxXAxisTextField.keyboardType = .decimalPad
        maxXAxisTextField.attributedPlaceholder = NSAttributedString(string: "Max. X", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        maxXAxisTextField.delegate = self
        
        minYAxisTextField.layer.cornerRadius = 0.0
        minYAxisTextField.keyboardType = .decimalPad
        minYAxisTextField.attributedPlaceholder = NSAttributedString(string: "Min. Y", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        minYAxisTextField.delegate = self
        
        maxYAxisTextField.layer.cornerRadius = 0.0
        maxYAxisTextField.keyboardType = .decimalPad
        maxYAxisTextField.attributedPlaceholder = NSAttributedString(string: "Max. Y", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        maxYAxisTextField.delegate = self
    }
    
    
    // MARK: - Internal Members
    
    internal let cellResuseID = "DataTableCell"
    internal var graphStyleName = DesignDefaults.defaultGraphStyleName {
        didSet {
            self.graphStyleLabel.labelText = graphStyleName
        }
    }
    
    internal func presentGraphDisplayVC() {
        // Implemented by subclasses
    }
    
    internal func removeData(atIndexPath indexPath: IndexPath) {
        // Implemented by subclasses
    }
    
    internal func moveData(from sourcePath: IndexPath, to destinationPath: IndexPath) {
        // Implemented by subclasses
    }
    
    // MARK: - @objc Functions
    
    @objc override internal func hideKeyboard() {
        super.hideKeyboard()
        
        if graphNameTextField.isFirstResponder {
            graphNameTextField.resignFirstResponder()
        }
        else if xAxisTextField.isFirstResponder {
            xAxisTextField.resignFirstResponder()
        }
        else if yAxisTextField.isFirstResponder {
            yAxisTextField.resignFirstResponder()
        }
        else if minXAxisTextField.isFirstResponder {
            minXAxisTextField.resignFirstResponder()
        }
        else if maxXAxisTextField.isFirstResponder {
            maxXAxisTextField.resignFirstResponder()
        }
        else if minYAxisTextField.isFirstResponder {
            minYAxisTextField.resignFirstResponder()
        }
        else if maxYAxisTextField.isFirstResponder {
            maxYAxisTextField.resignFirstResponder()
        }
    }
    
    @objc internal func addData() {
        // Implemented by subclasses
    }
    
    @objc internal func createGraph() {
        cancelButton.setTitle("   \u{2039} Back   ", for: .normal)
    }
    
    @objc internal func editGraphStyle() {
        let graphStyleEditorVC = GraphStyleEditorViewController()
        graphStyleEditorVC.graphStyle = GraphModel.shared.getGraphStyle(named: graphStyleName)
        graphStyleEditorVC.dismissClosure = {
            if graphStyleEditorVC.didSave {
                self.graphStyleName = graphStyleEditorVC.graphStyle.name
            }
            self.dismissGraphsPlusVC(graphStyleEditorVC)
        }
        self.presentGraphsPlusVC(graphStyleEditorVC)
    }
    
    @objc internal func toggleDataTableEdit() {
        if dataTableView.isEditing {
            dataTableView.isEditing = false
            editDataButton.setTitle("   Edit   ", for: .normal)
        } else {
            dataTableView.isEditing = true
            editDataButton.setTitle("   Done   ", for: .normal)
        }
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (deleteAction, indexPath) in
            let deleteAlert = UIAlertController(title: "Are You Sure?", message: "This will be deleted forever!", preferredStyle: .alert)
            
            let deleteAlertAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (deleteAlertAction) in
                self.removeData(atIndexPath: indexPath)
                
                CATransaction.begin()
                self.dataTableView.beginUpdates()
                CATransaction.setCompletionBlock({
                    UIView.animate(withDuration: DesignDefaults.colorShiftInterval, animations: {
                        for (index, visibleCell) in self.dataTableView.visibleCells.enumerated() {
                            let cellBGColor = ((index % 2) == 0) ? DesignDefaults.bgMedGray : DesignDefaults.bgMedGray_High
                            visibleCell.backgroundColor = cellBGColor
                        }
                    })
                })
                self.dataTableView.deleteRows(at: [indexPath], with: .automatic)
                self.dataTableView.endUpdates()
                CATransaction.commit()
            })
            deleteAlert.addAction(deleteAlertAction)
            
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            deleteAlert.addAction(cancelAlertAction)
            
            self.present(deleteAlert, animated: true, completion: nil)
            
        }
        deleteAction.backgroundColor = DesignDefaults.deleteRed
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveData(from: sourceIndexPath, to: destinationIndexPath)
        dataTableView.reloadData()
    }
    
    
    // MARK: - UITableViewDelegate Implementation
    
    
    // MARK: - AddDataViewDelegate Implementation
    
    func addDataSetStylePressed() {
        // Implemented by subclasses
    }
    
    func addDataCancelPressed() {
        // Implemented by subclasses
    }
    
    func addDataAddPressed() {
        // Implemented by subclasses
    }
    
    func addDataSetEquationPressed() {
        // Implemented by subclasses
    }
    
    func addDataHideKeyboard() {
        self.hideKeyboard()
    }
    
    // MARK: - UI Elements and Constraints
    
    internal let addDataViewShade: UIView = DesignDefaults.makeView(withBGColor: .black, andBorderColor: nil)
    
    internal let graphNameTextField: UITextField = DesignDefaults.makeTextField()
    
    internal let topDivider: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    internal let dataTableTitleLabel: UILabel = DesignDefaults.makeLabel(withText: "Data:")
    internal let addDataButton: UIButton = DesignDefaults.makeButton(withTitle: "Add Data")
    internal let editDataButton: UIButton = DesignDefaults.makeButton(withTitle: "Edit")
    
    internal let dataTableView: UITableView = DesignDefaults.makeTable(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: DesignDefaults.bgDarkGray)
    
    internal let xAxisTextField: UITextField = DesignDefaults.makeTextField()
    internal let yAxisTextField: UITextField = DesignDefaults.makeTextField()
    
    internal let xLimitSpacer: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: DesignDefaults.bgDarkGray)
    internal let minXAxisTextField: UITextField = DesignDefaults.makeTextField()
    internal let maxXAxisTextField: UITextField = DesignDefaults.makeTextField()
    
    private let yLimitSpacer: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: DesignDefaults.bgDarkGray)
    internal let minYAxisTextField: UITextField = DesignDefaults.makeTextField()
    internal let maxYAxisTextField: UITextField = DesignDefaults.makeTextField()
    
    internal let graphStyleLabel = LabelContainerView(labelText: "Default")
    private let graphStyleButton: UIButton = DesignDefaults.makeButton(withTitle: "Graph Style")
    
    internal let bottomDivider: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    internal let cancelButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2715} Cancel")
    internal let createGraphButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2713} Create")
    
    override internal func addUI() {
        super.addUI()
        
        view.addSubview(addDataViewShade)
        view.addSubview(graphNameTextField)
        mainContainer.addSubview(topDivider)
        view.addSubview(xAxisTextField)
        view.addSubview(yAxisTextField)
        view.addSubview(xLimitSpacer)
        xLimitSpacer.addSubview(minXAxisTextField)
        xLimitSpacer.addSubview(maxXAxisTextField)
        view.addSubview(yLimitSpacer)
        yLimitSpacer.addSubview(minYAxisTextField)
        yLimitSpacer.addSubview(maxYAxisTextField)
        mainContainer.addSubview(dataTableTitleLabel)
        mainContainer.addSubview(addDataButton)
        mainContainer.addSubview(editDataButton)
        mainContainer.addSubview(dataTableView)
        mainContainer.addSubview(graphStyleLabel)
        mainContainer.addSubview(graphStyleButton)
        mainContainer.addSubview(bottomDivider)
        mainContainer.addSubview(cancelButton)
        mainContainer.addSubview(createGraphButton)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        addDataViewShade.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        addDataViewShade.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        addDataViewShade.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        addDataViewShade.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        graphNameTextField.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: DesignDefaults.padding).isActive = true
        graphNameTextField.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        graphNameTextField.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        graphNameTextField.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        topDivider.topAnchor.constraint(equalTo: graphNameTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        topDivider.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        topDivider.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -2.0 * DesignDefaults.padding).isActive = true
        topDivider.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        xAxisTextField.topAnchor.constraint(equalTo: topDivider.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        xAxisTextField.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        xAxisTextField.rightAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        xAxisTextField.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        yAxisTextField.topAnchor.constraint(equalTo: xAxisTextField.topAnchor).isActive = true
        yAxisTextField.leftAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        yAxisTextField.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        yAxisTextField.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        xLimitSpacer.topAnchor.constraint(equalTo: xAxisTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        xLimitSpacer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        xLimitSpacer.rightAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        xLimitSpacer.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        minXAxisTextField.topAnchor.constraint(equalTo: xLimitSpacer.topAnchor).isActive = true
        minXAxisTextField.bottomAnchor.constraint(equalTo: xLimitSpacer.bottomAnchor).isActive = true
        minXAxisTextField.leftAnchor.constraint(equalTo: xLimitSpacer.leftAnchor).isActive = true
        minXAxisTextField.rightAnchor.constraint(equalTo: xLimitSpacer.centerXAnchor).isActive = true
        
        maxXAxisTextField.topAnchor.constraint(equalTo: xLimitSpacer.topAnchor).isActive = true
        maxXAxisTextField.bottomAnchor.constraint(equalTo: xLimitSpacer.bottomAnchor).isActive = true
        maxXAxisTextField.leftAnchor.constraint(equalTo: xLimitSpacer.centerXAnchor).isActive = true
        maxXAxisTextField.rightAnchor.constraint(equalTo: xLimitSpacer.rightAnchor).isActive = true
        
        yLimitSpacer.topAnchor.constraint(equalTo: xAxisTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        yLimitSpacer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        yLimitSpacer.leftAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        yLimitSpacer.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        minYAxisTextField.topAnchor.constraint(equalTo: yLimitSpacer.topAnchor).isActive = true
        minYAxisTextField.bottomAnchor.constraint(equalTo: yLimitSpacer.bottomAnchor).isActive = true
        minYAxisTextField.leftAnchor.constraint(equalTo: yLimitSpacer.leftAnchor).isActive = true
        minYAxisTextField.rightAnchor.constraint(equalTo: yLimitSpacer.centerXAnchor).isActive = true
        
        maxYAxisTextField.topAnchor.constraint(equalTo: yLimitSpacer.topAnchor).isActive = true
        maxYAxisTextField.bottomAnchor.constraint(equalTo: yLimitSpacer.bottomAnchor).isActive = true
        maxYAxisTextField.leftAnchor.constraint(equalTo: yLimitSpacer.centerXAnchor).isActive = true
        maxYAxisTextField.rightAnchor.constraint(equalTo: yLimitSpacer.rightAnchor).isActive = true
        
        dataTableTitleLabel.topAnchor.constraint(equalTo: xLimitSpacer.bottomAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        dataTableTitleLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        dataTableTitleLabel.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        addDataButton.bottomAnchor.constraint(equalTo: dataTableView.topAnchor, constant: DesignDefaults.cornerRadius).isActive = true
        addDataButton.rightAnchor.constraint(equalTo: dataTableView.rightAnchor).isActive = true
        addDataButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: 0.75 * DesignDefaults.buttonHeightMultiplier).isActive = true
        
        editDataButton.topAnchor.constraint(equalTo: addDataButton.topAnchor).isActive = true
        editDataButton.rightAnchor.constraint(equalTo: addDataButton.leftAnchor).isActive = true
        editDataButton.heightAnchor.constraint(equalTo: addDataButton.heightAnchor).isActive = true
        
        dataTableView.topAnchor.constraint(equalTo: dataTableTitleLabel.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        dataTableView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        dataTableView.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        dataTableView.bottomAnchor.constraint(equalTo: graphStyleButton.topAnchor, constant: -DesignDefaults.padding).isActive = true
        
        graphStyleButton.bottomAnchor.constraint(equalTo: bottomDivider.topAnchor, constant: -DesignDefaults.padding).isActive = true
        graphStyleButton.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        graphStyleButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        graphStyleLabel.bottomAnchor.constraint(equalTo: bottomDivider.topAnchor, constant: -DesignDefaults.padding).isActive = true
        graphStyleLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        graphStyleLabel.rightAnchor.constraint(equalTo: graphStyleButton.leftAnchor, constant: -DesignDefaults.padding).isActive = true
        graphStyleLabel.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        bottomDivider.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        bottomDivider.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -2.0 * DesignDefaults.padding).isActive = true
        bottomDivider.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -DesignDefaults.padding).isActive = true
        bottomDivider.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: mainContainerLeft.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        createGraphButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        createGraphButton.centerXAnchor.constraint(equalTo: mainContainerRight.centerXAnchor).isActive = true
        createGraphButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
    }

}
