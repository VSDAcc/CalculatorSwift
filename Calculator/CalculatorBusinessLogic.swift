//
//  CalculatorcBusinessLogic.swift
//  Calculator
//
//  Created by warSong on 4/7/17.
//  Copyright © 2017 VLadymyrShorokhov. All rights reserved.
//

import Foundation

class CalculatorBusinessLogic {
    
    private enum Operation {
       case UnaryOperation((Double) -> Double)
       case BinariOperation((Double,Double) -> Double)
       case EqualOperation
       case ClearOperation
       case PercentageOperation
    }
    private struct BinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    private var binaryOperation: BinaryOperationInfo?
    private var accumulator = 0.0
    private var operations: Dictionary<String,Operation> = [
        "+/-" : Operation.UnaryOperation({-$0}),
        "√"   : Operation.UnaryOperation({sqrt($0)}),
        "+"   : Operation.BinariOperation({$0 + $1}),
        "-"   : Operation.BinariOperation({$0 - $1}),
        "x"   : Operation.BinariOperation({$0 * $1}),
        "÷"   : Operation.BinariOperation({$0 / $1}),
        "="   : Operation.EqualOperation,
        "%"   : Operation.PercentageOperation,
        "C"   : Operation.ClearOperation,
    ]

    func setOperand(operand: Double) {
        accumulator = operand
    }
    func perfomOperationWithOperand(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .UnaryOperation(let value): accumulator = value(accumulator)
            case .BinariOperation(let function): executeEqualOperation()
                binaryOperation = BinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .EqualOperation: executeEqualOperation()
            case .PercentageOperation: calculatePercentageForNumber()
            case .ClearOperation: clear()
            }
        }
    }
    var result: Double {
        get {
            return accumulator
        }
    }
    private func executeEqualOperation() {
        if binaryOperation != nil {
            accumulator = binaryOperation!.binaryFunction(binaryOperation!.firstOperand, accumulator)
            binaryOperation = nil
        }
    }
    private func calculatePercentageForNumber() {
       if binaryOperation?.firstOperand == nil {
            accumulator = accumulator / 100
        }else {
            accumulator = (binaryOperation?.firstOperand)! * accumulator / 100
        }
    }
   private func clear() {
        accumulator = 0.0
        binaryOperation = nil
    }
}






