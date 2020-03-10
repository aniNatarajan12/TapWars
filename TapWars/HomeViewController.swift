//
//  HomeViewController.swift
//  TapWars
//
//  Created by Anirudh Natarajan on 3/3/20.
//  Copyright © 2020 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

var targetScore = 10
var targetGames = 3
class HomeViewController: UIViewController {
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        
        let defaults = UserDefaults.standard
        if let t = defaults.string(forKey: "targetScore") {
            targetScore = Int(t)!
        }
        if let g = defaults.string(forKey: "targetGames") {
            targetGames = Int(g)!
        }
    }
    
    @IBAction func startPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "startGame", sender: self)
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "settingsPressed", sender: self)
    }
}
