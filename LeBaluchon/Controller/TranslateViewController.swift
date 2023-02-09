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
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPopUpButtonAction()

    }
    
    func setPopUpButtonAction() {
        sourceButton.menu = UIMenu(children: [
            UIAction(title: "French", state: .on, handler: { action in
                print("FR")
            }),
            UIAction(title: "English", handler: { action in
                print("EN")
            })
            
        ])
        
        sourceButton.showsMenuAsPrimaryAction = true
        sourceButton.changesSelectionAsPrimaryAction = true
        
        targetButton.menu = UIMenu(children: [
            UIAction(title: "French", handler: { action in
                print("FR")
            }),
            UIAction(title: "English", state: .on, handler: { action in
                print("EN")
            })
            
        ])
        
        targetButton.showsMenuAsPrimaryAction = true
        targetButton.changesSelectionAsPrimaryAction = true
        
        
    }

    @IBAction func translateButtonPressed(_ sender: Any) {
        
    }
    
}
