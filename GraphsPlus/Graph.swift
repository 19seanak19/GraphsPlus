//
//  Graph.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class Graph: UIView {

    // MARK: - Initializers
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Members
    
    public func create() {
        // Implemented by subclasses
    }
}
