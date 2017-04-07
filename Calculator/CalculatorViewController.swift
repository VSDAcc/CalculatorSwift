//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by warSong on 4/6/17.
//  Copyright © 2017 VLadymyrShorokhov. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var calculatorBrain = CalculatorBusinessLogic()
    private var isStillTyping = false
    private var isDotPlace = false

    private var currentInput: Double {
        get {
            return Double(displayLabel.text!)!
        } set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray.last == "0" {
                displayLabel.text = valueArray.first
            }else{
                displayLabel.text = value
            }
            isStillTyping = false
        }
    }
    //MARK:-Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //MARK-Actions
    @IBAction func actionNumberPressed(_ sender: UIButton) {
        let number = sender.currentTitle
        if isStillTyping {
            if (displayLabel.text?.characters.count)! < 20 {
                displayLabel.text = displayLabel.text! + number!
            }
        }else {
            displayLabel.text = number
            isStillTyping = true
        }
    }
    @IBAction func actionEqualityOperationSignPressed(_ sender: UIButton) {
        if isStillTyping {
            calculatorBrain.setOperand(operand: currentInput)
        }
        if let buttonTitle = sender.currentTitle {
            calculatorBrain.perfomOperationWithOperand(symbol: buttonTitle)
        }
        currentInput = calculatorBrain.result
        isStillTyping = false
        isDotPlace = false
    }
    @IBAction func actionDotButtonPressed(_ sender: UIButton) {
        if isStillTyping && !isDotPlace {
            displayLabel.text = displayLabel.text! + "."
            isDotPlace = true
        }else if !isStillTyping && !isDotPlace {
            displayLabel.text = "0."
            isDotPlace = true
        }
    }
}
