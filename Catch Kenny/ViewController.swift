//
//  ViewController.swift
//  Catch Kenny
//
//  Created by Kornet Project on 14/08/2017.
//  Copyright © 2017 Kornet Project. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var kennyArray = [UIImageView]()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check the highscore
        let highscore = UserDefaults.standard.object(forKey: "highscore")
        if highscore == nil {
            highscoreLabel.text = "0"
        }
        if let newscore = highscore as? Int {
            highscoreLabel.text = String(newscore)
        }
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.incScores))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        counter = 30
        timerLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        //creating arrays
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        
        hideKenny()
    }

    func incScores(){
        //This is what happens when recognizers get called
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func countdown(){
        counter -= 1
        timerLabel.text = "\(counter)"
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            //check highscores here
            
            if self.score > Int(highscoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highscoreLabel.text = String(self.score)
            }
            
            //alert creation
            
            let alert = UIAlertController(title: "Time", message: "Your time is up.", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timerLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
                
            })
            alert.addAction(replay)
            
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[randomNumber].isHidden = false
    }

}

