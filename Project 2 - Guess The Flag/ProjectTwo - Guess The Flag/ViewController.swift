//
//  ViewController.swift
//  ProjectTwo - Guess The Flag
//
//  Created by Cem Ergin on 16/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("italy")
        countries.append("ireland")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if(sender.tag == correctAnswer){
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        
        if(saveScore(score: score)){
            title = "New Record !!!"
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    @objc func showScore(){
        let ac = UIAlertController(title: "Your score", message: "Your current score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(ac) -> Void in
            print("showScore handler")
        }))
        present(ac, animated: true)
    }
    
    func saveScore(score: Int) -> Bool {
        print("current score: \(score)")
        
        let userDefaults = UserDefaults.standard
        let highestScoreKey = "highest_score"
        
        if let highestScore = userDefaults.object(forKey: highestScoreKey) as? Int {
            print("highest score: \(highestScore)")

            if (score > highestScore) {
                userDefaults.set(score, forKey: highestScoreKey)
                return true
            }
        } else {
            userDefaults.set(score, forKey: highestScoreKey)
        }
        
        return false
    }


}

