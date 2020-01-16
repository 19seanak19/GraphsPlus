//
//  AddDataView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/5/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

protocol AddDataViewDelegate: NSObject {
    // General
    func addDataSetStylePressed()
    func addDataCancelPressed()
    func addDataAddPressed()
    func addDataHideKeyboard()
    // AddLineDataView
    func addDataSetEquationPressed()
    // AddBarDataView
}

class AddDataView: ComplexView, UITextFieldDelegate {
    
    // MARK: - Public Members
    
    public weak var delegate: AddDataViewDelegate?
    
    public func setUIHeight(usingView heightView: UIView) {
        nameTextField.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        styleNameLabel.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        setStyleButton.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        addButton.heightAnchor.constraint(equalTo: heightView.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
    }
    
    public func clearFields() {
        nameTextField.text = nil
        styleNameLabel.labelText = "Default"
        addButton.isEnabled = false
    }
    
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        self.backgroundColor = DesignDefaults.bgGray
        self.layer.cornerRadius = DesignDefaults.cornerRadius
        self.clipsToBounds = true
        
        styleNameLabel.labelTextColor = DesignDefaults.secondaryText
        
        keyboardShade.isHidden = true
        let dismissKeyboardTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        keyboardShade.addGestureRecognizer(dismissKeyboardTapRecognizer)
        
        let dismissKeyboardSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        dismissKeyboardSwipeRecognizer.direction = .down
        keyboardShade.addGestureRecognizer(dismissKeyboardSwipeRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setStyleButton.addTarget(self, action: #selector(setStyle), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelData), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
        
        addButton.isEnabled = false
        
        nameTextField.delegate = self
        bringTextFieldsToFront()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal Functions
    
    internal func bringTextFieldsToFront() {
        self.bringSubviewToFront(keyboardShade)
        self.bringSubviewToFront(nameTextField)
    }
    
    internal func tryEnableAddButton() {
        if canEnableAddButton() {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }
    }
    
    internal func checkTextFieldsForCorrectness() {
        // Implemented by subclasses
    }
    
    internal func canEnableAddButton() -> Bool {
        return (nameTextField.text != nil) && (nameTextField.text! != "")
    }
    
    // MARK: - @objc Functions
    
    @objc private func setStyle() {
        delegate?.addDataSetStylePressed()
    }
    
    @objc internal func cancelData() {
        delegate?.addDataCancelPressed()
    }
    
    @objc internal func addData() {
        delegate?.addDataAddPressed()
    }
    
    @objc private func keyboardWillShow() {
        DesignDefaults.Animation.fadeInKeyboardShade(self.keyboardShade)
    }
    
    @objc private func keyboardWillHide() {
        checkTextFieldsForCorrectness()
        DesignDefaults.Animation.fadeOutKeyboardShade(self.keyboardShade)
    }
    
    @objc private func hideKeyboard() {
        tryEnableAddButton()
        delegate?.addDataHideKeyboard()
    }
    
    
    // MARK: - UITextFieldDelegate Implementation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return false
    }
    
    
    // MARK: - Subviews and Constraints
    
    private let keyboardShade = DesignDefaults.makeView(withBGColor: .black, andBorderColor: nil)
    
    private let leftSide = SpacerView()
    private let rightSide = SpacerView()
    
    internal let nameTextField: UITextField = DesignDefaults.makeTextField()
    
    internal let styleNameLabel = LabelContainerView(labelText: "Default")
    internal let setStyleButton: UIButton = DesignDefaults.makeButton(withTitle: "Set Style")
    
    internal let divider: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    private let cancelButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2715} Cancel")
    private let addButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2713} Add")
    
    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(keyboardShade)
        self.addSubview(leftSide)
        self.addSubview(rightSide)
        self.addSubview(nameTextField)
        self.addSubview(styleNameLabel)
        self.addSubview(setStyleButton)
        self.addSubview(divider)
        self.addSubview(cancelButton)
        self.addSubview(addButton)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        keyboardShade.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        keyboardShade.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        keyboardShade.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        keyboardShade.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        leftSide.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftSide.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        leftSide.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftSide.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        rightSide.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        rightSide.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        rightSide.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightSide.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: DesignDefaults.padding).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignDefaults.padding).isActive = true
        
        styleNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: DesignDefaults.padding).isActive = true
        styleNameLabel.rightAnchor.constraint(equalTo: setStyleButton.leftAnchor, constant: -DesignDefaults.padding).isActive = true
        
        setStyleButton.topAnchor.constraint(equalTo: styleNameLabel.topAnchor).isActive = true
        setStyleButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        
        divider.topAnchor.constraint(equalTo: styleNameLabel.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        divider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        divider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2.0 * DesignDefaults.padding).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: leftSide.centerXAnchor).isActive = true
        
        addButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        addButton.centerXAnchor.constraint(equalTo: rightSide.centerXAnchor).isActive = true
        
        self.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: DesignDefaults.padding).isActive = true
    }
}
