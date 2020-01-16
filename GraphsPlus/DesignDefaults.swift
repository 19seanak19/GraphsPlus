//
//  DesignDefaults.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/18/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import Foundation
import UIKit

public class DesignDefaults {
    
    // MARK: - Colors
    static let bgGray = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
    static let bgMedGray_High = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.0)
    static let bgMedGray = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.0)
    static let bgDarkGray = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
    
    static let primaryText = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    static let primaryTextDisabled = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let secondaryText = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
    static let secondaryTextDisabled = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
    
    static let sliderRed = UIColor(red: 180.0 / 255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let sliderGreen = UIColor(red: 0.0, green: 180.0 / 255.0, blue: 0.0, alpha: 1.0)
    static let sliderBlue = UIColor(red: 0.0, green: 0.0, blue: 180.0 / 255.0, alpha: 1.0)
    
    static let deleteRed = UIColor(red: 180.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
    
    
    // MARK: - Line Style Defaults
    static let defaultLineColor = UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0)
    static let defaultLineStyleName = "Default"
    static let defaultLineWidth: CGFloat = 1.0
    static let defaultShowEquation = false
    
    
    // MARK: - Bar Style Defaults
    static let defaultBarColor = UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0)
    static let defaultBarStyleName = "Default"
    static let defaultBarRoundness: CGFloat = 0.0
    static let defaultBarWidth: CGFloat = 0.5
    static let defaultShowValue = false
    
    
    // MARK: - Graph Style Defaults
    static let defaultGraphStyleName = "Default"
    static let defaultPrimaryGraphBGColor = DesignDefaults.bgGray
    static let defaultSecondaryGraphBGColor = DesignDefaults.bgMedGray
    static let defaultPrimaryGraphAxisColor = DesignDefaults.secondaryText
    static let defaultSecondaryGraphAxisColor = DesignDefaults.secondaryTextDisabled
    static let defaultDrawSecondaryXAxis = false
    static let defaultDrawSecondaryYAxis = false
    static let defaultShowGraphTitle = true
    static let defaultShowXAxisTitle = true
    static let defaultShowYAxisTitle = true
    
    
    // MARK: - Assorted Constants
    static let borderWidth: CGFloat = 1.0
    static let cornerRadius: CGFloat = 5.0
    static let buttonInset: CGFloat = 4.0
    static let buttonHeightMultiplier: CGFloat = 0.08
    static let padding: CGFloat = 12.0
    
    
    // MARK: - Animation Constants
    static let showInterval: TimeInterval = 0.25
    static let fadeAndScaleInterval: TimeInterval = 0.18
    static let showPresentationCover: TimeInterval = 0.18
    static let showExpandCover: TimeInterval = 0.10
    static let expandPresentationCover: TimeInterval = 0.275
    static let showTitleInterval: TimeInterval = 0.10
    static let showHideMainContainer: TimeInterval = 0.20
    static let transitionMainContainer: TimeInterval = 0.30
    static let colorShiftInterval: TimeInterval = 0.22
    
    public class Animation {
        // Static functions that handle common animations
        static func fadeInKeyboardShade(_ keyboardShade: UIView) {
            keyboardShade.alpha = 0.0
            keyboardShade.isHidden = false
            
            UIView.animate(withDuration: DesignDefaults.showInterval, animations: {
                keyboardShade.alpha = 0.6
            })
        }
        
        static func fadeOutKeyboardShade(_ keyboardShade: UIView) {
            UIView.animate(withDuration: DesignDefaults.showInterval, animations: {
                keyboardShade.alpha = 0.0
            }, completion:  { _ in
                keyboardShade.isHidden = true
            })
        }
        
        static func fadeAndScaleIn(_ view: UIView) {
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            view.isHidden = false
            
            UIView.animate(withDuration: DesignDefaults.fadeAndScaleInterval, animations: {
                view.alpha = 1.0
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                UIView.animate(withDuration: (0.5 * DesignDefaults.fadeAndScaleInterval), animations: {
                    view.transform = CGAffineTransform.identity
                })
            })
        }
        
        static func fadeAndScaleOut(_ view: UIView) {
            UIView.animate(withDuration: (0.5 * DesignDefaults.fadeAndScaleInterval), animations: {
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                UIView.animate(withDuration: DesignDefaults.fadeAndScaleInterval, animations: {
                    view.alpha = 0.0
                    view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }, completion: { _ in
                    view.isHidden = true
                    view.transform = CGAffineTransform.identity
                })
            })
        }
    }
    
    
    // MARK: - Default UI Constructors
    static func makeButton(withTitle title: String) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = DesignDefaults.bgDarkGray
        button.layer.borderColor = DesignDefaults.bgMedGray.cgColor
        button.layer.borderWidth = DesignDefaults.borderWidth
        button.layer.cornerRadius = DesignDefaults.cornerRadius
        button.setTitle("   \(title)   ", for: .normal)
        button.setTitleColor(DesignDefaults.primaryText, for: .normal)
        button.setTitleColor(DesignDefaults.primaryTextDisabled, for: .disabled)
        button.setTitleColor(DesignDefaults.primaryTextDisabled, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.text = text
        label.textColor = DesignDefaults.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeTextField() -> UITextField {
        let textField = UITextField(frame: CGRect.zero)
        textField.backgroundColor = DesignDefaults.bgMedGray
        textField.layer.borderColor = DesignDefaults.bgDarkGray.cgColor
        textField.layer.borderWidth = DesignDefaults.borderWidth
        textField.layer.cornerRadius = DesignDefaults.cornerRadius
        textField.textColor = DesignDefaults.primaryText
        textField.textAlignment = .center
        textField.keyboardAppearance = UIKeyboardAppearance.dark
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    static func makeView(withBGColor bgCol: UIColor, andBorderColor borderCol: UIColor?) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = bgCol
        view.layer.cornerRadius = DesignDefaults.cornerRadius
        if let borderCol = borderCol {
            view.layer.borderColor = borderCol.cgColor
            view.layer.borderWidth = DesignDefaults.borderWidth
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeSlider(withColor sliderCol: UIColor, minVal: Float, andMaxVal maxVal: Float) -> UISlider {
        let slider = UISlider(frame: CGRect.zero)
        slider.minimumValue = minVal
        slider.maximumValue = maxVal
        slider.value = maxVal
        slider.minimumTrackTintColor = sliderCol
        slider.maximumTrackTintColor = DesignDefaults.bgDarkGray
        slider.thumbTintColor = DesignDefaults.secondaryText
        slider.isContinuous = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    static func makeTable(withBGColor bgCol: UIColor, andBorderColor borderCol: UIColor?) -> UITableView {
        let _tableView = UITableView(frame: CGRect.zero)
        _tableView.backgroundColor = bgCol
        _tableView.layer.cornerRadius = DesignDefaults.cornerRadius
        if let borderCol = borderCol {
            _tableView.layer.borderColor = borderCol.cgColor
            _tableView.layer.borderWidth = DesignDefaults.borderWidth
        }
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        return _tableView
    }
}
