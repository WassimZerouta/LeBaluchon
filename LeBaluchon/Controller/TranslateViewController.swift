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
    @IBOutlet weak var exchangeLanguageImage: UIImageView!
    @IBOutlet weak var translateResultLabel: UILabel!
    
    var sourceSelected = "fr"
    var targetSelected = "en"
    
    var a = "francais"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPopUpButtonAction()
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(exchangeLanguage))
        exchangeLanguageImage.addGestureRecognizer(tapGestureReconizer)
        


    }
    
    // Inverse the target and the source
    @objc func exchangeLanguage() {
        if sourceSelected != targetSelected {
            if sourceSelected == "fr" {
                self.sourceButton.setTitle("English", for: .normal)
                self.targetButton.setTitle("French", for: .normal)
                sourceSelected = "en"
                targetSelected = "fr"
            } else {
                self.targetButton.setTitle("English", for: .normal)
                self.sourceButton.setTitle("French", for: .normal)
                sourceSelected = "fr"
                targetSelected = "en"
            }
        }
        translateResultLabel.text = ""
        querryTextField.text = ""
    }
    
    // Define source and target button menu
    func setPopUpButtonAction() {
        sourceButton.menu = UIMenu(children: [
            UIAction(title: "Fench", state: .on, handler: { action in
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

    // When translateButton is pressed, the ranslation occurs
    @IBAction func translateButtonPressed(_ sender: Any) {
        TranslateAPIHelper.shared.performRequest(q: querryTextField.text ?? "", source: sourceSelected, target: targetSelected) { _, translateValue in
            DispatchQueue.main.async {
               
                self.translateResultLabel.text = translateValue?.trad
                
            }
        }
        
    }
    
}
