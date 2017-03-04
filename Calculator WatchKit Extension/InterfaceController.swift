//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by Jonathan Tsistinas on 3/1/17.
//  Copyright © 2017 Jonathan Tsistinas. All rights reserved.
//

import WatchKit
import Foundation
import UIKit

class InterfaceController: WKInterfaceController {
    
    var currentValue: String = "0"
    var command:Command?
    var calculationExecuted = false

    @IBOutlet var outputLbl: WKInterfaceLabel!
    
    func numberPressed(value:Int){
        let newValue = "\(value)"
        
        if currentValue == "0" || calculationExecuted {
            calculationExecuted = false
            currentValue = newValue
        } else {
            currentValue += newValue
        }
        
        outputLbl.setText(currentValue)
    }
    
    func setDispayValue(value: Double) {
        
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            currentValue = "\(Int(value))"
        } else {
            currentValue = "\(value)"
        }
        
        outputLbl.setText(currentValue)
    }
    
    func commandTapped(_ type: CommandType) {
        calculationExecuted = false
        if command != nil {
            command!.type = type
        } else {
            command = Command(type: type, leftValue: (currentValue as NSString).doubleValue)
            currentValue = "0"
        }
    }
    
    
    
    @IBAction func onDividePressed(_ sender: Any) {
        commandTapped(.add)
    }
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        commandTapped(.multiply)

    }
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        commandTapped(.subtract)
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        commandTapped(.add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        if command != nil {
            let answer = command!.executeWithNewValue(newValue: (currentValue as NSString).doubleValue)
            setDispayValue(value: answer)
            command = nil
            calculationExecuted = true
        }
    }
    
    @IBAction func onDecimalPressed(_seder: Any) {
        if currentValue.range(of: ".") == nil {
            currentValue += "."
            outputLbl.setText(currentValue)
        }
    }
    
    @IBAction func onPercentTapped(_sender: Any) {
        print("I got tapped. I'll be useful someday :(")
        outputLbl.setText("I got tapped. I'll be useful someday :(")
    }
    
    @IBAction func onClearPressed(_ sender: Any){
        command = nil
        currentValue = "0"
        outputLbl.setText(currentValue)
    }
    
    @IBAction func Zero() {
        numberPressed(value: 0)
        
    }
    
    @IBAction func one() {
        numberPressed(value: 1)
        
    }
    
    @IBAction func two() {
        numberPressed(value: 2)

    }
    
    @IBAction func three() {
        numberPressed(value: 3)

    }
    
    @IBAction func four() {
        numberPressed(value: 4)

    }
    
    @IBAction func five() {
        numberPressed(value: 5)

    }
    
    @IBAction func six() {
        numberPressed(value: 6)

    }
    
    @IBAction func seven() {
        numberPressed(value: 7)

    }
    
    @IBAction func eight() {
        numberPressed(value: 8)

    }
    
    @IBAction func nine() {
        numberPressed(value: 9)

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
