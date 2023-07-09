//
//  ChangeViewController.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import UIKit

class ChangeViewController: UIViewController {
    
    
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    var rate: Float = 0.0
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromTextFieldUi()
    }
    
    // Save the rate to avoid multiple API call
    func exchangeRate(from: String, to: String) -> Float {
        
        let exchangeRate = Float(to)!  / Float(from)!
        return exchangeRate
    }
    
    // if the rate exist, we use it, else it makes api call to retrieve it.
    @IBAction func changeButtonPressed(_ sender: Any) {
        
        if( rate != 0.0) {
            toLabel.text = String(round(Float(fromTextField.text!)! * rate))
            
        }
        else {
            
            ChangeAPIHelper.shared.performRequest(amount: fromTextField.text!) { _, changeValue in
                DispatchQueue.main.async {
                   
                    self.toLabel.text = String(changeValue!.roundedValue())
                    self.rate = self.exchangeRate(from: self.fromTextField.text!, to: self.toLabel.text!)
                    
                }
            }
            
        }
   
    }
    
    // Use number pad
    func fromTextFieldUi() {
        fromTextField.keyboardType = .numberPad
    }
    

}
