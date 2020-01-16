//
//  GraphDisplayViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/19/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

public enum GraphType {
    case lineGraph
    case barGraph
    case none
}

class GraphDisplayViewController: GraphsPlusViewController {
    
    // MARK: - Public Members
    
    public func setGraphView(toType graphType: GraphType) {
        self.graphType = graphType
        
        switch graphType {
        case .lineGraph:
            graphView = LineGraphView()
        case .barGraph:
            graphView = BarGraphView()
        case .none:
            break
        }
    }
    
    
    // MARK: - View Lifecycle and Related
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideTitle()
        
        backButton.addTarget(self, action: #selector(dismissByClosure), for: .touchUpInside)
        saveToDeviceButton.addTarget(self, action: #selector(saveGraphToDevice), for: .touchUpInside)
        shareGraphButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        graphView?.drawGraph()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Private Members
    
    private var graphType: GraphType = .none
    
    private let backButton: UIButton = DesignDefaults.makeButton(withTitle: "\u{2039} Back")
    
    private var graphView: GraphView? {
        willSet {
            if graphView?.superview != nil {
                graphView?.removeFromSuperview()
            }
        }
        didSet {
            if graphView != nil {
                addAndConstrainGraphView()
            }
        }
    }
    
    private func saveGraphAsImage() {
        if let graphView = graphView {
            var graphImage: UIImage?
            
            if #available(iOS 10.0, *) {
                let renderer = UIGraphicsImageRenderer(bounds: graphView.bounds)
                graphImage = renderer.image { rendererContext in
                    graphView.layer.render(in: rendererContext.cgContext)
                }
            } else {
                if let graphicsContext = UIGraphicsGetCurrentContext() {
                    UIGraphicsBeginImageContext(graphView.frame.size)
                    graphView.layer.render(in: graphicsContext)
                    graphImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                }
            }
            
            if let graphImage = graphImage {
                UIImageWriteToSavedPhotosAlbum(graphImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                failedToSaveGraphAsImage(errorMessage: "Unable to create image from graph.")
            }
        } else {
            failedToSaveGraphAsImage(errorMessage: "No graph to save.")
        }
    }
    
    private func failedToSaveGraphAsImage(errorMessage message: String?) {
        let failedAlert = UIAlertController(title: "Error saving graph.", message: message, preferredStyle: .alert)
        failedAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(failedAlert, animated: true)
    }
    
    
    // MARK: - @objc Functions

    @objc func saveGraphToDevice() {
        let saveAlert = UIAlertController(title: "Save graph to Photos?", message: nil, preferredStyle: .alert)
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .default))
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (okAlertAction) in
            self.saveGraphAsImage()
        }))
        present(saveAlert, animated: true)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            failedToSaveGraphAsImage(errorMessage: error.localizedDescription)
        } else {
            let savedAlert = UIAlertController(title: "Graph successfully saved.", message: nil, preferredStyle: .alert)
            savedAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(savedAlert, animated: true)
        }
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let saveToDeviceButton: UIButton = DesignDefaults.makeButton(withTitle: "Save To Device")
    private let shareGraphButton: UIButton = DesignDefaults.makeButton(withTitle: "Share Graph")
    
    private func addAndConstrainGraphView() {
        if let graphView = graphView {
            view.addSubview(graphView)
            graphView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: DesignDefaults.padding).isActive = true
            graphView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
            graphView.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
            graphView.bottomAnchor.constraint(equalTo: saveToDeviceButton.topAnchor, constant: -DesignDefaults.padding).isActive = true
        }
    }
    
    override internal func addUI() {
        super.addUI()
        
        view.addSubview(backButton)
        view.addSubview(saveToDeviceButton)
        view.addSubview(shareGraphButton)
    }
    
    override internal func constrainUI() {
        super.constrainUI()
        
        backButton.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: DesignDefaults.padding).isActive = true
        backButton.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        backButton.heightAnchor.constraint(equalTo: mainContainer.heightAnchor, multiplier: DesignDefaults.buttonHeightMultiplier).isActive = true
        
        saveToDeviceButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        saveToDeviceButton.centerXAnchor.constraint(equalTo: mainContainerLeft.centerXAnchor).isActive = true
        saveToDeviceButton.heightAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
        
        shareGraphButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -DesignDefaults.padding).isActive = true
        shareGraphButton.centerXAnchor.constraint(equalTo: mainContainerRight.centerXAnchor).isActive = true
        shareGraphButton.heightAnchor.constraint(equalTo: backButton.heightAnchor).isActive = true
    }
    
}
