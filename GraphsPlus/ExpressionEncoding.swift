//
//  ExpressionEncoding.swift
//  GraphsPlus
//
//  Created by Kimball, Sean A on 11/20/19.
//  Copyright © 2019 Kimball, Sean A. All rights reserved.
//

import Foundation

public class ExpressionEncoding {
    static let variable = "<VAR>"
}

public class EncodedExpression: Codable {
    public var expression = ""
    public var decodeVariable = "VAR"
    
    public var decodedExpression: String {
        get {
            return self.expression.replacingOccurrences(of: ExpressionEncoding.variable, with: self.decodeVariable)
        }
    }
}
