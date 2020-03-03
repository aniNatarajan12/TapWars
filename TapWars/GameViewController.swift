//
//  ViewController.swift
//  TapWars
//
//  Created by Anirudh Natarajan on 3/1/20.
//  Copyright © 2020 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var blurView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var gameDescriptionLabel: UILabel!
    @IBOutlet var goHomeButton: UIButton!
    
    var player1View = UIView()
    var player2View = UIView()
    var player1ScoreLabel = UILabel()
    var player2ScoreLabel = UILabel()
    var midHeight = CGFloat()
    let labelSize = CGFloat(120.0)
    
    var startTime = 3
    var startTimer = Timer()
    var startDate = Date.init()
    
    var taps = 0
    var score = 0
    var playingGame = false
    var reverse = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        midHeight = view.frame.height/2
        setupStart()
    }
    
    func setupStart() {
        player1View = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: midHeight))
        player1View.backgroundColor = UIColor(displayP3Red: 166/255, green: 217/255, blue: 255/255, alpha: 1)
        let tap1 = TouchDownGestureRecognizer(target: self, action: Selector(("player1Tapped")))
        player1View.addGestureRecognizer(tap1)
        
        player2View = UIView(frame: CGRect(x: 0, y: midHeight, width: view.frame.width, height: midHeight))
        player2View.backgroundColor = UIColor(displayP3Red: 255/255, green: 114/255, blue: 114/255, alpha: 1)
        let tap2 = TouchDownGestureRecognizer(target: self, action: Selector(("player2Tapped")))
        player2View.addGestureRecognizer(tap2)
        
        view.addSubview(player1View)
        view.addSubview(player2View)
        
        player1ScoreLabel = UILabel(frame: CGRect(x: view.frame.width/2-labelSize/2, y: midHeight-10-labelSize, width: labelSize, height: labelSize))
        player1ScoreLabel.font = .systemFont(ofSize: 80, weight: .semibold)
        player1ScoreLabel.textColor = UIColor(displayP3Red: 53/255, green: 65/255, blue: 163/255, alpha: 1.0)
        player1ScoreLabel.text = "Begin"
        player1ScoreLabel.textAlignment = .center
        player1ScoreLabel.adjustsFontSizeToFitWidth = true
        player1ScoreLabel.transform = CGAffineTransform(rotationAngle: .pi)
        
        player2ScoreLabel = UILabel(frame: CGRect(x: view.frame.width/2-labelSize/2, y: midHeight+10, width: labelSize, height: labelSize))
        player2ScoreLabel.font = .systemFont(ofSize: 80, weight: .semibold)
        player2ScoreLabel.textColor = UIColor(displayP3Red: 149/255, green: 35/255, blue: 31/255, alpha: 1.0)
        player2ScoreLabel.text = "Begin"
        player2ScoreLabel.adjustsFontSizeToFitWidth = true
        player2ScoreLabel.textAlignment = .center
        
        view.addSubview(player1ScoreLabel)
        view.addSubview(player2ScoreLabel)
        
        view.bringSubviewToFront(blurView)
        view.bringSubviewToFront(contentView)
        view.bringSubviewToFront(startLabel)
        blurView.isHidden = true
        contentView.isHidden = true
        startLabel.isHidden = false
        
        
        startLabel.text = "\(startTime)"
        startLabel.transform = CGAffineTransform(rotationAngle: .pi/2)
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startLabel.layer.cornerRadius = startLabel.frame.width/2
        startLabel.clipsToBounds = true
    }
    
    @objc func updateTimer() {
        startTime -= 1
        startLabel.text = "\(startTime)"
        if startTime == 0 {
            startTimer.invalidate()
            playingGame = true
            startLabel.isHidden = true
        }
    }
    
    @objc func player1Tapped() {
        tapped(change: 1)
    }
    
    @objc func player2Tapped() {
        tapped(change: -1)
    }
    
    func tapped(change: Int) {
        if playingGame {
            taps += 1
            score += change
            updateUI()
            checkWin()
        }
    }
    
    func updateUI() {
        let offset = CGFloat(score) * midHeight/CGFloat(targetScore+1)
        player1View.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: midHeight+offset)
        player2View.frame = CGRect(x: 0, y: midHeight+offset, width: view.frame.width, height: midHeight-offset)
        
        if score == 0 {
            player2ScoreLabel.isHidden = false
            player1ScoreLabel.isHidden = false
            player1ScoreLabel.frame = CGRect(x: view.frame.width/2-labelSize/2, y: midHeight-10-labelSize, width: labelSize, height: labelSize)
            player1ScoreLabel.text = "0"
            player2ScoreLabel.frame = CGRect(x: view.frame.width/2-labelSize/2, y: midHeight+10, width: labelSize, height: labelSize)
            player2ScoreLabel.text = "0"
        } else if score < 0 {
            player1ScoreLabel.isHidden = true
            player2ScoreLabel.isHidden = false
            player2ScoreLabel.text = "\(abs(score))"
            player2ScoreLabel.frame = CGRect(x: view.frame.width/2-labelSize/2, y: midHeight+10+offset, width: labelSize, height: labelSize)
        } else {
            player1ScoreLabel.isHidden = false
            player2ScoreLabel.isHidden = true
            player1ScoreLabel.text = "\(abs(score))"
            player1ScoreLabel.frame = CGRect(x: view.frame.width/2-labelSize/2, y: midHeight-10-labelSize+offset, width: labelSize, height: labelSize)
        }
    }
    
    func checkWin() {
        if abs(score)==targetScore {
            playingGame = false
            if score < 0 {
                winnerLabel.text = "Red Team Wins!"
                winnerLabel.textColor = player2ScoreLabel.textColor
                gameDescriptionLabel.textColor = player2ScoreLabel.textColor
                goHomeButton.titleLabel?.textColor = player2ScoreLabel.textColor
                contentView.transform = CGAffineTransform(rotationAngle: 0)
                contentView.backgroundColor = player2View.backgroundColor
                reverse = false
                showPopup()
            } else {
                winnerLabel.text = "Blue Team Wins!"
                winnerLabel.textColor = player1ScoreLabel.textColor
                gameDescriptionLabel.textColor = player1ScoreLabel.textColor
                goHomeButton.titleLabel?.textColor = player1ScoreLabel.textColor
                contentView.transform = CGAffineTransform(rotationAngle: .pi)
                contentView.backgroundColor = player1View.backgroundColor
                reverse = true
                showPopup()
            }
        }
    }
    
    func showPopup() {
        blurView.alpha = 0
        contentView.center = CGPoint(x: self.view.center.x, y: reverse ? 0 - self.contentView.frame.height:self.view.frame.height + self.contentView.frame.height)
        
        blurView.isHidden = false
        contentView.isHidden = false
        gameDescriptionLabel.text = "This game had \(taps) total taps and took \(Date.init().seconds(from: startDate)) seconds."
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blurView.alpha = 0.66
        })
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 9, options: UIView.AnimationOptions(rawValue: 0), animations: {
            self.contentView.center = self.view.center
        }, completion: { (completed) in
            
        })
    }
    
    func dismissPopup(){
        UIView.animate(withDuration: 0.33, animations: {
            self.blurView.alpha = 0
        }, completion: { (completed) in
            
        })
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
            self.contentView.center = CGPoint(x: self.view.center.x, y: self.reverse ? 0 - self.contentView.frame.height/2:self.view.frame.height + self.contentView.frame.height/2)
        }, completion: { (completed) in
            self.blurView.isHidden = true
            self.contentView.isHidden = true
            self.performSegue(withIdentifier: "goHome", sender: self)
        })
    }

    @IBAction func goHomePressed(_ sender: Any) {
        dismissPopup()
    }
    
}

extension Date {
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}
