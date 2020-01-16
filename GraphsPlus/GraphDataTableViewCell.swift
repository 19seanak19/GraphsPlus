//
//  LineTableViewCell.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/4/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class GraphDataTableViewCell: UITableViewCell {

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = backgroundColor
        self.clipsToBounds = true
        
        leftLabel.textColor = DesignDefaults.secondaryText
        middleLabel.textColor = DesignDefaults.secondaryText
        rightLabel.textColor = DesignDefaults.secondaryText
        
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
    
    public func setLeftLabelText(to labelText: String) {
        leftLabel.text = labelText
    }
    
    public func setMiddleLabelText(to labelText: String) {
        middleLabel.text = labelText
    }
    
    public func setRightLabelText(to labelText: String) {
        rightLabel.text = labelText
    }
    
    
    // MARK: - Private Members
    
    private var initialBackgroundColor: UIColor = DesignDefaults.bgMedGray
    
    private let spacer = SpacerView()
    
    private let leftLabel: UILabel = DesignDefaults.makeLabel(withText: "Left")
    
    private let divider1: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    private let middleLabel: UILabel = DesignDefaults.makeLabel(withText: "Middle")
    
    private let divider2: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    private let rightLabel: UILabel = DesignDefaults.makeLabel(withText: "Right")
    
    
    // MARK: - Internal Members
    
    
    // MARK: - Subviews and Constraints
    
    private func addSubviews() {
        self.addSubview(spacer)
        self.addSubview(leftLabel)
        self.addSubview(divider1)
        self.addSubview(middleLabel)
        self.addSubview(divider2)
        self.addSubview(rightLabel)
    }
    
    private func constrainSubviews() {
        spacer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spacer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        spacer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        spacer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.333333).isActive = true
        
        leftLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        leftLabel.rightAnchor.constraint(equalTo: spacer.leftAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        leftLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        divider1.topAnchor.constraint(equalTo: self.topAnchor, constant: -DesignDefaults.padding).isActive = true
        divider1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        divider1.centerXAnchor.constraint(equalTo: spacer.leftAnchor).isActive = true
        divider1.widthAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        middleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        middleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        middleLabel.leftAnchor.constraint(equalTo: spacer.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        middleLabel.rightAnchor.constraint(equalTo: spacer.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        middleLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        divider2.topAnchor.constraint(equalTo: self.topAnchor, constant: -DesignDefaults.padding).isActive = true
        divider2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        divider2.centerXAnchor.constraint(equalTo: spacer.rightAnchor).isActive = true
        divider2.widthAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        rightLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightLabel.leftAnchor.constraint(equalTo: spacer.rightAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        rightLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        rightLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

}
