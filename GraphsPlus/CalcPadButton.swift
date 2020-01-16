//
//  CalcPadButton.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/19/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class CalcPadButton: UIButton {

    // MARK: - Public Members
    
    var displayText: String
    var expressionText: String
    
    
    // MARK: - Initializers
    
    init(displayText: String, expressionText: String, title: String) {
        self.displayText = displayText
        self.expressionText = expressionText
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = DesignDefaults.bgDarkGray
        self.layer.borderColor = DesignDefaults.bgMedGray.cgColor
        self.layer.borderWidth = DesignDefaults.borderWidth
        self.layer.cornerRadius = DesignDefaults.cornerRadius
        self.setTitle(title, for: .normal)
        self.setTitleColor(DesignDefaults.primaryText, for: .normal)
        self.setTitleColor(DesignDefaults.primaryTextDisabled, for: .disabled)
        self.setTitleColor(DesignDefaults.primaryTextDisabled, for: .highlighted)
        //let inset = DesignDefaults.buttonInset
        //self.contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
