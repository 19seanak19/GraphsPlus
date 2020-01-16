//
//  StyleEditorViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/21/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class StyleEditorViewController: GraphsPlusViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpColorPicker()
        
        styleNameTextField.attributedPlaceholder = NSAttributedString(string: "Add a Style Name", attributes: [NSAttributedString.Key.foregroundColor: DesignDefaults.secondaryText])
        styleNameTextField.delegate = self
        
        bringColorPickerToFront()
        
        cancelButton.addTarget(self, action: #selector(dismissByClosure), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveStyle), for: .touchUpInside)
    }
    
    
    // MARK: - Internal Members
    
    internal func setUpColorPicker() {
        colorPickerShade.isHidden = true
        colorPickerView.isHidden = true
    }
    
    internal func showColorPicker() {
        colorPickerShade.alpha = 0.0
        colorPickerShade.isHidden = false
        
        colorPickerView.alpha = 0.0
        colorPickerView.isHidden = false
        
        UIView.animate(withDuration: DesignDefaults.showInterval, animations: {
            self.colorPickerShade.alpha = 0.6
            self.colorPickerView.alpha = 1.0
        })
    }
    
    internal func hideColorPicker() {
        UIView.animate(withDuration: DesignDefaults.showInterval, animations: {
            self.colorPickerShade.alpha = 0.0
            self.colorPickerView.alpha = 0.0
        }, completion:  { _ in
            self.colorPickerShade.isHidden = true
            self.colorPickerView.isHidden = true
        })
    }
    
    override internal func bringTextFieldsToFront() {
        self.view.bringSubviewToFront(colorPickerShade)
        self.view.bringSubviewToFront(colorPickerView)
        self.view.bringSubviewToFront(keyboardShade)
        self.view.bringSubviewToFront(styleNameTextField)
    }
    
    internal func bringColorPickerToFront() {
        self.view.bringSubviewToFront(colorPickerShade)
        self.view.bringSubviewToFront(colorPickerView)
    }
    
    internal func styleAlreadyExists() -> Bool {
        // Implemented by subclasses
        return false
    }
    
    internal func nameForStyle() -> String {
        // Implemented by subclasses
        return "Style Name"
    }
    
    internal func confirmStyleCanSave() {
        if styleAlreadyExists() {
            let confirmAlert = UIAlertController(title: "\"\(nameForStyle())\" already exists", message: "Overwrite existing style?", preferredStyle: .alert)
            
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            confirmAlert.addAction(cancelAlertAction)
            
            let overwriteAlertAction = UIAlertAction(title: "Overwrite", style: .destructive) { (overwriteAlertAction) in
                self.finalSaveStyle()
            }
            confirmAlert.addAction(overwriteAlertAction)
            
            self.present(confirmAlert, animated: true, completion: nil)
        } else {
            finalSaveStyle()
        }
    }
    
    internal func finalSaveStyle() {
        // Implemented by subclasses
    }
    
    
    // MARK: - @objc Functions
    
    @objc override internal func hideKeyboard() {
        if styleNameTextField.isFirstResponder {
            styleNameTextField.resignFirstResponder()
        }
    }
    
    @objc internal func saveStyle() {
        confirmStyleCanSave()
    }
    
    // MARK: - UI Elements and Constraints
    
    internal let styleNameTextField: UITextField = DesignDefaults.makeTextField()
    
    internal let colorPickerView = ColorPickerView()
    private let colorPickerShade: UIView = DesignDefaults.makeView(withBGColor: UIColor.black, andBorderColor: nil)
    
    internal let divider: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    private let cancelButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2715} Cancel")
    private let saveButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2713} Save")
    
    override internal func addUI() {
        super.addUI()
        
        view.addSubview(styleNameTextField)
        view.addSubview(colorPickerShade)
        view.addSubview(colorPickerView)
        mainContainer.addSubview(divider)
        mainContainer.addSubview(cancelButton)
        mainContainer.addSubview(saveButton)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        colorPickerShade.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        colorPickerShade.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        colorPickerShade.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        colorPickerShade.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        colorPickerView.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: 0.5).isActive = true
        colorPickerView.widthAnchor.constraint(equalTo: mainContainer.widthAnchor).isActive = true
        colorPickerView.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        colorPickerView.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor).isActive = true
        
        styleNameTextField.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: DesignDefaults.padding).isActive = true
        styleNameTextField.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        styleNameTextField.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        styleNameTextField.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        divider.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        divider.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -2.0 * DesignDefaults.padding).isActive = true
        divider.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -DesignDefaults.padding).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: mainContainerLeft.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: mainContainerRight.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
    }

}
