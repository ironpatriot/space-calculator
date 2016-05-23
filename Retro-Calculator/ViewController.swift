//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Cortell Shaw on 5/20/16.
//  Copyright © 2016 TwoFiveDev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
    
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightVarString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("jingles_NES01", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
             try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
             buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
     playSound()
        
     runningNumber += "\(btn.tag)"
    
     outputLbl.text = runningNumber
    
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

 
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }


    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func clearButton(sender: UIButton) {
    
        currentOperation =  Operation.Empty
        rightVarString = " "
        leftValString = " "
        result = " "
        outputLbl.text = "0"
        playSound()
    }
    
    
    func processOperation(op: Operation) {
        playSound()

        if currentOperation != Operation.Empty {
             // Run some math
            
            // user selected an operator but then selected another operator without
            // first entering a number
            if runningNumber != "" {
            
            rightVarString = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
            
                result = "\(Double(leftValString)! * Double(rightVarString)!)"
                
            
            } else if currentOperation == Operation.Divide {
            
                result = "\(Double(leftValString)! / Double(rightVarString)!)"
            
            } else if currentOperation == Operation.Subtract {
            
                result = "\(Double(leftValString)! - Double(rightVarString)!)"
                
            } else if currentOperation == Operation.Add {
            
                result = "\(Double(leftValString)! + Double(rightVarString)!)"
            
            }
                
            
            leftValString = result
            outputLbl.text = result
            
        }
            
            currentOperation = op
            
            
        } else {
            // this is the first time an operation has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        
        }
        
    }
    
    func playSound() {
        if buttonSound.playing {
           buttonSound.stop()
        }
    
        buttonSound.play()
    }
    
    
}

