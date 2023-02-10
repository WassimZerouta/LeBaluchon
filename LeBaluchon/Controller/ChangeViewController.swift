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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromTextFieldUi()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeButtonPressed(_ sender: Any) {
        ChangeAPIHelper.shared.performRequest(amount: fromTextField.text!) { _, changeValue in
            DispatchQueue.main.async {
               
                self.toLabel.text = String(changeValue!.roundedValue())
                
            }
        }
    }
    
    func fromTextFieldUi() {
        fromTextField.keyboardType = .numberPad
    }
    

}
