//
//  SpacerView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/19/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class SpacerView: UIView {

    init() {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
