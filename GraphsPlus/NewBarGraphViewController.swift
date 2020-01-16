//
//  NewBarGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/2/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class BarData: Codable {
    var name: String = "Default"
    var value: Double = 0.0
    var barStyle: String = "Default"
}

class BarGraphData: GraphData {
    var barData: [BarData] = []
    var showNames: Bool = false
}

class NewBarGraphViewController: NewGraphViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(to: "New Bar Graph")
        
        xLimitSpacer.isHidden = true
        
        dataTableTitleLabel.text = "Bars:"
        
        self.view.bringSubviewToFront(addBarDataView)
        addBarDataView.delegate = self
        addBarDataView.isHidden = true
    }
    
    
    // MARK: - Internal Members
    
    internal var barData: [BarData] = []
    
    internal func setCurrentGraphDataToInput() {
        GraphModel.shared.currentBarGraphData.graphTitle = ((graphNameTextField.text ?? "") == "") ? nil : graphNameTextField.text
        GraphModel.shared.currentBarGraphData.xAxisTitle = ((xAxisTextField.text ?? "") == "") ? nil : xAxisTextField.text
        GraphModel.shared.currentBarGraphData.yAxisTitle = ((yAxisTextField.text ?? "") == "") ? nil : yAxisTextField.text
        GraphModel.shared.currentBarGraphData.showNames = barNamesToggle.isToggled
        GraphModel.shared.currentBarGraphData.minY = (Double((minYAxisTextField.text ?? "0.0")) ?? 0.0)
        GraphModel.shared.currentBarGraphData.maxY = (Double((maxYAxisTextField.text ?? "10.0")) ?? 10.0)
        GraphModel.shared.currentBarGraphData.barData = barData
        GraphModel.shared.currentBarGraphData.graphStyle = graphStyleName
    }
    
    override internal func presentGraphDisplayVC() {
        let graphDisplayVC = GraphDisplayViewController()
        graphDisplayVC.setGraphView(toType: .barGraph)
        graphDisplayVC.dismissClosure = {
            self.dismissGraphsPlusVC(graphDisplayVC)
        }
        self.presentGraphsPlusVC(graphDisplayVC)
    }
    
    override internal func removeData(atIndexPath indexPath: IndexPath) {
        barData.remove(at: indexPath.row)
    }
    
    override internal func moveData(from sourcePath: IndexPath, to destinationPath: IndexPath) {
        let barToMove = barData.remove(at: sourcePath.row)
        barData.insert(barToMove, at: destinationPath.row)
    }
    
    // MARK: - @objc Functions
    
    @objc override internal func addData() {
        addBarDataView.clearFields()
        DesignDefaults.Animation.fadeInKeyboardShade(addDataViewShade)
        DesignDefaults.Animation.fadeAndScaleIn(addBarDataView)
    }
    
    @objc override internal func createGraph() {
        super.createGraph()
        
        setCurrentGraphDataToInput()
        
        GraphModel.shared.addCurrentBarGraph()
        
        presentGraphDisplayVC()
    }
    
    @objc override internal func hideKeyboard() {
        super.hideKeyboard()
        
        if addBarDataView.nameTextField.isFirstResponder {
            addBarDataView.nameTextField.resignFirstResponder()
        } else if addBarDataView.valueTextField.isFirstResponder {
            addBarDataView.valueTextField.resignFirstResponder()
        }
    }
    
    // MARK: - UITableViewDataSource Implementation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let barCell = dataTableView.dequeueReusableCell(withIdentifier: cellResuseID, for: indexPath) as? GraphDataTableViewCell {
            let cellBGColor = ((indexPath.row % 2) == 0) ? DesignDefaults.bgMedGray : DesignDefaults.bgMedGray_High
            
            let bar = barData[indexPath.row]
            
            barCell.setLeftLabelText(to: bar.name)
            barCell.setMiddleLabelText(to: "\(bar.value)")
            barCell.setRightLabelText(to: bar.barStyle)
            barCell.setInitialBackgroundColor(to: cellBGColor)
            
            return barCell
        }
        
        return UITableViewCell(frame: CGRect.zero)
    }
    
    
    // MARK: - AddDataViewDelegate Implementation
    
    override func addDataSetStylePressed() {
        let setStyleButtonFrame = addBarDataView.convert(addBarDataView.setStyleButton.frame, to: self.view)
        let setStyleButtonCornerRadius = addBarDataView.setStyleButton.layer.cornerRadius
        
        let barStyleEditorVC = BarStyleEditorViewController()
        barStyleEditorVC.dismissClosure = {
            self.addBarDataView.styleNameLabel.labelText = barStyleEditorVC.barStyle.name
            self.dismissGraphsPlusVCWithExpandingCover(toFrame: setStyleButtonFrame, frameCornerRadius: setStyleButtonCornerRadius, completion: nil)
        }
        self.presentGraphsPlusVCWithExpandingCover(barStyleEditorVC, fromFrame: setStyleButtonFrame, frameCornerRadius: setStyleButtonCornerRadius, completion: nil)
    }
    
    override func addDataCancelPressed() {
        DesignDefaults.Animation.fadeOutKeyboardShade(addDataViewShade)
        DesignDefaults.Animation.fadeAndScaleOut(addBarDataView)
    }
    
    override func addDataAddPressed() {
        DesignDefaults.Animation.fadeOutKeyboardShade(addDataViewShade)
        DesignDefaults.Animation.fadeAndScaleOut(addBarDataView)
        if let newBarData = addBarDataView.getBarDataFromInput() {
            barData.append(newBarData)
            dataTableView.reloadData()
        }
        
    }
    
    
    // MARK: - @objc Functions
    
    @objc override internal func keyboardWillShow() {
        if addBarDataView.isHidden {
            super.keyboardWillShow()
        }
    }
    
    @objc override internal func keyboardWillHide() {
        if addBarDataView.isHidden {
            super.keyboardWillHide()
        }
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let barNamesLabel: UILabel = DesignDefaults.makeLabel(withText: "Bar Names: ")
    internal let barNamesToggle = ToggleBox()
    
    private let addBarDataView = AddBarDataView()
    
    override internal func addUI() {
        super.addUI()
        
        self.view.addSubview(barNamesLabel)
        self.view.addSubview(barNamesToggle)
        self.view.addSubview(addBarDataView)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        barNamesToggle.rightAnchor.constraint(equalTo: xLimitSpacer.rightAnchor).isActive = true
        barNamesToggle.centerYAnchor.constraint(equalTo: xLimitSpacer.centerYAnchor).isActive = true
        barNamesToggle.heightAnchor.constraint(equalTo: xLimitSpacer.heightAnchor).isActive = true
        barNamesToggle.widthAnchor.constraint(equalTo: xLimitSpacer.heightAnchor).isActive = true
        
        barNamesLabel.leftAnchor.constraint(equalTo: xLimitSpacer.leftAnchor).isActive = true
        barNamesLabel.topAnchor.constraint(equalTo: xLimitSpacer.topAnchor).isActive = true
        barNamesLabel.bottomAnchor.constraint(equalTo: xLimitSpacer.bottomAnchor).isActive = true
        barNamesLabel.rightAnchor.constraint(equalTo: barNamesToggle.leftAnchor, constant: -DesignDefaults.padding).isActive = true
        
        addBarDataView.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor).isActive = true
        addBarDataView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        addBarDataView.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        addBarDataView.setUIHeight(usingView: mainContainer)
    }
}
