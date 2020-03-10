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
    @IBOutlet var gamesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        targetTextField.text = "\(targetScore)"
        gamesTextField.text = "\(targetGames)"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func backPressed(_ sender: Any) {
        if targetTextField.text == "" || gamesTextField.text == "" {
            errorLabel.isHidden = false
            errorLabel.text = "Please input all the values."
            return
        }
        let t = Int(targetTextField.text!)!
        let g = Int(gamesTextField.text!)!
        if t < 1 || g < 1{
            errorLabel.isHidden = false
            errorLabel.text = "Please input a larger value."
        } else if t > 999 || g > 999{
            errorLabel.isHidden = false
            errorLabel.text = "Please input a smaller value."
        } else if g%2 == 0 {
            errorLabel.isHidden = false
            errorLabel.text = "Please input an odd number for the number of games."
        } else {
            let defaults = UserDefaults.standard
            defaults.set(targetTextField.text!, forKey: "targetScore")
            defaults.set(gamesTextField.text!, forKey: "targetGames")
            targetScore = t
            targetGames = g
            
            self.performSegue(withIdentifier: "homePressed", sender: self)
        }
    }
}
