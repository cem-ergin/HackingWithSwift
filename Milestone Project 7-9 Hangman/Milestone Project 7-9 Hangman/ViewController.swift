//
//  ViewController.swift
//  Milestone Project 7-9 Hangman
//
//  Created by Cem Ergin on 01/07/2022.
//

import UIKit

class ViewController: UIViewController {
    var allWords = [String]()
    var word: String!
    let letters = "abcdefghijklmnopqrstuvwxyz".uppercased().enumerated()
    
    var letterButtons = [UIButton]()
    var hangmanLabel: UILabel!
    var moveLabel: UILabel!
    var moveLeft = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Hangman")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.reply, target: nil, action: #selector(reply))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        view.addSubview(navBar)
        
        if let wordsUrl = Bundle.main.url(forResource: "words", withExtension: "txt"){
            if let words = try? String(contentsOf: wordsUrl){
                allWords = words.components(separatedBy: "\n")
            }
        }
        initiateWord()
        
        hangmanLabel = UILabel()
        hangmanLabel.translatesAutoresizingMaskIntoConstraints = false
        initiateHangmanLabel()
        hangmanLabel.font = hangmanLabel.font.withSize(50)
        view.addSubview(hangmanLabel)
        
        
        moveLabel = UILabel()
        moveLabel.translatesAutoresizingMaskIntoConstraints = false
        updateMoveLabel()
        view.addSubview(moveLabel)

        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        let rowLength = 5
        let width = Int(view.frame.width) * 1/rowLength
        let height = 60
        var currentColumnIndex = 0
        var currentRowIndex = 0
        
        for letter in letters {
            currentColumnIndex = letter.offset % rowLength
            currentRowIndex = Int(letter.offset / rowLength)

            let letterButton = UIButton(type: .system)
            let letterString = String(letter.element)
            letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            letterButton.setTitle(letterString, for: .normal)
            letterButton.restorationIdentifier = letterString
            letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

            let frame = CGRect(x: currentColumnIndex * width, y: currentRowIndex * height, width: width, height: height)
            letterButton.frame = frame

            buttonsView.addSubview(letterButton)
            letterButtons.append(letterButton)

        }

        
        let guide = view.safeAreaLayoutGuide

        navBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        navBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        navBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        navBar.bottomAnchor.constraint(equalTo: hangmanLabel.topAnchor).isActive = true
        hangmanLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        hangmanLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        moveLabel.topAnchor.constraint(equalTo: hangmanLabel.bottomAnchor).isActive = true
        moveLabel.bottomAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
        moveLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        buttonsView.topAnchor.constraint(equalTo: moveLabel.bottomAnchor).isActive = true
        
        // I can't click buttons If I don't
        // give width and height anchor
        buttonsView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        buttonsView.heightAnchor.constraint(equalToConstant: CGFloat((currentRowIndex + 1) * 60)).isActive = true
    }
    
    @objc func letterTapped(_ sender: UIButton){
        guard let tappedLetter = sender.restorationIdentifier else { return }
        sender.isHidden = true

        
        if(word.firstIndex(of: Character(tappedLetter)) != nil){
            while(word.firstIndex(of: Character(tappedLetter)) != nil){
                if let index = Array(word).firstIndex(of: Character(tappedLetter)) {
                    word = word.replace(myString: word, index, "?")
                    updateHangmanLabel(index: index, letter: tappedLetter)
                    print("word: \(word!)")
                    checkTheGame()
                }
            }
        } else {
            moveLeft -= 1
            updateMoveLabel()
            checkTheGame()
        }
    }
    
    func checkTheGame(){
        if(moveLeft == 0){
            showGameOver()
            return
        }
        for char in word {
            if (char != Character("?")){
                return
            }
        }
        showGameFinished()
        
    }
    
    func showGameOver(){
        let ac = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .default) {
            _ in
            self.reply()
        }
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func showGameFinished(){
        let ac = UIAlertController(title: "Game Finished", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Another one", style: .default) {
            _ in
            self.reply()
        }
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    
    func updateHangmanLabel(index: Int, letter: String){
        guard var hangmanArr = hangmanLabel.text?.components(separatedBy: " ") else { return }
        hangmanArr[index] = letter
        hangmanLabel.text = hangmanArr.joined(separator: " ")
    }
    
    @objc func reply() {
        initiateWord()
        initiateHangmanLabel()
        for button in letterButtons {
            button.isHidden = false
        }
        moveLeft = 7
        updateMoveLabel()
    }
    
    func updateMoveLabel(){
        moveLabel.text = "\(moveLeft) mistake left"
    }
    
    func initiateHangmanLabel() {
        var questionMarks = [String]()
        for _ in 0..<word.count {
            questionMarks.append("?")
        }
        hangmanLabel.text = questionMarks.joined(separator: " ")
    }
    
    func initiateWord() {
        word = allWords.randomElement()?.uppercased()
        print("selected word is: \(word!)")
    }
    
}

extension String {
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
}
