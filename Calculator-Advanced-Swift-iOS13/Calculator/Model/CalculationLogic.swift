//
//  CalculationLogic.swift
//  Calculator
//
//  Created by Magdalena Samuel on 3/10/23.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation

struct CalculationLogic {
    
    public var number: Double?
    //made it optional with stuct because added private global var and it gets initialized, this number property can be nil. f the user hasn't pressed any of the buttons on the calculator  yet, then it shouldn't really have a number, right?
    //    if let n = number {
    //
    //    }
    
    private var interMediateCalculation: (n1: Double, calcMethod: String)?
    
    
    mutating func setNumber(_ number: Double){ //_external parameter name to be nothing but having internal parameter namen name to be used inside
        self.number = number
        
    }
    // function that allows other classes to set the value of this number property.
    //
    //    init(number: Double) {
    //        self.number = number
    //        //what yo trying to change and from what you trying to get the value from
    //    }
    //now we have a way of passing in a number to calculate.  We have a function that performs the calculation and all we need now is just a way of giving the result   back,
    
    mutating func calculate(symbol: String) -> Double? {
        //if you bring the logic with if lets will crush as the sender is unjnown to this class
        if let n = number { //means that number is not nil, and we can now use it inside our
            if symbol == "+/-" {
                return  n * -1
            } else if symbol == "%" {
                return  n * 0.01
                //same as * 0.01
                //String(displayValue / 100)
            } else if symbol == "AC" {
                return 0
            } else if symbol == "=" {
                return  performTwoNumCalv(n2: n)
            } else {
                //else do the calculation in this func
                interMediateCalculation = (n1: n, calcMethod: symbol)
             }
            }
            return nil
        }
        
        private func performTwoNumCalv(n2: Double) -> Double? {
            //uwrap tuple
            //if performTwoNumCalv  is not nil top into n 1 and grab calcMethod
            if let n1 = interMediateCalculation?.n1,
               let operation = interMediateCalculation?.calcMethod {
                switch operation {
                case "+":
                    return n1 + n2
                case "-":
                    return n1 - n2
                case "×" :
                    return n1 * n2
                case "÷" :
                    return n1 / n2
                default:
                    fatalError("Operation does not match to the cases.")
                }
            }
            
            return nil
        }
    }
    
    

