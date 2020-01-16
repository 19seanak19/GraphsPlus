//
//  BarStyleEditorViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/4/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class BarStyle: Codable {
    var name: String = DesignDefaults.defaultBarStyleName
    var barColor: CodableColor = DesignDefaults.defaultBarColor.codableColor
    var barRoundness: CGFloat = DesignDefaults.defaultBarRoundness
    var barWidth: CGFloat = DesignDefaults.defaultBarWidth
    var showValue: Bool = DesignDefaults.defaultShowValue
}

class BarStyleEditorViewController: StyleEditorViewController {
    
    // MARK: - Public Members
    
    public var barStyle = BarStyle()
    
    public func setBarStyle(toNewStyle style: BarStyle) {
        self.barStyle = style
    }
    
    
    // MARK: - View Lifecycle and Related

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(to: "Bar Style Editor")
        
        barPreview.clipsToBounds = true
        
        barWidthSlider.addTarget(self, action: #selector(self.widthChanged), for: .valueChanged)
        barRoundnessSlider.addTarget(self, action: #selector(self.roundnessChanged), for: .valueChanged)
    }
    
    override func viewWillLayoutSubviews() {
        setBarPreviewRoundness()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpViewsUsingBarStyle()
    }
    
    
    // MARK: - Internal Members
    
    override internal func setUpColorPicker() {
        super.setUpColorPicker()
        
        let lineColorPreviewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseBarColor))
        barColorPreview.addGestureRecognizer(lineColorPreviewTapRecognizer)
    }
    
    override internal func styleAlreadyExists() -> Bool {
        return GraphModel.shared.checkForBarStyle(named: barStyle.name)
    }
    
    override internal func nameForStyle() -> String {
        return barStyle.name
    }
    
    override internal func finalSaveStyle() {
        GraphModel.shared.addBarStyle(barStyle)
        dismissByClosure()
    }
    
    
    // MARK: - Private Members
    
    private func setUpViewsUsingBarStyle() {
        leftBar.backgroundColor = barStyle.barColor.uiColor
        leftBar.layer.cornerRadius = barStyle.barRoundness
        
        rightBar.backgroundColor = barStyle.barColor.uiColor
        rightBar.layer.cornerRadius = barStyle.barRoundness
        
        barWidthSlider.value = Float(barStyle.barWidth)
        changeBarPreviewWidth(to: barStyle.barWidth)
        
        barRoundnessSlider.value = Float(barStyle.barRoundness)
        setBarPreviewRoundness()
        
        styleNameTextField.text = (barStyle.name != DesignDefaults.defaultLineStyleName) ? barStyle.name : nil
        
        showValueToggle.isToggled = barStyle.showValue
    }
    
    private func assignAllSetValuesToStyle() {
        if let inputName = styleNameTextField.text {
            if inputName != "" {
                barStyle.name = inputName
            } else {
                barStyle.name = DesignDefaults.defaultLineStyleName
            }
        }
        barStyle.showValue = showValueToggle.isToggled
    }
    
    private func changeBarPreviewWidth(to newWidth: CGFloat) {
        barStyle.barWidth = newWidth
        
        leftBarWidthConstraint?.isActive = false
        leftBarWidthConstraint = leftBar.widthAnchor.constraint(equalTo: barPreviewLeft.widthAnchor, multiplier: newWidth)
        leftBarWidthConstraint?.isActive = true
        
        rightBarWidthConstraint?.isActive = false
        rightBarWidthConstraint = rightBar.widthAnchor.constraint(equalTo: barPreviewRight.widthAnchor, multiplier: newWidth)
        rightBarWidthConstraint?.isActive = true
        
        DispatchQueue.main.async {
            self.view.setNeedsLayout()
        }
    }
    
    private func setBarPreviewRoundness() {
        leftBar.layer.cornerRadius = leftBar.bounds.width * barStyle.barRoundness
        rightBar.layer.cornerRadius = rightBar.bounds.width * barStyle.barRoundness
    }
    
    
    // MARK: - @objc Functions
    
    @objc private func chooseBarColor() {
        colorPickerView.setup(withInitialColor: (barColorPreview.backgroundColor ?? .white), andExitHandler: { (pickedColor: UIColor) in
            self.barColorPreview.backgroundColor = pickedColor
            self.leftBar.backgroundColor = pickedColor
            self.rightBar.backgroundColor = pickedColor
            self.barStyle.barColor = pickedColor.codableColor
            self.hideColorPicker()
        })
        showColorPicker()
    }
    
    @objc private func widthChanged() {
        changeBarPreviewWidth(to: CGFloat(barWidthSlider.value))
    }
    
    @objc private func roundnessChanged() {
        barStyle.barRoundness = CGFloat(barRoundnessSlider.value)
        setBarPreviewRoundness()
    }
    
    @objc override internal func saveStyle() {
        assignAllSetValuesToStyle()
        super.saveStyle()
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let barColorLabel: UILabel = DesignDefaults.makeLabel(withText: "Bar Color:")
    private let barColorPreview: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.defaultBarColor, andBorderColor: DesignDefaults.bgDarkGray)
    
    private let barWidthLabel: UILabel = DesignDefaults.makeLabel(withText: "Bar Width:")
    private let barWidthSlider: UISlider = DesignDefaults.makeSlider(withColor: DesignDefaults.bgDarkGray, minVal: 0.0, andMaxVal: 1.0)
    
    private let barRoundnessLabel: UILabel = DesignDefaults.makeLabel(withText: "Bar Roundness:")
    private let barRoundnessSlider: UISlider = DesignDefaults.makeSlider(withColor: DesignDefaults.bgDarkGray, minVal: 0.0, andMaxVal: 0.5)
    
    private let showValueLabel: UILabel = DesignDefaults.makeLabel(withText: "Show Bar Value:")
    private let showValueToggle = ToggleBox()
    
    private let barPreview: UIView = DesignDefaults.makeView(withBGColor: .clear, andBorderColor: nil)
    private let barPreviewLeft = SpacerView()
    private let barPreviewRight = SpacerView()
    
    private let leftBar = DesignDefaults.makeView(withBGColor: DesignDefaults.defaultBarColor, andBorderColor: nil)
    private var leftBarWidthConstraint: NSLayoutConstraint?
    private let rightBar = DesignDefaults.makeView(withBGColor: DesignDefaults.defaultBarColor, andBorderColor: nil)
    private var rightBarWidthConstraint: NSLayoutConstraint?
    
    private let barPreviewAxis = DesignDefaults.makeView(withBGColor: DesignDefaults.defaultPrimaryGraphAxisColor, andBorderColor: nil)
    
    override internal func addUI() {
        super.addUI()
        
        self.view.addSubview(barColorLabel)
        self.view.addSubview(barColorPreview)
        self.view.addSubview(barRoundnessLabel)
        self.view.addSubview(barRoundnessSlider)
        self.view.addSubview(barWidthLabel)
        self.view.addSubview(barWidthSlider)
        self.view.addSubview(showValueLabel)
        self.view.addSubview(showValueToggle)
        self.view.addSubview(barPreview)
        barPreview.addSubview(barPreviewLeft)
        barPreview.addSubview(barPreviewRight)
        barPreview.addSubview(leftBar)
        barPreview.addSubview(rightBar)
        barPreview.addSubview(barPreviewAxis)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        barColorLabel.topAnchor.constraint(equalTo: styleNameTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        barColorLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        barColorLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        barColorPreview.topAnchor.constraint(equalTo: barColorLabel.topAnchor).isActive = true
        barColorPreview.bottomAnchor.constraint(equalTo: barColorLabel.bottomAnchor).isActive = true
        barColorPreview.leftAnchor.constraint(equalTo: barColorLabel.rightAnchor, constant: DesignDefaults.padding).isActive = true
        barColorPreview.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        
        barWidthLabel.topAnchor.constraint(equalTo: barColorPreview.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        barWidthLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        barWidthLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        barWidthSlider.topAnchor.constraint(equalTo: barWidthLabel.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        barWidthSlider.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        barWidthSlider.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        barWidthSlider.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        barRoundnessLabel.topAnchor.constraint(equalTo: barWidthSlider.bottomAnchor).isActive = true
        barRoundnessLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        barRoundnessLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        barRoundnessSlider.topAnchor.constraint(equalTo: barRoundnessLabel.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        barRoundnessSlider.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        barRoundnessSlider.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        barRoundnessSlider.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        showValueLabel.topAnchor.constraint(equalTo: barRoundnessSlider.bottomAnchor).isActive = true
        showValueLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        showValueLabel.heightAnchor.constraint(equalTo: styleNameTextField.heightAnchor).isActive = true
        
        showValueToggle.topAnchor.constraint(equalTo: showValueLabel.topAnchor).isActive = true
        showValueToggle.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        showValueToggle.heightAnchor.constraint(equalTo: showValueLabel.heightAnchor).isActive = true
        showValueToggle.widthAnchor.constraint(equalTo: showValueLabel.heightAnchor).isActive = true
        
        barPreview.topAnchor.constraint(equalTo: showValueLabel.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        barPreview.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -DesignDefaults.padding).isActive = true
        barPreview.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        barPreview.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        
        barPreviewLeft.topAnchor.constraint(equalTo: barPreview.topAnchor).isActive = true
        barPreviewLeft.bottomAnchor.constraint(equalTo: barPreview.bottomAnchor).isActive = true
        barPreviewLeft.leftAnchor.constraint(equalTo: barPreview.leftAnchor).isActive = true
        barPreviewLeft.rightAnchor.constraint(equalTo: barPreview.centerXAnchor).isActive = true
        
        barPreviewRight.topAnchor.constraint(equalTo: barPreview.topAnchor).isActive = true
        barPreviewRight.bottomAnchor.constraint(equalTo: barPreview.bottomAnchor).isActive = true
        barPreviewRight.leftAnchor.constraint(equalTo: barPreview.centerXAnchor).isActive = true
        barPreviewRight.rightAnchor.constraint(equalTo: barPreview.rightAnchor).isActive = true
        
        leftBar.centerXAnchor.constraint(equalTo: barPreviewLeft.centerXAnchor).isActive = true
        leftBar.centerYAnchor.constraint(equalTo: barPreviewLeft.bottomAnchor).isActive = true
        leftBar.heightAnchor.constraint(equalTo: barPreviewLeft.heightAnchor, multiplier: 1.5).isActive = true
        leftBarWidthConstraint = leftBar.widthAnchor.constraint(equalTo: barPreviewLeft.widthAnchor, multiplier: 0.5)
        leftBarWidthConstraint?.isActive = true
        
        rightBar.centerXAnchor.constraint(equalTo: barPreviewRight.centerXAnchor).isActive = true
        rightBar.centerYAnchor.constraint(equalTo: barPreviewRight.bottomAnchor).isActive = true
        rightBar.heightAnchor.constraint(equalTo: barPreviewRight.heightAnchor, multiplier: 0.5).isActive = true
        rightBarWidthConstraint = rightBar.widthAnchor.constraint(equalTo: barPreviewRight.widthAnchor, multiplier: 0.5)
        rightBarWidthConstraint?.isActive = true
        
        barPreviewAxis.leftAnchor.constraint(equalTo: barPreview.leftAnchor).isActive = true
        barPreviewAxis.rightAnchor.constraint(equalTo: barPreview.rightAnchor).isActive = true
        barPreviewAxis.bottomAnchor.constraint(equalTo: barPreview.bottomAnchor).isActive = true
        barPreviewAxis.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
    }

}
