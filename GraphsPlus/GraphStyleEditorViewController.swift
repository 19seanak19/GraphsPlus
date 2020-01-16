//
//  GraphStyleEditorViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class GraphStyle: Codable {
    var name: String = DesignDefaults.defaultGraphStyleName
    var primaryBGColor: CodableColor = DesignDefaults.defaultPrimaryGraphBGColor.codableColor
    var secondaryBGColor: CodableColor = DesignDefaults.defaultSecondaryGraphBGColor.codableColor
    var primaryAxisColor: CodableColor = DesignDefaults.defaultPrimaryGraphAxisColor.codableColor
    var secondaryAxisColor: CodableColor = DesignDefaults.defaultSecondaryGraphAxisColor.codableColor
    var drawSecondaryXAxis: Bool = DesignDefaults.defaultDrawSecondaryXAxis
    var drawSecondaryYAxis: Bool = DesignDefaults.defaultDrawSecondaryYAxis
    var showGraphTitle: Bool = DesignDefaults.defaultShowGraphTitle
    var showXAxisTitle: Bool = DesignDefaults.defaultShowXAxisTitle
    var showYAxisTitle: Bool = DesignDefaults.defaultShowYAxisTitle
}

class GraphStyleEditorViewController: StyleEditorViewController {

    // MARK: - Public Members
    
    public var graphStyle = GraphStyle() {
        didSet {
            setUpViewsUsingGraphStyle()
        }
    }
    
    public var didSave: Bool = false
    
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(to: "Graph Style Editor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpViewsUsingGraphStyle()
    }
    
    
    // MARK: - Internal Members
    
