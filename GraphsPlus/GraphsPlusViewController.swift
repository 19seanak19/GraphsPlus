//
//  GraphsPlusViewController.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/19/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import UIKit

class GraphsPlusViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Public Members
    
    public var dismissClosure: (()->Void)?
    
    
    // MARK: - View Lifecycle and Related

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DesignDefaults.bgDarkGray
        
        emptyMainContainer.translatesAutoresizingMaskIntoConstraints = true
        emptyMainContainer.isHidden = true
        presentationCover.isHidden = true
        expandingPresentationCover.translatesAutoresizingMaskIntoConstraints = true
        expandingPresentationCover.isHidden = true
        
        addUI()
        constrainUI()
        
        titleLabel.adjustsFontSizeToFitWidth = true
        
        setUpKeyboard()
        bringTextFieldsToFront()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.bounds.height)
    }
    
    // MARK: - Internal Members
    
    internal func hideTitle() {
        titleHeightConstraint?.isActive = false
        titleHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 0.0)
        titleHeightConstraint?.isActive = true
        titleLabel.text = nil
    }
    
    internal func showTitle() {
        titleLabel.text = _titleText
        titleHeightConstraint?.isActive = false
        titleHeightConstraint = titleLabel.heightAnchor.constraint(equalTo: mainInsetSpacer.heightAnchor, multiplier: 0.1)
        titleHeightConstraint?.isActive = true
    }
    
    private var _titleText = "Title"
    internal func setTitle(to newTitle: String) {
        titleLabel.text = newTitle
        _titleText = newTitle
    }
    
    internal func bringTextFieldsToFront() {
        self.view.bringSubviewToFront(keyboardShade)
    }
    
    internal func presentGraphsPlusVC(_ graphsPlusVC: GraphsPlusViewController) {
        self.view.bringSubviewToFront(emptyMainContainer)
        emptyMainContainer.alpha = 0.0
        emptyMainContainer.isHidden = false
        emptyMainContainer.frame = mainContainer.frame
        graphsPlusVC.view.alpha = 0.0
        UIView.animate(withDuration: DesignDefaults.showHideMainContainer, animations: {
            self.titleLabel.alpha = 0.0
            self.emptyMainContainer.alpha = 1.0
        }, completion: { _ in
            self.mainContainer.isHidden = true
            graphsPlusVC.modalPresentationStyle = .overCurrentContext
            self.present(graphsPlusVC, animated: false, completion: {
                UIView.animate(withDuration: DesignDefaults.transitionMainContainer, animations: {
                    self.emptyMainContainer.frame = graphsPlusVC.mainContainer.frame
                }, completion: { _ in
                    UIView.animate(withDuration: DesignDefaults.showHideMainContainer, animations: {
                        graphsPlusVC.view.alpha = 1.0
                    })
                })
            })
        })
    }
    
    internal func dismissGraphsPlusVC(_ graphsPlusVC: GraphsPlusViewController) {
        UIView.animate(withDuration: DesignDefaults.showHideMainContainer, animations: {
            graphsPlusVC.view.alpha = 0.0
        }, completion: { _ in
            self.dismiss(animated: false, completion: {
                UIView.animate(withDuration: DesignDefaults.transitionMainContainer, animations: {
                    self.emptyMainContainer.frame = self.mainContainer.frame
                }, completion: { _ in
                    self.mainContainer.isHidden = false
                    UIView.animate(withDuration: DesignDefaults.showHideMainContainer, animations: {
                        self.titleLabel.alpha = 1.0
                        self.emptyMainContainer.alpha = 0.0
                    }, completion: { _ in
                        self.emptyMainContainer.isHidden = true
                    })
                })
            })
        })
    }
    
    internal func presentGraphsPlusVCWithExpandingCover(_ graphsPlusVC: GraphsPlusViewController, fromFrame: CGRect, frameCornerRadius: CGFloat?, completion: (()->Void)? = nil) {
        expandingPresentationCover.alpha = 0.0
        expandingPresentationCover.frame = fromFrame
        if let cornerRadius = frameCornerRadius {
            expandingPresentationCover.layer.cornerRadius = cornerRadius
        }
        expandingPresentationCover.isHidden = false
        view.bringSubviewToFront(expandingPresentationCover)
        UIView.animate(withDuration: DesignDefaults.showExpandCover, animations: {
            self.expandingPresentationCover.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: DesignDefaults.expandPresentationCover, animations: {
                self.expandingPresentationCover.frame = self.view.frame
                self.expandingPresentationCover.layer.cornerRadius = 0.0
            }, completion: { _ in
                graphsPlusVC.modalPresentationStyle = .fullScreen
                self.present(graphsPlusVC, animated: true, completion: {
                    completion?()
                })
            })
        })
    }
    
    internal func dismissGraphsPlusVCWithExpandingCover(toFrame: CGRect, frameCornerRadius: CGFloat = 0.0, completion: (()->Void)? = nil) {
        self.dismiss(animated: true, completion: {
            UIView.animate(withDuration: DesignDefaults.expandPresentationCover, animations: {
                self.expandingPresentationCover.frame = toFrame
                self.expandingPresentationCover.layer.cornerRadius = frameCornerRadius
            }, completion: { _ in
                UIView.animate(withDuration: DesignDefaults.showExpandCover, animations: {
                    self.expandingPresentationCover.alpha = 0.0
                }, completion: { _ in
                    self.expandingPresentationCover.isHidden = true
                })
            })
            completion?()
        })
    }
    
    internal func presentGraphsPlusVCWithCover(_ graphsPlusVC: GraphsPlusViewController, completion: (()->Void)? = nil) {
        presentationCover.alpha = 0.0
        presentationCover.isHidden = false
        view.bringSubviewToFront(presentationCover)
        UIView.animate(withDuration: DesignDefaults.showPresentationCover, animations: {
            self.presentationCover.alpha = 1.0
        }, completion: { _ in
            graphsPlusVC.modalPresentationStyle = .fullScreen
            self.present(graphsPlusVC, animated: true, completion: {
                completion?()
            })
        })
    }
    
    internal func dismissGraphsPlusVCWithCover(completion: (()->Void)? = nil) {
        self.dismiss(animated: true, completion: {
            UIView.animate(withDuration: DesignDefaults.showPresentationCover, animations: {
                self.presentationCover.alpha = 0.0
            }, completion: { _ in
                self.presentationCover.isHidden = true
            })
            completion?()
        })
    }
    
    // MARK: - Private Members
    
    private func setUpKeyboard() {
        keyboardShade.isHidden = true
        let dismissKeyboardTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        keyboardShade.addGestureRecognizer(dismissKeyboardTapRecognizer)
        
        let dismissKeyboardSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        dismissKeyboardSwipeRecognizer.direction = .down
        keyboardShade.addGestureRecognizer(dismissKeyboardSwipeRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - @objc Functions
    
    @objc internal func dismissByClosure() {
        if let dismissClosure = dismissClosure {
            dismissClosure()
        }
    }
    
    @objc internal func keyboardWillShow() {
        DesignDefaults.Animation.fadeInKeyboardShade(self.keyboardShade)
    }
    
    @objc internal func keyboardWillHide() {
        DesignDefaults.Animation.fadeOutKeyboardShade(self.keyboardShade)
    }
    
    @objc internal func hideKeyboard() {
        // Implemented by subclasses
    }
    
    
    // MARK: - UITextFieldDelegate Implementation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return false
    }
    
    
    // MARK: - UI Elements and Constraints
    
    private let emptyMainContainer: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgGray, andBorderColor: DesignDefaults.bgMedGray)
    private let presentationCover: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    private let expandingPresentationCover: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgDarkGray, andBorderColor: nil)
    
    internal let mainInsetSpacer = SpacerView()
    
    internal let mainContainer: UIView = DesignDefaults.makeView(withBGColor: DesignDefaults.bgGray, andBorderColor: DesignDefaults.bgMedGray)
    internal let mainContainerLeft = SpacerView()
    internal let mainContainerRight = SpacerView()
    
    private let titleLabel: UILabel = DesignDefaults.makeLabel(withText: "Title")
    private var titleHeightConstraint: NSLayoutConstraint?
    
    internal let keyboardShade: UIView = DesignDefaults.makeView(withBGColor: UIColor.black, andBorderColor: nil)

    internal func addUI() {
        view.addSubview(emptyMainContainer)
        view.addSubview(presentationCover)
        view.addSubview(expandingPresentationCover)
        view.addSubview(mainInsetSpacer)
        view.addSubview(titleLabel)
        view.addSubview(mainContainer)
        mainContainer.addSubview(mainContainerLeft)
        mainContainer.addSubview(mainContainerRight)
        view.addSubview(keyboardShade)
    }
    
    internal func constrainUI() {
        presentationCover.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        presentationCover.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        presentationCover.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        presentationCover.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mainInsetSpacer.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9).isActive = true
        mainInsetSpacer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        mainInsetSpacer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        mainInsetSpacer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: mainInsetSpacer.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainInsetSpacer.leftAnchor, constant: DesignDefaults.padding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainInsetSpacer.rightAnchor, constant: -DesignDefaults.padding).isActive = true
        titleHeightConstraint = titleLabel.heightAnchor.constraint(equalTo: mainInsetSpacer.heightAnchor, multiplier: 0.1)
        titleHeightConstraint?.isActive = true
        
        mainContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: mainInsetSpacer.bottomAnchor).isActive = true
        mainContainer.leftAnchor.constraint(equalTo: mainInsetSpacer.leftAnchor).isActive = true
        mainContainer.rightAnchor.constraint(equalTo: mainInsetSpacer.rightAnchor).isActive = true
        
        mainContainerLeft.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        mainContainerLeft.rightAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        mainContainerLeft.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        mainContainerLeft.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor).isActive = true
        
        mainContainerRight.leftAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        mainContainerRight.rightAnchor.constraint(equalTo: mainContainer.rightAnchor).isActive = true
        mainContainerRight.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        mainContainerRight.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor).isActive = true
        
        keyboardShade.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        keyboardShade.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        keyboardShade.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        keyboardShade.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}
