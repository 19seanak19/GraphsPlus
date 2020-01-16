//
//  LineStyleEditorViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/21/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LineStyle: Codable {
    var name: String = DesignDefaults.defaultLineStyleName
    var lineColor: CodableColor = DesignDefaults.defaultLineColor.codableColor
    var lineWidth: CGFloat = DesignDefaults.defaultLineWidth
    var showEquation: Bool = DesignDefaults.defaultShowEquation
}

class LineStyleEditorViewController: StyleEditorViewController {

    // MARK: - Public Members
    
    public var lineStyle = LineStyle()
    
    public func setLineStyle(toNewStyle style: LineStyle) {
        self.lineStyle = style
    }
    
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(to: "Line Style Editor")
        
        lineWidthTextField.keyboardType = .decimalPad
        lineWidthTextField.attributedPlaceholder = NSAttributedString(string: "1.0", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        lineWidthTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpLinePreview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpViewsUsingLineStyle()
    }
    
    // MARK: - Internal Members
    
    override internal func setUpColorPicker() {
        super.setUpColorPicker()
        
        let lineColorPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseLineColor))
        lineColorPreview.addGestureRecognizer(lineColorPreviewTapRecognizer)
    }
    
    override func bringTextFieldsToFront() {
        super.bringTextFieldsToFront()
        
        self.view.bringSubviewToFront(lineWidthTextField)
    }
    
    override internal func styleAlreadyExists() -> Bool {
        return GraphModel.shared.checkForLineStyle(named: lineStyle.name)
    }
    
    override internal func nameForStyle() -> String {
        return lineStyle.name
    }
    
    override internal func finalSaveStyle() {
        GraphModel.shared.addLineStyle(lineStyle)
        dismissByClosure()
    }
    
    
    // MARK: - Private Members
    
    private func checkWidthTextForCorrectness() {
        if let widthText = lineWidthTextField.text {
            if widthText.contains(".") {
                let firstDotIndex = widthText.firstIndex(of: ".")
                let lastDotIndex = widthText.lastIndex(of: ".")
                
                if firstDotIndex != lastDotIndex {
                    lineWidthTextField.text = nil
                    return
                }
            }
            if let widthText = lineWidthTextField.text, let widthVal = Double(widthText) {
                linePreviewLayer.lineWidth = CGFloat(widthVal)
                lineStyle.lineWidth = CGFloat(widthVal)
            }
        } else {
            linePreviewLayer.lineWidth = 1.0
            lineStyle.lineWidth = 1.0
        }
    }
    
    private func setUpLinePreview() {
        linePreviewLayer.frame = linePreview.bounds
        linePreviewLayer.masksToBounds = true
        linePreviewLayer.strokeColor = lineStyle.lineColor.uiColor.cgColor
        linePreviewLayer.lineWidth = lineStyle.lineWidth
        linePreviewLayer.lineJoin = CAShapeLayerLineJoin.round
        
        let previewLinePath = UIBezierPath()
        previewLinePath.move(to: linePreview.bounds.origin)
        previewLinePath.addLine(to: CGPoint(x: linePreview.bounds.maxX, y: linePreview.bounds.maxY))
        
        linePreviewLayer.path = previewLinePath.cgPath
        
        linePreview.layer.addSublayer(linePreviewLayer)
    }
    
    private func setUpViewsUsingLineStyle() {
        lineColorPreview.backgroundColor = lineStyle.lineColor.uiColor
        linePreviewLayer.strokeColor = lineStyle.lineColor.uiColor.cgColor
        linePreviewLayer.lineWidth = lineStyle.lineWidth
    
        styleNameTextField.text = (lineStyle.name != DesignDefaults.defaultLineStyleName) ? lineStyle.name : nil
        
        showEquationToggle.isToggled = lineStyle.showEquation
    }
    
    private func assignAllSetValuesToStyle() {
        if let inputName = styleNameTextField.text {
            if inputName != "" {
                lineStyle.name = inputName
            } else {
                lineStyle.name = DesignDefaults.defaultLineStyleName
            }
        }
        lineStyle.showEquation = showEquationToggle.isToggled
    }
    
    
    // MARK: - @objc Functions
    
    @objc private func chooseLineColor() {
        colorPickerView.setup(withInitialColor: (lineColorPreview.backgroundColor ?? .white), andExitHandler: { (pickedColor: UIColor) in
            self.lineColorPreview.backgroundColor = pickedColor
            self.linePreviewLayer.strokeColor = pickedColor.cgColor
            self.lineStyle.lineColor = pickedColor.codableColor
            self.hideColorPicker()
        })
        showColorPicker()
    }
    
    @objc override internal func hideKeyboard() {
        super.hideKeyboard()
        
        if lineWidthTextField.isFirstResponder {
            lineWidthTextField.resignFirstResponder()
            checkWidthTextForCorrectness()
        }
    }
    
    @objc override internal func saveStyle() {
        assignAllSetValuesToStyle()
        super.saveStyle()
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let lineColorWidthLabel: UILabel = DesignDefaults.makeLabel(withText: "Line Color and Width:")
    private let lineColorWidthSpacer = SpacerView()
    private let lineColorPreview: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.defaultLineColor, andBorderColor: DesignDefaults.bgDarkGray)
    private let lineWidthTextField: UITextField = DesignDefaults.makeTextField()
    
    private let showEquationLabel: UILabel = DesignDefaults.makeLabel(withText: "Show Line Equation:")
    private let showEquationToggle = ToggleBox()
    
    private let linePreview: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let linePreviewLayer = CAShapeLayer()
    
    
    override internal func addUI() {
        super.addUI()
        
        self.view.addSubview(lineColorWidthLabel)
        self.view.addSubview(lineColorWidthSpacer)
        self.view.addSubview(lineColorPreview)
        self.view.addSubview(lineWidthTextField)
        self.view.addSubview(showEquationLabel)
        self.view.addSubview(showEquationToggle)
        self.view.addSubview(linePreview)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        lineColorWidthLabel.topAnchor.constraint(equalTo: styleNameTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        lineColorWidthLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        lineColorWidthLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        lineColorWidthSpacer.topAnchor.constraint(equalTo: lineColorWidthLabel.bottomAnchor).isActive = true
        lineColorWidthSpacer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        lineColorWidthSpacer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        lineColorWidthSpacer.heightAnchor.constraint(equalTo: lineColorWidthLabel.heightAnchor).isActive = true
        
        lineColorPreview.topAnchor.constraint(equalTo: lineColorWidthSpacer.topAnchor).isActive = true
        lineColorPreview.bottomAnchor.constraint(equalTo: lineColorWidthSpacer.bottomAnchor).isActive = true
        lineColorPreview.leftAnchor.constraint(equalTo: lineColorWidthSpacer.leftAnchor).isActive = true
        lineColorPreview.rightAnchor.constraint(equalTo: lineColorWidthSpacer.centerXAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        lineWidthTextField.topAnchor.constraint(equalTo: lineColorWidthSpacer.topAnchor).isActive = true
        lineWidthTextField.bottomAnchor.constraint(equalTo: lineColorWidthSpacer.bottomAnchor).isActive = true
        lineWidthTextField.rightAnchor.constraint(equalTo: lineColorWidthSpacer.rightAnchor).isActive = true
        lineWidthTextField.leftAnchor.constraint(equalTo: lineColorWidthSpacer.centerXAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        
        showEquationLabel.topAnchor.constraint(equalTo: lineColorWidthSpacer.bottomAnchor, constant: 1.5 * DesignDefaults.padding).isActive = true
        showEquationLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        showEquationLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        showEquationToggle.topAnchor.constraint(equalTo: showEquationLabel.topAnchor).isActive = true
        showEquationToggle.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        showEquationToggle.heightAnchor.constraint(equalTo: showEquationLabel.heightAnchor).isActive = true
        showEquationToggle.widthAnchor.constraint(equalTo: showEquationLabel.heightAnchor).isActive = true
        
        linePreview.topAnchor.constraint(equalTo: showEquationLabel.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        linePreview.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -DesignDefaults.padding).isActive = true
        linePreview.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        linePreview.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
    }

}