    override internal func setUpColorPicker() {
        super.setUpColorPicker()
        
        let bgColorPrimaryPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePrimaryBGColor))
        bgColorPrimaryPreview.addGestureRecognizer(bgColorPrimaryPreviewTapRecognizer)
        
        let bgColorSecondaryPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseSecondaryBGColor))
        bgColorSecondaryPreview.addGestureRecognizer(bgColorSecondaryPreviewTapRecognizer)
        
        let axisColorPrimaryPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePrimaryAxisColor))
        axisColorPrimaryPreview.addGestureRecognizer(axisColorPrimaryPreviewTapRecognizer)
        
        let axisColorSecondaryPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseSecondaryAxisColor))
        axisColorSecondaryPreview.addGestureRecognizer(axisColorSecondaryPreviewTapRecognizer)
    }
    
    override internal func styleAlreadyExists() -> Bool {
        return GraphModel.shared.checkForGraphStyle(named: graphStyle.name)
    }
    
    override internal func nameForStyle() -> String {
        return graphStyle.name
    }
    
    override internal func finalSaveStyle() {
        GraphModel.shared.addGraphStyle(graphStyle)
        didSave = true
        dismissByClosure()
    }
    
    // MARK: - Private Functions
    
    private func setUpViewsUsingGraphStyle() {
        styleNameTextField.text = (graphStyle.name != DesignDefaults.defaultGraphStyleName) ? graphStyle.name : nil
        bgColorPrimaryPreview.backgroundColor = graphStyle.primaryBGColor.uiColor
        bgColorSecondaryPreview.backgroundColor = graphStyle.secondaryBGColor.uiColor
        axisColorPrimaryPreview.backgroundColor = graphStyle.primaryAxisColor.uiColor
        axisColorSecondaryPreview.backgroundColor = graphStyle.secondaryAxisColor.uiColor
        drawSecondaryXToggle.isToggled = graphStyle.drawSecondaryXAxis
        drawSecondaryYToggle.isToggled = graphStyle.drawSecondaryYAxis
        showTitleToggle.isToggled = graphStyle.showGraphTitle
        showXTitleToggle.isToggled = graphStyle.showXAxisTitle
        showYTitleToggle.isToggled = graphStyle.showYAxisTitle
        
    }
    
    private func assignAllSetValuesToStyle() {
        if let inputName = styleNameTextField.text {
            if inputName != "" {
                graphStyle.name = inputName
            } else {
                graphStyle.name = DesignDefaults.defaultGraphStyleName
            }
        }
        graphStyle.drawSecondaryXAxis = drawSecondaryXToggle.isToggled
        graphStyle.drawSecondaryYAxis = drawSecondaryYToggle.isToggled
        graphStyle.showGraphTitle = showTitleToggle.isToggled
        graphStyle.showXAxisTitle = showXTitleToggle.isToggled
        graphStyle.showYAxisTitle = showYTitleToggle.isToggled
    }
    
    
    // MARK: - @objc Functions
    
    @objc private func choosePrimaryBGColor() {
        colorPickerView.setup(withInitialColor: (bgColorPrimaryPreview.backgroundColor ?? .white), andExitHandler: { (pickedColor: UIColor) in
            self.bgColorPrimaryPreview.backgroundColor = pickedColor
            self.graphStyle.primaryBGColor = pickedColor.codableColor
            self.hideColorPicker()
        })
        showColorPicker()
    }
    
    @objc private func chooseSecondaryBGColor() {
        colorPickerView.setup(withInitialColor: (bgColorSecondaryPreview.backgroundColor ?? .white), andExitHandler: { (pickedColor: UIColor) in
            self.bgColorSecondaryPreview.backgroundColor = pickedColor
            self.graphStyle.secondaryBGColor = pickedColor.codableColor
            self.hideColorPicker()
        })
        showColorPicker()
    }
    
    @objc private func choosePrimaryAxisColor() {
        colorPickerView.setup(withInitialColor: (axisColorPrimaryPreview.backgroundColor ?? .white), andExitHandler: { (pickedColor: UIColor) in
            self.axisColorPrimaryPreview.backgroundColor = pickedColor
            self.graphStyle.primaryAxisColor = pickedColor.codableColor
            self.hideColorPicker()
        })
        showColorPicker()
    }
    
    @objc private func chooseSecondaryAxisColor() {
        colorPickerView.setup(withInitialColor: (axisColorSecondaryPreview.backgroundColor ?? .white), andExitHandler: { (pickedColor: UIColor) in
            self.axisColorSecondaryPreview.backgroundColor = pickedColor
            self.graphStyle.secondaryAxisColor = pickedColor.codableColor
            self.hideColorPicker()
        })
        showColorPicker()
    }
    
    @objc override internal func saveStyle() {
        assignAllSetValuesToStyle()
        super.saveStyle()
    }
    
    @objc override internal func dismissByClosure() {
        super.dismissByClosure()
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let bgColorLabel: UILabel = DesignDefaults.makeLabel(withText: "BG Colors (Primary/Secondary):")
    private let bgColorPreviewSpacer = SpacerView()
    private let bgColorPrimaryPreview: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgGray, andBorderColor: DesignDefaults.bgDarkGray)
    private let bgColorSecondaryPreview: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgGray, andBorderColor: DesignDefaults.bgDarkGray)
    
    private let axisColorLabel: UILabel = DesignDefaults.makeLabel(withText: "Axis Colors (Primary/Secondary):")
    private let axisColorPreviewSpacer = SpacerView()
    private let axisColorPrimaryPreview: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.primaryText, andBorderColor: DesignDefaults.bgDarkGray)
    private let axisColorSecondaryPreview: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.primaryText, andBorderColor: DesignDefaults.bgDarkGray)
    
    private let drawSecondaryAxisLabel: UILabel = DesignDefaults.makeLabel(withText: "Draw Sec. Axis (X/Y):")
    private let drawSecondaryAxisSpacer = SpacerView()
    private let drawSecondaryXToggle = ToggleBox()
    private let drawSecondaryYToggle = ToggleBox()
    
    private let showTitleLabel: UILabel = DesignDefaults.makeLabel(withText: "Show Graph Title:")
    private let showTitleToggle = ToggleBox()
    
    private let showAxisLabelsLabel: UILabel = DesignDefaults.makeLabel(withText: "Show Axis Titles (X/Y):")
    private let showAxisLabelsSpacer = SpacerView()
    private let showXTitleToggle = ToggleBox()
    private let showYTitleToggle = ToggleBox()
    
    override internal func addUI() {
        super.addUI()
        
        mainContainer.addSubview(bgColorLabel)
        mainContainer.addSubview(bgColorPreviewSpacer)
        bgColorPreviewSpacer.addSubview(bgColorPrimaryPreview)
        bgColorPreviewSpacer.addSubview(bgColorSecondaryPreview)
        mainContainer.addSubview(axisColorLabel)
        mainContainer.addSubview(axisColorPreviewSpacer)
        axisColorPreviewSpacer.addSubview(axisColorPrimaryPreview)
        axisColorPreviewSpacer.addSubview(axisColorSecondaryPreview)
        mainContainer.addSubview(drawSecondaryAxisLabel)
        mainContainer.addSubview(drawSecondaryAxisSpacer)
        mainContainer.addSubview(drawSecondaryXToggle)
        mainContainer.addSubview(drawSecondaryYToggle)
        mainContainer.addSubview(showTitleLabel)
        mainContainer.addSubview(showTitleToggle)
        mainContainer.addSubview(showAxisLabelsLabel)
        mainContainer.addSubview(showAxisLabelsSpacer)
        mainContainer.addSubview(showXTitleToggle)
        mainContainer.addSubview(showYTitleToggle)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        bgColorLabel.topAnchor.constraint(equalTo: styleNameTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        bgColorLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        bgColorLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        bgColorPreviewSpacer.topAnchor.constraint(equalTo: bgColorLabel.bottomAnchor).isActive = true
        bgColorPreviewSpacer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        bgColorPreviewSpacer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -2.0 * DesignDefaults.padding).isActive = true
        bgColorPreviewSpacer.heightAnchor.constraint(equalTo: bgColorLabel.heightAnchor).isActive = true
        
        bgColorPrimaryPreview.topAnchor.constraint(equalTo: bgColorPreviewSpacer.topAnchor).isActive = true
        bgColorPrimaryPreview.bottomAnchor.constraint(equalTo: bgColorPreviewSpacer.bottomAnchor).isActive = true
        bgColorPrimaryPreview.leftAnchor.constraint(equalTo: bgColorPreviewSpacer.leftAnchor).isActive = true
        bgColorPrimaryPreview.rightAnchor.constraint(equalTo: bgColorPreviewSpacer.centerXAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        bgColorSecondaryPreview.topAnchor.constraint(equalTo: bgColorPreviewSpacer.topAnchor).isActive = true
        bgColorSecondaryPreview.bottomAnchor.constraint(equalTo: bgColorPreviewSpacer.bottomAnchor).isActive = true
        bgColorSecondaryPreview.rightAnchor.constraint(equalTo: bgColorPreviewSpacer.rightAnchor).isActive = true
        bgColorSecondaryPreview.leftAnchor.constraint(equalTo: bgColorPreviewSpacer.centerXAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        
        axisColorLabel.topAnchor.constraint(equalTo: bgColorPreviewSpacer.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        axisColorLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        axisColorLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        axisColorPreviewSpacer.topAnchor.constraint(equalTo: axisColorLabel.bottomAnchor).isActive = true
        axisColorPreviewSpacer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        axisColorPreviewSpacer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -2.0 * DesignDefaults.padding).isActive = true
        axisColorPreviewSpacer.heightAnchor.constraint(equalTo: axisColorLabel.heightAnchor).isActive = true
        
        axisColorPrimaryPreview.topAnchor.constraint(equalTo: axisColorPreviewSpacer.topAnchor).isActive = true
        axisColorPrimaryPreview.bottomAnchor.constraint(equalTo: axisColorPreviewSpacer.bottomAnchor).isActive = true
        axisColorPrimaryPreview.leftAnchor.constraint(equalTo: axisColorPreviewSpacer.leftAnchor).isActive = true
        axisColorPrimaryPreview.rightAnchor.constraint(equalTo: axisColorPreviewSpacer.centerXAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        axisColorSecondaryPreview.topAnchor.constraint(equalTo: axisColorPreviewSpacer.topAnchor).isActive = true
        axisColorSecondaryPreview.bottomAnchor.constraint(equalTo: axisColorPreviewSpacer.bottomAnchor).isActive = true
        axisColorSecondaryPreview.rightAnchor.constraint(equalTo: axisColorPreviewSpacer.rightAnchor).isActive = true
        axisColorSecondaryPreview.leftAnchor.constraint(equalTo: axisColorPreviewSpacer.centerXAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        
        drawSecondaryAxisLabel.topAnchor.constraint(equalTo: axisColorPreviewSpacer.bottomAnchor, constant: 1.5 * DesignDefaults.padding).isActive = true
        drawSecondaryAxisLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        drawSecondaryAxisLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        drawSecondaryYToggle.topAnchor.constraint(equalTo: drawSecondaryAxisLabel.topAnchor).isActive = true
        drawSecondaryYToggle.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        drawSecondaryYToggle.heightAnchor.constraint(equalTo: drawSecondaryAxisLabel.heightAnchor).isActive = true
        drawSecondaryYToggle.widthAnchor.constraint(equalTo: drawSecondaryAxisLabel.heightAnchor).isActive = true
        
        drawSecondaryAxisSpacer.topAnchor.constraint(equalTo: drawSecondaryAxisLabel.topAnchor).isActive = true
        drawSecondaryAxisSpacer.leftAnchor.constraint(equalTo: drawSecondaryAxisLabel.rightAnchor).isActive = true
        drawSecondaryAxisSpacer.rightAnchor.constraint(equalTo: drawSecondaryYToggle.leftAnchor).isActive = true
        drawSecondaryAxisSpacer.heightAnchor.constraint(equalTo: drawSecondaryAxisLabel.heightAnchor).isActive = true
        
        drawSecondaryXToggle.topAnchor.constraint(equalTo: drawSecondaryAxisLabel.topAnchor).isActive = true
        drawSecondaryXToggle.centerXAnchor.constraint(equalTo: drawSecondaryAxisSpacer.centerXAnchor).isActive = true
        drawSecondaryXToggle.heightAnchor.constraint(equalTo: drawSecondaryAxisLabel.heightAnchor).isActive = true
        drawSecondaryXToggle.widthAnchor.constraint(equalTo: drawSecondaryAxisLabel.heightAnchor).isActive = true
        
        showTitleLabel.topAnchor.constraint(equalTo: drawSecondaryAxisLabel.bottomAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        showTitleLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        showTitleLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        showTitleToggle.topAnchor.constraint(equalTo: showTitleLabel.topAnchor).isActive = true
        showTitleToggle.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        showTitleToggle.heightAnchor.constraint(equalTo: showTitleLabel.heightAnchor).isActive = true
        showTitleToggle.widthAnchor.constraint(equalTo: showTitleLabel.heightAnchor).isActive = true
        
        showAxisLabelsLabel.topAnchor.constraint(equalTo: showTitleLabel.bottomAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        showAxisLabelsLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        showAxisLabelsLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        showYTitleToggle.topAnchor.constraint(equalTo: showAxisLabelsLabel.topAnchor).isActive = true
        showYTitleToggle.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        showYTitleToggle.heightAnchor.constraint(equalTo: showAxisLabelsLabel.heightAnchor).isActive = true
        showYTitleToggle.widthAnchor.constraint(equalTo: showAxisLabelsLabel.heightAnchor).isActive = true
        
        showAxisLabelsSpacer.topAnchor.constraint(equalTo: showAxisLabelsLabel.topAnchor).isActive = true
        showAxisLabelsSpacer.leftAnchor.constraint(equalTo: showAxisLabelsLabel.rightAnchor).isActive = true
        showAxisLabelsSpacer.rightAnchor.constraint(equalTo: showYTitleToggle.leftAnchor).isActive = true
        showAxisLabelsSpacer.heightAnchor.constraint(equalTo: showAxisLabelsLabel.heightAnchor).isActive = true
        
        showXTitleToggle.topAnchor.constraint(equalTo: showAxisLabelsLabel.topAnchor).isActive = true
        showXTitleToggle.centerXAnchor.constraint(equalTo: showAxisLabelsSpacer.centerXAnchor).isActive = true
        showXTitleToggle.heightAnchor.constraint(equalTo: showAxisLabelsLabel.heightAnchor).isActive = true
        showXTitleToggle.widthAnchor.constraint(equalTo: showAxisLabelsLabel.heightAnchor).isActive = true
    }

}
