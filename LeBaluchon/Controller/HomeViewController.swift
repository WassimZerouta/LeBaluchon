//
//  HomeViewController.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var meteoButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func meteoButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "meteoIdentifier", sender: self)
    }
    
    @IBAction func changeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "changeIdentifier", sender: self)
    }
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "translateIdentifier", sender: self)
    }
    
    
    

    
}
