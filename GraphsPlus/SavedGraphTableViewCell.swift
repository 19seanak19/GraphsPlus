//
//  SavedGraphTableViewCell.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class SavedGraphTableViewCell: UITableViewCell {

    // MARK: - Public Members
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = backgroundColor
        
        middleLabel.textColor = DesignDefaults.secondaryText
        
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UITableViewCell Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = selected ? DesignDefaults.bgDarkGray : initialBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.backgroundColor = highlighted ? DesignDefaults.bgDarkGray : initialBackgroundColor
    }
    
    
    // MARK: - Public Members
    
    public func setInitialBackgroundColor(to color: UIColor) {
        initialBackgroundColor = color
        backgroundColor = color
    }
    
    public func setMiddleLabelText(to labelText: String) {
        middleLabel.text = labelText
    }
    
    
    // MARK: - Private Members
    
    private var initialBackgroundColor: UIColor = DesignDefaults.bgMedGray
    
    private let middleLabel: UILabel = DesignDefaults.makeLabel(withText: "Middle")
    
    
    // MARK: - Internal Members
    
    
    // MARK: - Subviews and Constraints
    
    private func addSubviews() {
        self.addSubview(middleLabel)
    }
    
    private func constrainSubviews() {
        middleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        middleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        middleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        middleLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

}
