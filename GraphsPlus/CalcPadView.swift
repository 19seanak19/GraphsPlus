//
//  CalcPadView.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/19/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

protocol CalcPadViewDelegate: NSObject {
    func simpleButtonTapped(withDisplayText displayText: String, andEncodedText encodedText: String)
    func deleteButtonTapped()
}

class CalcPadView: ComplexView {
    
    // MARK: - Initializers
    
    override public init() {
        super.init()
        
        addButtonTargets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public Members
    
    public weak var delegate: CalcPadViewDelegate?
    
    
    // MARK: - Private Members
    
    private func addButtonTargets() {
        // Simple Buttons (require no rearranging of expression text when adding to overall expression)
        openParenButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        closeParenButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        sevenButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        eightButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        nineButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        divButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        fourButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        fiveButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        sixButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        multButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        oneButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        twoButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        threeButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        zeroButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(simpleButtonTapped(sender:)), for: .touchUpInside)
        
        // Delete button
        undoButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc Functions
    
    @objc func simpleButtonTapped(sender: UIButton) {
        if let calcButton = sender as? CalcPadButton {
            delegate?.simpleButtonTapped(withDisplayText: calcButton.displayText, andEncodedText: calcButton.expressionText)
        }
    }
    
    @objc func deleteButtonTapped() {
        delegate?.deleteButtonTapped()
    }
    
    
    // MARK: - Subviews and Constraints
    
    private let r1 = SpacerView()
    private let r2 = SpacerView()
    private let r3 = SpacerView()
    private let r4 = SpacerView()
    private let r5 = SpacerView()
    
    private let c1 = SpacerView()
    private let c2 = SpacerView()
    private let c3 = SpacerView()
    private let c4 = SpacerView()
    
    private let mathButton: UIButton = DesignDefaults.makeButton(withTitle: "MORE")
    private let openParenButton = CalcPadButton(displayText: "(", expressionText: "(", title: "(")
    private let closeParenButton = CalcPadButton(displayText: ")", expressionText: ")", title: ")")
    private let undoButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{232B}")
    private let sevenButton = CalcPadButton(displayText: "7", expressionText: "7", title: "7")
    private let eightButton = CalcPadButton(displayText: "8", expressionText: "8", title: "8")
    private let nineButton = CalcPadButton(displayText: "9", expressionText: "9", title: "9")
    private let divButton = CalcPadButton(displayText: "/", expressionText: "/", title: "/")
    private let fourButton = CalcPadButton(displayText: "4", expressionText: "4", title: "4")
    private let fiveButton = CalcPadButton(displayText: "5", expressionText: "5", title: "5")
    private let sixButton = CalcPadButton(displayText: "6", expressionText: "6", title: "6")
    private let multButton = CalcPadButton(displayText: "\u{00D7}", expressionText: "*", title: "\u{00D7}")
    private let oneButton = CalcPadButton(displayText: "1", expressionText: "1", title: "1")
    private let twoButton = CalcPadButton(displayText: "2", expressionText: "2", title: "2")
    private let threeButton = CalcPadButton(displayText: "3", expressionText: "3", title: "3")
    private let minusButton = CalcPadButton(displayText: "-", expressionText: "-", title: "-")
    private let zeroButton = CalcPadButton(displayText: "0", expressionText: "0", title: "0")
    private let dotButton = CalcPadButton(displayText: ".", expressionText: ".", title: ".")
    private let negButton = CalcPadButton(displayText: "-", expressionText: "-", title: "(-)")
    private let plusButton = CalcPadButton(displayText: "+", expressionText: "+", title: "+")
    
    override internal func addSubviews() {
        super.addSubviews()
        
        self.addSubview(r1)
        self.addSubview(r2)
        self.addSubview(r3)
        self.addSubview(r4)
        self.addSubview(r5)
        
        self.addSubview(c1)
        self.addSubview(c2)
        self.addSubview(c3)
        self.addSubview(c4)
        
        self.addSubview(mathButton)
        self.addSubview(openParenButton)
        self.addSubview(closeParenButton)
        self.addSubview(undoButton)
        self.addSubview(sevenButton)
        self.addSubview(eightButton)
        self.addSubview(nineButton)
        self.addSubview(divButton)
        self.addSubview(fourButton)
        self.addSubview(fiveButton)
        self.addSubview(sixButton)
        self.addSubview(multButton)
        self.addSubview(oneButton)
        self.addSubview(twoButton)
        self.addSubview(threeButton)
        self.addSubview(minusButton)
        self.addSubview(zeroButton)
        self.addSubview(dotButton)
        self.addSubview(negButton)
        self.addSubview(plusButton)
    }
    
    override internal func constrainSubviews() {
        super.constrainSubviews()
        
        r1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        r1.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        r1.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        r1.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        r2.topAnchor.constraint(equalTo: r1.bottomAnchor).isActive = true
        r2.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        r2.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        r2.heightAnchor.constraint(equalTo: r1.heightAnchor).isActive = true
        
        r3.topAnchor.constraint(equalTo: r2.bottomAnchor).isActive = true
        r3.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        r3.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        r3.heightAnchor.constraint(equalTo: r1.heightAnchor).isActive = true
        
        r4.topAnchor.constraint(equalTo: r3.bottomAnchor).isActive = true
        r4.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        r4.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        r4.heightAnchor.constraint(equalTo: r1.heightAnchor).isActive = true
        
        r5.topAnchor.constraint(equalTo: r4.bottomAnchor).isActive = true
        r5.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        r5.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        r5.heightAnchor.constraint(equalTo: r1.heightAnchor).isActive = true
        
        c1.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        c1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        
        c2.leftAnchor.constraint(equalTo: c1.rightAnchor).isActive = true
        c2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c2.widthAnchor.constraint(equalTo: c1.widthAnchor).isActive = true
        
        c3.leftAnchor.constraint(equalTo: c2.rightAnchor).isActive = true
        c3.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c3.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c3.widthAnchor.constraint(equalTo: c1.widthAnchor).isActive = true
        
        c4.leftAnchor.constraint(equalTo: c3.rightAnchor).isActive = true
        c4.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c4.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        c4.widthAnchor.constraint(equalTo: c1.widthAnchor).isActive = true
        
        mathButton.topAnchor.constraint(equalTo: r1.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        mathButton.bottomAnchor.constraint(equalTo: r1.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        mathButton.leftAnchor.constraint(equalTo: c1.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        mathButton.rightAnchor.constraint(equalTo: c1.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        openParenButton.topAnchor.constraint(equalTo: r1.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        openParenButton.bottomAnchor.constraint(equalTo: r1.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        openParenButton.leftAnchor.constraint(equalTo: c2.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        openParenButton.rightAnchor.constraint(equalTo: c2.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        closeParenButton.topAnchor.constraint(equalTo: r1.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        closeParenButton.bottomAnchor.constraint(equalTo: r1.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        closeParenButton.leftAnchor.constraint(equalTo: c3.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        closeParenButton.rightAnchor.constraint(equalTo: c3.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        undoButton.topAnchor.constraint(equalTo: r1.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        undoButton.bottomAnchor.constraint(equalTo: r1.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        undoButton.leftAnchor.constraint(equalTo: c4.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        undoButton.rightAnchor.constraint(equalTo: c4.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        sevenButton.topAnchor.constraint(equalTo: r2.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        sevenButton.bottomAnchor.constraint(equalTo: r2.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        sevenButton.leftAnchor.constraint(equalTo: c1.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        sevenButton.rightAnchor.constraint(equalTo: c1.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        eightButton.topAnchor.constraint(equalTo: r2.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        eightButton.bottomAnchor.constraint(equalTo: r2.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        eightButton.leftAnchor.constraint(equalTo: c2.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        eightButton.rightAnchor.constraint(equalTo: c2.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        nineButton.topAnchor.constraint(equalTo: r2.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        nineButton.bottomAnchor.constraint(equalTo: r2.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        nineButton.leftAnchor.constraint(equalTo: c3.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        nineButton.rightAnchor.constraint(equalTo: c3.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        divButton.topAnchor.constraint(equalTo: r2.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        divButton.bottomAnchor.constraint(equalTo: r2.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        divButton.leftAnchor.constraint(equalTo: c4.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        divButton.rightAnchor.constraint(equalTo: c4.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        fourButton.topAnchor.constraint(equalTo: r3.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        fourButton.bottomAnchor.constraint(equalTo: r3.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        fourButton.leftAnchor.constraint(equalTo: c1.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        fourButton.rightAnchor.constraint(equalTo: c1.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        fiveButton.topAnchor.constraint(equalTo: r3.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        fiveButton.bottomAnchor.constraint(equalTo: r3.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        fiveButton.leftAnchor.constraint(equalTo: c2.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        fiveButton.rightAnchor.constraint(equalTo: c2.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        sixButton.topAnchor.constraint(equalTo: r3.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        sixButton.bottomAnchor.constraint(equalTo: r3.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        sixButton.leftAnchor.constraint(equalTo: c3.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        sixButton.rightAnchor.constraint(equalTo: c3.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        multButton.topAnchor.constraint(equalTo: r3.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        multButton.bottomAnchor.constraint(equalTo: r3.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        multButton.leftAnchor.constraint(equalTo: c4.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        multButton.rightAnchor.constraint(equalTo: c4.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        oneButton.topAnchor.constraint(equalTo: r4.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        oneButton.bottomAnchor.constraint(equalTo: r4.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        oneButton.leftAnchor.constraint(equalTo: c1.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        oneButton.rightAnchor.constraint(equalTo: c1.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        twoButton.topAnchor.constraint(equalTo: r4.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        twoButton.bottomAnchor.constraint(equalTo: r4.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        twoButton.leftAnchor.constraint(equalTo: c2.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        twoButton.rightAnchor.constraint(equalTo: c2.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        threeButton.topAnchor.constraint(equalTo: r4.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        threeButton.bottomAnchor.constraint(equalTo: r4.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        threeButton.leftAnchor.constraint(equalTo: c3.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        threeButton.rightAnchor.constraint(equalTo: c3.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        minusButton.topAnchor.constraint(equalTo: r4.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: r4.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        minusButton.leftAnchor.constraint(equalTo: c4.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        minusButton.rightAnchor.constraint(equalTo: c4.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        zeroButton.topAnchor.constraint(equalTo: r5.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        zeroButton.bottomAnchor.constraint(equalTo: r5.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        zeroButton.leftAnchor.constraint(equalTo: c1.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        zeroButton.rightAnchor.constraint(equalTo: c1.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        dotButton.topAnchor.constraint(equalTo: r5.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        dotButton.bottomAnchor.constraint(equalTo: r5.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        dotButton.leftAnchor.constraint(equalTo: c2.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        dotButton.rightAnchor.constraint(equalTo: c2.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        negButton.topAnchor.constraint(equalTo: r5.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        negButton.bottomAnchor.constraint(equalTo: r5.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        negButton.leftAnchor.constraint(equalTo: c3.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        negButton.rightAnchor.constraint(equalTo: c3.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        
        plusButton.topAnchor.constraint(equalTo: r5.topAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: r5.bottomAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        plusButton.leftAnchor.constraint(equalTo: c4.leftAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        plusButton.rightAnchor.constraint(equalTo: c4.rightAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
    }
}
