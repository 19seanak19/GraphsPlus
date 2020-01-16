//
//  LabelContainerView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/19/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class LabelContainerView: UIView {

    // MARK: - Initializers
    
    init(labelText: String) {
        self.labelText = labelText
        self.labelTextColor = DesignDefaults.primaryText
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = DesignDefaults.bgMedGray
        self.layer.borderColor = DesignDefaults.bgDarkGray.cgColor
        self.layer.borderWidth = DesignDefaults.borderWidth
        self.layer.cornerRadius = DesignDefaults.cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.text = labelText
        label.textColor = DesignDefaults.primaryText
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public Members
    
    var labelText: String {
        didSet {
            label.text = self.labelText
        }
    }
    
    var labelTextColor: UIColor {
        didSet {
            label.textColor = self.labelTextColor
        }
    }
    
    
    // MARK: - Subviews and Constraints
    
    private let label: UILabel = {
        let _label = UILabel(frame: CGRect.zero)
        _label.translatesAutoresizingMaskIntoConstraints = false
        return _label
    }()
    
}
