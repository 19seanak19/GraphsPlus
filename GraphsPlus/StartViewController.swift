//
//  StartViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/21/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class StartViewController: GraphsPlusViewController {

    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideTitle()
        
        bigTitle.textAlignment = .center
        bigTitle.adjustsFontSizeToFitWidth = true
        bigTitle.baselineAdjustment = .alignCenters
        signatureLabel.textAlignment = .center
        
        newLineGraphButton.addTarget(self, action: #selector(self.startNewLineGraph), for: .touchUpInside)
        loadLineGraphButton.addTarget(self, action: #selector(self.loadLineGraph), for: .touchUpInside)
        newBarGraphButton.addTarget(self, action: #selector(self.startNewBarGraph), for: .touchUpInside)
        loadBarGraphButton.addTarget(self, action: #selector(self.loadBarGraph), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bigTitle.font = UIFont.boldSystemFont(ofSize: bigTitle.bounds.height)
    }
    
    
    // MARK: - @objc Functions
    
    @objc private func startNewLineGraph() {
        let newLineGraphVC = NewLineGraphViewController()
        newLineGraphVC.dismissClosure = {
            self.dismissGraphsPlusVC(newLineGraphVC)
        }
        presentGraphsPlusVC(newLineGraphVC)
    }
    
    @objc private func loadLineGraph() {
        let loadLineGraphVC = LoadLineGraphViewController()
        loadLineGraphVC.dismissClosure = {
            self.dismissGraphsPlusVC(loadLineGraphVC)
        }
        presentGraphsPlusVC(loadLineGraphVC)
    }
    
    @objc private func startNewBarGraph() {
        let newBarGraphVC = NewBarGraphViewController()
        newBarGraphVC.dismissClosure = {
            self.dismissGraphsPlusVC(newBarGraphVC)
        }
        presentGraphsPlusVC(newBarGraphVC)
    }
    
    @objc private func loadBarGraph() {
        let loadBarGraphVC = LoadBarGraphViewController()
        loadBarGraphVC.dismissClosure = {
            self.dismissGraphsPlusVC(loadBarGraphVC)
        }
        presentGraphsPlusVC(loadBarGraphVC)
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let bigTitle = DesignDefaults.makeLabel(withText: "GraphsPlus")
    
    private let newLineGraphButton = DesignDefaults.makeButton(withTitle: "New Line Graph")
    private let loadLineGraphButton = DesignDefaults.makeButton(withTitle: "Load Line Graph")
    
    private let newBarGraphButton = DesignDefaults.makeButton(withTitle: "New Bar Graph")
    private let loadBarGraphButton = DesignDefaults.makeButton(withTitle: "Load Bar Graph")
    
    private let buttonSpacer = SpacerView()
    private let upperButtonSpacer = SpacerView()
    private let lowerButtonSpacer = SpacerView()
    
    private let signatureLabel = DesignDefaults.makeLabel(withText: "An app created by Sean Kimball")
    
    override internal func addUI() {
        super.addUI()
        
        mainContainer.addSubview(bigTitle)
        mainContainer.addSubview(buttonSpacer)
        buttonSpacer.addSubview(upperButtonSpacer)
        buttonSpacer.addSubview(lowerButtonSpacer)
        buttonSpacer.addSubview(newLineGraphButton)
        buttonSpacer.addSubview(loadLineGraphButton)
        buttonSpacer.addSubview(newBarGraphButton)
        buttonSpacer.addSubview(loadBarGraphButton)
        mainContainer.addSubview(signatureLabel)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        bigTitle.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: DesignDefaults.padding).isActive = true
        bigTitle.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        bigTitle.rightAnchor.constraint(equalTo: mainContainer.rightAnchor,constant: -DesignDefaults.padding).isActive = true
        bigTitle.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: 0.3).isActive = true
        
        buttonSpacer.topAnchor.constraint(equalTo: bigTitle.bottomAnchor, constant: DesignDefaults.padding).isActive = true
        buttonSpacer.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        buttonSpacer.rightAnchor.constraint(equalTo: mainContainer.rightAnchor,constant: -DesignDefaults.padding).isActive = true
        buttonSpacer.bottomAnchor.constraint(equalTo: signatureLabel.topAnchor, constant:  -DesignDefaults.padding).isActive = true
        
        upperButtonSpacer.topAnchor.constraint(equalTo: buttonSpacer.topAnchor).isActive = true
        upperButtonSpacer.bottomAnchor.constraint(equalTo: buttonSpacer.centerYAnchor).isActive = true
        upperButtonSpacer.leftAnchor.constraint(equalTo: buttonSpacer.leftAnchor).isActive = true
        upperButtonSpacer.rightAnchor.constraint(equalTo: buttonSpacer.rightAnchor).isActive = true
        
        lowerButtonSpacer.bottomAnchor.constraint(equalTo: buttonSpacer.bottomAnchor).isActive = true
        lowerButtonSpacer.topAnchor.constraint(equalTo: buttonSpacer.centerYAnchor).isActive = true
        lowerButtonSpacer.leftAnchor.constraint(equalTo: buttonSpacer.leftAnchor).isActive = true
        lowerButtonSpacer.rightAnchor.constraint(equalTo: buttonSpacer.rightAnchor).isActive = true
        
        newLineGraphButton.centerXAnchor.constraint(equalTo: buttonSpacer.centerXAnchor).isActive = true
        newLineGraphButton.bottomAnchor.constraint(equalTo: upperButtonSpacer.centerYAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        newLineGraphButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        loadLineGraphButton.centerXAnchor.constraint(equalTo: buttonSpacer.centerXAnchor).isActive = true
        loadLineGraphButton.topAnchor.constraint(equalTo: upperButtonSpacer.centerYAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        loadLineGraphButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        newBarGraphButton.centerXAnchor.constraint(equalTo: buttonSpacer.centerXAnchor).isActive = true
        newBarGraphButton.bottomAnchor.constraint(equalTo: lowerButtonSpacer.centerYAnchor, constant: -0.5 * DesignDefaults.padding).isActive = true
        newBarGraphButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        loadBarGraphButton.centerXAnchor.constraint(equalTo: buttonSpacer.centerXAnchor).isActive = true
        loadBarGraphButton.topAnchor.constraint(equalTo: lowerButtonSpacer.centerYAnchor, constant: 0.5 * DesignDefaults.padding).isActive = true
        loadBarGraphButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        signatureLabel.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        signatureLabel.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        signatureLabel.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        signatureLabel.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: 0.75 * DesignDefaults.buttonHeightMultiplier).isActive = true
    }

}
