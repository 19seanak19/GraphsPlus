//
//  NewLineGraphViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/2/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LineData: Codable {
    var name: String = "Default"
    var encodedExpression: EncodedExpression = EncodedExpression()
    var lineStyle: String = "Default"
}

class LineGraphData: GraphData {
    var lineData: [LineData] = []
}

class NewLineGraphViewController: NewGraphViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(to: "New Line Graph")
        
        dataTableTitleLabel.text = "Lines:"
        
        self.view.bringSubviewToFront(addLineDataView)
        addLineDataView.delegate = self
        addLineDataView.isHidden = true
    }
    
    
    // MARK: - Internal Members
    
    internal var lineData: [LineData] = []
    
    internal func setCurrentGraphDataToInput() {
        GraphModel.shared.currentLineGraphData.graphTitle = ((graphNameTextField.text ?? "") == "") ? nil : graphNameTextField.text
        GraphModel.shared.currentLineGraphData.xAxisTitle = ((xAxisTextField.text ?? "") == "") ? nil : xAxisTextField.text
        GraphModel.shared.currentLineGraphData.yAxisTitle = ((yAxisTextField.text ?? "") == "") ? nil : yAxisTextField.text
        GraphModel.shared.currentLineGraphData.minX = (Double((minXAxisTextField.text ?? "0.0")) ?? 0.0)
        GraphModel.shared.currentLineGraphData.maxX = (Double((maxXAxisTextField.text ?? "10.0")) ?? 10.0)
        GraphModel.shared.currentLineGraphData.minY = (Double((minYAxisTextField.text ?? "0.0")) ?? 0.0)
        GraphModel.shared.currentLineGraphData.maxY = (Double((maxYAxisTextField.text ?? "10.0")) ?? 10.0)
        GraphModel.shared.currentLineGraphData.lineData = lineData
        GraphModel.shared.currentLineGraphData.graphStyle = graphStyleName
    }
    
    override internal func presentGraphDisplayVC() {
        let graphDisplayVC = GraphDisplayViewController()
        graphDisplayVC.setGraphView(toType: .lineGraph)
        graphDisplayVC.dismissClosure = {
            self.dismissGraphsPlusVC(graphDisplayVC)
        }
        self.presentGraphsPlusVC(graphDisplayVC)
    }
    
    override internal func removeData(atIndexPath indexPath: IndexPath) {
        lineData.remove(at: indexPath.row)
    }
    
    override internal func moveData(from sourcePath: IndexPath, to destinationPath: IndexPath) {
        let lineToMove = lineData.remove(at: sourcePath.row)
        lineData.insert(lineToMove, at: destinationPath.row)
    }
    
    // MARK: - @objc Functions
    
    @objc override internal func addData() {
        addLineDataView.clearFields()
        DesignDefaults.Animation.fadeInKeyboardShade(addDataViewShade)
        DesignDefaults.Animation.fadeAndScaleIn(addLineDataView)
    }
    
    @objc override internal func createGraph() {
        super.createGraph()
        
        setCurrentGraphDataToInput()
        
        GraphModel.shared.addCurrentLineGraph()
        
        presentGraphDisplayVC()
    }
    
    @objc override internal func hideKeyboard() {
        super.hideKeyboard()
        
        if addLineDataView.nameTextField.isFirstResponder {
           addLineDataView.nameTextField.resignFirstResponder()
        }
    }
    
    // MARK: - UITableViewDataSource Implementation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let lineCell = dataTableView.dequeueReusableCell(withIdentifier: cellResuseID, for: indexPath) as? GraphDataTableViewCell {
            let cellBGColor = ((indexPath.row % 2) == 0) ? DesignDefaults.bgMedGray : DesignDefaults.bgMedGray_High
            
            let line = lineData[indexPath.row]
            
            lineCell.setLeftLabelText(to: line.name)
            lineCell.setMiddleLabelText(to: line.encodedExpression.decodedExpression)
            lineCell.setRightLabelText(to: line.lineStyle)
            lineCell.setInitialBackgroundColor(to: cellBGColor)
            
            return lineCell
        }
        
        return UITableViewCell(frame: CGRect.zero)
    }
    
    
    // MARK: - AddDataViewDelegate Implementation
    
    override func addDataSetStylePressed() {
        let setStyleButtonFrame = addLineDataView.convert(addLineDataView.setStyleButton.frame, to: self.view)
        let setStyleButtonCornerRadius = addLineDataView.setStyleButton.layer.cornerRadius
        
        let lineStyleEditorVC = LineStyleEditorViewController()
        lineStyleEditorVC.dismissClosure = {
            self.addLineDataView.styleNameLabel.labelText = lineStyleEditorVC.lineStyle.name
            self.dismissGraphsPlusVCWithExpandingCover(toFrame: setStyleButtonFrame, frameCornerRadius: setStyleButtonCornerRadius, completion: nil)
        }
        self.presentGraphsPlusVCWithExpandingCover(lineStyleEditorVC, fromFrame: setStyleButtonFrame, frameCornerRadius: setStyleButtonCornerRadius, completion: nil)
    }
    
    override func addDataCancelPressed() {
        DesignDefaults.Animation.fadeOutKeyboardShade(addDataViewShade)
        DesignDefaults.Animation.fadeAndScaleOut(addLineDataView)
    }
    
    override func addDataAddPressed() {
        DesignDefaults.Animation.fadeOutKeyboardShade(addDataViewShade)
        DesignDefaults.Animation.fadeAndScaleOut(addLineDataView)
        if let newLineData = addLineDataView.getLineDataFromInput() {
            lineData.append(newLineData)
            dataTableView.reloadData()
        }
        
    }
    
    override func addDataSetEquationPressed() {
        let setEquationButtonFrame = addLineDataView.convert(addLineDataView.setEquationButton.frame, to: self.view)
        let setEquationButtonCornerRadius = addLineDataView.setEquationButton.layer.cornerRadius
        
        let equationEditorVC = EquationEditorViewController()
        equationEditorVC.dismissClosure = {
            if let expression = equationEditorVC.equationExpression {
                self.addLineDataView.lineExpression = expression
            }
            self.dismissGraphsPlusVCWithExpandingCover(toFrame: setEquationButtonFrame, frameCornerRadius: setEquationButtonCornerRadius, completion: nil)
        }
        self.presentGraphsPlusVCWithExpandingCover(equationEditorVC, fromFrame: setEquationButtonFrame, frameCornerRadius: setEquationButtonCornerRadius, completion: nil)
    }
    
    
    // MARK: - @objc Functions
    
    @objc override internal func keyboardWillShow() {
        if addLineDataView.isHidden {
            super.keyboardWillShow()
        }
    }
    
    @objc override internal func keyboardWillHide() {
        if addLineDataView.isHidden {
            super.keyboardWillHide()
        }
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let addLineDataView = AddLineDataView()
    
    override internal func addUI() {
        super.addUI()
        
        self.view.addSubview(addLineDataView)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        addLineDataView.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor).isActive = true
        addLineDataView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        addLineDataView.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        addLineDataView.setUIHeight(usingView: mainContainer)
    }
    
}
