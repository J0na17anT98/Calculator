//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Tsistinas on 3/1/17.
//  Copyright © 2017 Jonathan Tsistinas. All rights reserved.
//

import UIKit
import AVFoundation

class CalcVC: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    @IBOutlet weak var outputLbl: UITextField!
    
    var btnSound: AVAudioPlayer!
    
    var command:Command?
    var calculationExecuted = false

    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation:Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath:  path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func numberPressed(value:Int){
        let newValue = "\(value)"
        
        if runningNumber == "0" || calculationExecuted {
            calculationExecuted = false
            runningNumber = newValue
        } else {
            runningNumber += newValue
        }
        
        outputLbl.text = runningNumber
    }
    
    func setDispayValue(value: Double) {
        
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            runningNumber = "\(Int(value))"
        } else {
            runningNumber = "\(value)"
        }
        outputLbl.text = runningNumber
    }
    
    func commandTapped(_ type: CommandType) {
        calculationExecuted = false
        if command != nil {
            command!.type = type
        } else {
            command = Command(type: type, leftValue: (runningNumber as NSString).doubleValue)
            runningNumber = "0"
        }
    }
    
    @IBAction func numberPressed(_ btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(currentOperation)
    }
    
    @IBAction func onDecimalPressed(_seder: Any) {
        if runningNumber.range(of: ".") == nil {
            runningNumber += "."
            outputLbl.text = runningNumber
        }
    }
    
    @IBAction func onPercentPressed(_seder: Any) {
        print("I got pressed. I'll be useful someday :(")
        outputLbl.text = "I got pressed. I'll be useful someday :("
    }
    
    @IBAction func onClearPressed(_ sender: Any){
        reset()
//        runningNumber = "\(0)"
//        leftValString = "\(0)"
//        rightValString = "\(0)"
//        result = "\(0)"
//        outputLbl.text = ""
        
    }
    
    func reset() {
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = ""
    }
    
    func processOperation(_ op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            //this is the first time an operator is pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

