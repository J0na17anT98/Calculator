//
//  Command.swift
//  Calculator
//
//  Created by Jonathan Tsistinas on 3/4/17.
//  Copyright © 2017 Jonathan Tsistinas. All rights reserved.
//

import UIKit

enum CommandType {
    case divide
    case multiply
    case subtract
    case add
}

class Command: NSObject {
    var type: CommandType
    var leftValue = Double()
    
    init(type: CommandType, leftValue: Double) {
        self.type = type
        self.leftValue = leftValue
        super.init()
    }
    
    func executeWithNewValue(newValue: Double) -> Double {
        var result = leftValue
        
        switch type {
        case .divide: result /= newValue
        case .multiply: result *= newValue
        case .subtract: result -= newValue
        case .add: result += newValue
        }
        
        return result
    }
}
