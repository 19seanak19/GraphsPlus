//
//  ToggleBox.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class ToggleBox: ComplexView {

    // MARK: - Initializers
    
    override public init() {
        super.init()
        
        self.backgroundColor = DesignDefaults.bgMedGray
        self.layer.borderColor = DesignDefaults.bgDarkGray.cgColor
        self.layer.borderWidth = DesignDefaults.borderWidth
        self.layer.cornerRadius = DesignDefaults.cornerRadius
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleFill))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Members
    
    public var isToggled: Bool {
        get {
            return !fill.isHidden
        }
        set {
            fill.isHidden = !newValue
        }
    }
    
    
    // MARK: - Private Members
    
    
    // MARK: - @objc Functions
    
    @objc private func toggleFill() {
        fill.isHidden = !fill.isHidden
    }
    
    
    // MARK: - Subviews and Constraints
    
    private let fill: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.primaryText, andBorderColor: nil)

    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(fill)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        fill.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fill.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fill.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        fill.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
    }
    
}
