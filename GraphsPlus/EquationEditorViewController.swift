//
//  ViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/18/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class EquationEditorViewController: GraphsPlusViewController, CalcPadViewDelegate {
    
    // MARK: - Public Members
    
    public var equationExpression: EncodedExpression?
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideTitle()
        
        calcPadView.delegate = self
        
        varButton.addTarget(self, action: #selector(self.addVar), for: .touchUpInside)
        
        cancelButton.addTarget(self, action: #selector(self.dismissByClosure), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(self.saveEquation), for: .touchUpInside)
    }
    
    // MARK: - Private Members
    private var addedDisplayExpressionTokens: [String] = [] {
        didSet {
            equationPreview.labelText = displayExpressionFromAddedTokens()
        }
    }
    private var addedEncodedExpressionTokens: [String] = []
    
    private func displayExpressionFromAddedTokens() -> String {
        var displayExpression = ""
        for token in addedDisplayExpressionTokens {
            displayExpression += token
        }
        return displayExpression
    }
    
    private func encodedExpressionFromAddedTokens() -> String {
        var encodedExpression = ""
        for token in addedEncodedExpressionTokens {
            encodedExpression += token
        }
        return encodedExpression
    }
    
    
    // MARK: - @objc Functions
    
    @objc private func addVar() {
        addedEncodedExpressionTokens.append(ExpressionEncoding.variable)
        addedDisplayExpressionTokens.append(variablePreview.labelText)
    }
    
    @objc private func saveEquation() {
        equationExpression = EncodedExpression()
        equationExpression?.decodeVariable = variablePreview.labelText
        equationExpression?.expression = encodedExpressionFromAddedTokens()
        
        dismissByClosure()
    }
    
    // MARK: - CalcPadViewDelegate Implementation
    
    func simpleButtonTapped(withDisplayText displayText: String, andEncodedText encodedText: String) {
        addedDisplayExpressionTokens.append(displayText)
        addedEncodedExpressionTokens.append(encodedText)
    }
    
    func deleteButtonTapped() {
        addedDisplayExpressionTokens.removeLast()
        addedEncodedExpressionTokens.removeLast()
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let equationPreview = LabelContainerView(labelText: "Equation Preview")
    
    private let variableLabel: UILabel = DesignDefaults.makeLabel(withText: "Variable Label:")
    private let variablePreview = LabelContainerView(labelText: "VAR")
    private let varButton: UIButton = DesignDefaults.makeButton(withTitle: "VAR")
    
    private let calcPadView = CalcPadView()
    
    private let cancelButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2715} Cancel")
    private let saveButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2713} Save")
    
    override internal func addUI() {
        super.addUI()
        
        mainContainer.addSubview(equationPreview)
        mainContainer.addSubview(variableLabel)
        mainContainer.addSubview(variablePreview)
        mainContainer.addSubview(varButton)
        mainContainer.addSubview(calcPadView)
        mainContainer.addSubview(cancelButton)
        mainContainer.addSubview(saveButton)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        equationPreview.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: DesignDefaults.padding).isActive = true
        equationPreview.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        equationPreview.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        equationPreview.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        variableLabel.topAnchor.constraint(equalTo: equationPreview.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        variableLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        variableLabel.heightAnchor.constraint(equalTo: equationPreview.heightAnchor).isActive = true
        
        variablePreview.topAnchor.constraint(equalTo: variableLabel.topAnchor).isActive = true
        variablePreview.leftAnchor.constraint(equalTo: variableLabel.rightAnchor, constant: DesignDefaults.padding).isActive = true
        variablePreview.rightAnchor.constraint(equalTo: varButton.leftAnchor, constant: -DesignDefaults.padding).isActive = true
        variablePreview.heightAnchor.constraint(equalTo: variableLabel.heightAnchor).isActive = true
        
        varButton.topAnchor.constraint(equalTo: variableLabel.topAnchor).isActive = true
        varButton.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        varButton.heightAnchor.constraint(equalTo: equationPreview.heightAnchor).isActive = true
        
        calcPadView.topAnchor.constraint(equalTo: variableLabel.bottomAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        calcPadView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        calcPadView.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        calcPadView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: mainContainerLeft.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: equationPreview.heightAnchor).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: mainContainerRight.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalTo: equationPreview.heightAnchor).isActive = true
    }

}

