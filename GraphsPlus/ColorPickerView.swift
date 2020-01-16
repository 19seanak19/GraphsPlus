//
//  ColorPickerView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class ColorPickerView: ComplexView {

    // MARK: - Initializers
    
    override public init() {
        super.init()
        
        self.backgroundColor = DesignDefaults.bgMedGray
        self.layer.cornerRadius = DesignDefaults.cornerRadius
        self.layer.borderColor = DesignDefaults.bgGray.cgColor
        self.layer.borderWidth = DesignDefaults.borderWidth
        
        redSlider.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
        
        cancelButton.addTarget(self, action: #selector(self.pickingCanceled), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(self.colorPicked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Members
    
    public var colorPickedClosure: ((UIColor)->Void)?
    
    public func setup(withInitialColor initialCol: UIColor, andExitHandler exitHandler: ((UIColor)->Void)?) {
        if let initialColComponents = initialCol.cgColor.components {
            if initialColComponents.count >= 3 {
                let red = initialColComponents[0]
                let green = initialColComponents[1]
                let blue = initialColComponents[2]
                
                redSlider.value = Float(red)
                greenSlider.value = Float(green)
                blueSlider.value = Float(blue)
                
                initialShownColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                
                chosenColor = initialShownColor
                
                colorPickedClosure = exitHandler
            }
        }
    }
    
    
    // MARK: - Private Members
    
    private var chosenColor: UIColor = UIColor.white {
        didSet {
            colorPreview.backgroundColor = chosenColor
        }
    }
    
    private var initialShownColor: UIColor = .white
    
    
    // MARK: - @objc Functions
    
    @objc private func sliderValueChanged() {
        chosenColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
    }
    
    @objc private func colorPicked() {
        if let colorPickedClosure = colorPickedClosure {
            colorPickedClosure(chosenColor)
        }
    }
    
    @objc private func pickingCanceled() {
        if let colorPickedClosure = colorPickedClosure {
            colorPickedClosure(initialShownColor)
        }
    }
    
    
    // MARK: - Subviews and Constraints
    
    private let leftHalf = SpacerView()
    private let rightHalf = SpacerView()
    
    private let rLabel: UILabel = DesignDefaults.makeLabel(withText: "R")
    private let redSlider: UISlider = DesignDefaults.makeSlider(withColor: DesignDefaults.sliderRed, minVal: 0.0, andMaxVal: 1.0)
    
    private let gLabel: UILabel = DesignDefaults.makeLabel(withText: "G")
    private let greenSlider: UISlider = DesignDefaults.makeSlider(withColor: DesignDefaults.sliderGreen, minVal: 0.0, andMaxVal: 1.0)
    
    private let bLabel: UILabel = DesignDefaults.makeLabel(withText: "B")
    private let blueSlider: UISlider = DesignDefaults.makeSlider(withColor: DesignDefaults.sliderBlue, minVal: 0.0, andMaxVal: 1.0)
    
    private let colorPreview: UIView = DesignDefaults.makeView(withBGColor: UIColor.white, andBorderColor: DesignDefaults.bgDarkGray)
    
    private let cancelButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2715} Cancel")
    private let saveButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2713} Save")
    
    
    
    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(leftHalf)
        self.addSubview(rightHalf)
        self.addSubview(rLabel)
        self.addSubview(redSlider)
        self.addSubview(gLabel)
        self.addSubview(greenSlider)
        self.addSubview(bLabel)
        self.addSubview(blueSlider)
        self.addSubview(colorPreview)
        self.addSubview(cancelButton)
        self.addSubview(saveButton)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        leftHalf.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftHalf.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        leftHalf.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftHalf.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        rightHalf.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        rightHalf.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        rightHalf.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightHalf.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        rLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        rLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: DesignDefaults.padding).isActive = true
        
        redSlider.centerYAnchor.constraint(equalTo: rLabel.centerYAnchor).isActive = true
        redSlider.leftAnchor.constraint(equalTo: rLabel.rightAnchor, constant: DesignDefaults.padding).isActive = true
        redSlider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        
        gLabel.topAnchor.constraint(equalTo: rLabel.bottomAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        gLabel.leftAnchor.constraint(equalTo: rLabel.leftAnchor).isActive = true
        
        greenSlider.centerYAnchor.constraint(equalTo: gLabel.centerYAnchor).isActive = true
        greenSlider.leftAnchor.constraint(equalTo: redSlider.leftAnchor).isActive = true
        greenSlider.rightAnchor.constraint(equalTo: redSlider.rightAnchor).isActive = true
        
        bLabel.topAnchor.constraint(equalTo: gLabel.bottomAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        bLabel.leftAnchor.constraint(equalTo: rLabel.leftAnchor).isActive = true
        
        blueSlider.centerYAnchor.constraint(equalTo: bLabel.centerYAnchor).isActive = true
        blueSlider.leftAnchor.constraint(equalTo: redSlider.leftAnchor).isActive = true
        blueSlider.rightAnchor.constraint(equalTo: redSlider.rightAnchor).isActive = true
        
        colorPreview.topAnchor.constraint(equalTo: bLabel.bottomAnchor, constant: 2.0 * DesignDefaults.padding).isActive = true
        colorPreview.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -DesignDefaults.padding).isActive = true
        colorPreview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: DesignDefaults.padding).isActive = true
        colorPreview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: leftHalf.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier * 2).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: rightHalf.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
    }

}
