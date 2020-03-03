//
//  SettingsViewController.swift
//  TapWars
//
//  Created by Anirudh Natarajan on 3/3/20.
//  Copyright © 2020 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var targetTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        targetTextField.text = "\(targetScore)"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func backPressed(_ sender: Any) {
        if targetTextField.text == "" {
            errorLabel.isHidden = false
            errorLabel.text = "Please input a value."
            return
        }
        let t = Int(targetTextField.text!)!
        if t < 1 {
            errorLabel.isHidden = false
            errorLabel.text = "Please input a larger value."
        } else if t > 999 {
            errorLabel.isHidden = false
            errorLabel.text = "Please input a smaller value."
        } else {
            let defaults = UserDefaults.standard
            defaults.set(targetTextField.text!, forKey: "targetScore")
            targetScore = t
            
            self.performSegue(withIdentifier: "homePressed", sender: self)
        }
    }
}
