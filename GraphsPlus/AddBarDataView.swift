//
//  AddBarDataView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/13/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class AddBarDataView: AddDataView {

    // MARK: - Public Members
    
    override public func setUIHeight(usingView heightView: UIView) {
        super.setUIHeight(usingView: heightView)
        
        valueTextField.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
    }
    
    override public func clearFields() {
        super.clearFields()
        valueTextField.text = nil
    }
    
    public func getBarDataFromInput() -> BarData? {
        if let value = getValueFromInput(), let name = nameTextField.text {
            let newBarData = BarData()
            newBarData.name = name
            newBarData.value = value
            newBarData.barStyle = styleNameLabel.labelText
            return newBarData
        }
        return nil
    }
    
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Bar Name", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        
        setStyleButton.setTitle("   Set Bar Style   ", for: .normal)
        
        valueTextField.keyboardType = .decimalPad
        valueTextField.attributedPlaceholder = NSAttributedString(string: "Bar Height Value", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        valueTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal Members
    
    override internal func bringTextFieldsToFront() {
        super.bringTextFieldsToFront()
        self.bringSubviewToFront(valueTextField)
    }
    
    override internal func canEnableAddButton() -> Bool {
        return super.canEnableAddButton() && (valueTextField.text != nil)
    }
    
    override internal func checkTextFieldsForCorrectness() {
        checkValueTextFieldForCorrectness()
    }
    
    
    // MARK: - Private Members
    
    private func getValueFromInput() -> Double? {
        if let valueText = valueTextField.text {
            if let value = Double(valueText) {
                return value
            }
        }
        return nil
    }
    
    private func checkValueTextFieldForCorrectness() {
        if valueTextField.isFirstResponder {
            if let valueText = valueTextField.text {
                if valueText.contains(".") {
                    let firstDotIndex = valueText.firstIndex(of: ".")
                    let lastDotIndex = valueText.lastIndex(of: ".")
                    
                    if firstDotIndex != lastDotIndex {
                        valueTextField.text = nil
                    }
                }
            }
        }
    }
    
    
    // MARK: - @objc Functions
    
    
    
    
    // MARK: - Subviews and Constraints
    
    internal let valueTextField: UITextField = DesignDefaults.makeTextField()
    
    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(valueTextField)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        valueTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: DesignDefaults.padding).isActive = true
        valueTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        valueTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        
        styleNameLabel.topAnchor.constraint(equalTo: valueTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
    }
}
