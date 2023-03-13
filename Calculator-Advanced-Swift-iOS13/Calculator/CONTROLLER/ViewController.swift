//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    //Acsess Levels
    //use to track this will be acsesble only in its own scope
    //it will turn black if you will  try to acsses from external
    private var isFinishedTypingNumber = true
    //whenever you're creating a global variable or something that is class-wide, you should always add the  "private" keyword in front of it, so that it limits the scope of this variable to only the enclosing curly   braces.
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else{
                fatalError("Cnnot cinvert display text to a doouble!")
            }
            return number
        }
        
        set {
            displayLabel.text = String(newValue)
            
        }
        
        
    }
    private var  calculator = CalculationLogic()
    //maade it global veriable
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //refresh
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        //1st ! = definitely sure that there is text inside the displayLabe.text!
        
        //2nd ! =  we're turning it into a double and we're saying that it's always going to worlk, namely whatever  is in here is always going to be able to be turned into a double.
        
        //        guard let number = Double(displayLabel.text!) else{
        //            fatalError("Cnnot cinvert display text to a doouble!")
        //        }
        //What should happen when a non-number button is pressed
        
        //or can be guard let and else fatalError the one that doesnt comlitlly crush but prints message
        
        //next step is to use that number and perform the calculation
        
        //his will be the string that corresponds to whichever of these buttons were pressed.
        if let calcMethod =  sender.currentTitle {
            //            let calculator = CalculationLogic(number: displayValue)
            
            //next call the function
            guard let results =  calculator.calculate(symbol: calcMethod) else {
                fatalError("result is nil")
            }//symbol gets sender.currentTitle
            displayValue = results
        }//that numbers gets resived here as a display value
        
        //                    if calcMethod == "+/-" {
        //                        displayValue *= -1
        //                    } else if calcMethod == "%" {
        //                        displayValue *= 0.01
        //                        //same as * 0.01
        //                        //String(displayValue / 100)
        //                    } else if calcMethod == "AC" {
        //                        displayLabel.text = String(0)
        //                    }
        //                }
        
    }
        @IBAction func numButtonPressed(_ sender: UIButton) {
            
            //What should happen when a number is entered into the keypad
            
            if let numValue =  sender.currentTitle {
                
                if isFinishedTypingNumber {
                    displayLabel.text = numValue
                    isFinishedTypingNumber = false
                    
                } else {
                    if numValue == "." {
                        
                        //                guard let curetDisplayValue = Double(displayLabel.text!) else {
                        //                        fatalError("Cnnot cinvert display text to a doouble!")
                        //                    }
                        let  isInt = floor(displayValue ) == displayValue
                        //it says round down the   currentDisplayValue.  So if it's 8.1, round it down to 8. And that's what the floor method does,   it simply rounds our number down. Now, the other part is comparing whether if the rounded down version of our display value is equal to  the currentDisplayValue.
                        
                        if !isInt {
                            return
                        }
                        
                    }
                    displayLabel.text = displayLabel.text! + numValue
                    
                }
                
            }
            
            
        }
    }
    

