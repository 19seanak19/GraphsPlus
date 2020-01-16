//
//  CodableColor.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 12/14/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import Foundation
import UIKit

public class CodableColor: Codable {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    var uiColor: UIColor {
        get {
            return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        }
    }
}

extension UIColor {
    var codableColor: CodableColor {
        get {
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            return CodableColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
