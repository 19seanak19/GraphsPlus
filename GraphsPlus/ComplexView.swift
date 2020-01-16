//
//  ComplexView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class ComplexView: UIView {

    // MARK: - Initializers
    
    public init() {
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func addSubviews() {
        // Implemented by subclasses
    }
    
    internal func constrainSubviews() {
        // Implemented by subclasses
    }
}
