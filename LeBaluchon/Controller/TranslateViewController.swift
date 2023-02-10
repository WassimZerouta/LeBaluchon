//
//  TranslateViewController.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var querryTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translateResultLabel: UILabel!
    
    var sourceSelected = "fr"
    var targetSelected = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPopUpButtonAction()

    }
    
    func setPopUpButtonAction() {
        sourceButton.menu = UIMenu(children: [
            UIAction(title: "French", state: .on, handler: { action in
                self.sourceSelected = "fr"
            }),
            UIAction(title: "English", handler: { action in
                self.sourceSelected = "en"
            })
            
        ])
        
        sourceButton.showsMenuAsPrimaryAction = true
        sourceButton.changesSelectionAsPrimaryAction = true
        
        targetButton.menu = UIMenu(children: [
            UIAction(title: "French", handler: { action in
                self.targetSelected = "fr"
            }),
            UIAction(title: "English", state: .on, handler: { action in
                self.targetSelected = "en"
            })
            
        ])
        
        targetButton.showsMenuAsPrimaryAction = true
        targetButton.changesSelectionAsPrimaryAction = true
        
        
    }

    @IBAction func translateButtonPressed(_ sender: Any) {
        TranslateAPIHelper.shared.performRequest(q: querryTextField.text ?? "", source: sourceSelected, target: targetSelected) { _, translateValue in
            DispatchQueue.main.async {
               
                self.translateResultLabel.text = translateValue?.trad
                
            }
        }
        
    }
    
}
