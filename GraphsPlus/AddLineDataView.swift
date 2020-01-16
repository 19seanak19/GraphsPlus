//
//  AddLineDataView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/5/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class AddLineDataView: AddDataView {

    // MARK: - Public Members
    
    override public func setUIHeight(usingView heightView: UIView) {
        super.setUIHeight(usingView: heightView)
        
        equationLabel.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        setEquationButton.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
    }
    
    override public func clearFields() {
        super.clearFields()
        equationLabel.labelText = ""
    }
    
    public func getLineDataFromInput() -> LineData? {
        if let name = nameTextField.text, let expression = lineExpression {
            let lineData = LineData()
            lineData.name = name
            lineData.encodedExpression = expression
            lineData.lineStyle = styleNameLabel.labelText
            return lineData
        }
        return nil
    }
    
    public var lineExpression: EncodedExpression? {
        didSet {
            if let lineExpression = self.lineExpression {
                equationLabel.labelText = lineExpression.decodedExpression
            }
            tryEnableAddButton()
        }
    }
    
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Line Name", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        
        equationLabel.labelTextColor = DesignDefaults.secondaryText
        
        setStyleButton.setTitle("   Set Line Style   ", for: .normal)
        setEquationButton.addTarget(self, action: #selector(self.setEquation), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal Members
    
    override internal func canEnableAddButton() -> Bool {
        return super.canEnableAddButton() && (lineExpression != nil)
    }
    
    
    // MARK: - @objc Functions
    
    @objc func setEquation() {
        delegate?.addDataSetEquationPressed()
    }
    
    
    // MARK: - Subviews and Constraints
    
    private let equationLabel = LabelContainerView(labelText: "")
    
    internal let setEquationButton: UIButton = DesignDefaults.makeButton(withTitle: "Set Equation")
    
    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(equationLabel)
        self.addSubview(setEquationButton)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        setEquationButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        setEquationButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        
        equationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: DesignDefaults.padding).isActive = true
        equationLabel.rightAnchor.constraint(equalTo: setEquationButton.leftAnchor, constant: -DesignDefaults.padding).isActive = true
        equationLabel.topAnchor.constraint(equalTo: setEquationButton.topAnchor).isActive = true
        
        styleNameLabel.topAnchor.constraint(equalTo: setEquationButton.bottomAnchor, constant: DesignDefaults.padding).isActive = true
    }
}
