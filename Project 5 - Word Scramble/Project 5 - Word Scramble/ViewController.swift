//
//  ViewController.swift
//  Project 5 - Word Scramble
//
//  Created by Cem Ergin on 20/06/2022.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if(allWords.isEmpty){
            allWords = ["silkworm"]
        }
        
        let userDefaults = UserDefaults.standard
        if let word = userDefaults.object(forKey: "word") as? String {
            startGameWithLocalData(storedTitle: word, storedUsedWords: userDefaults.object(forKey: "guessedWords") as? [String])
        } else {
            startGame()
        }
    }
    
    @objc func startGame(){
        title = allWords.randomElement()
        clearData()
        saveData(word: title!)
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func startGameWithLocalData(storedTitle: String?, storedUsedWords: [String]?){
        title = storedTitle
        usedWords.removeAll(keepingCapacity: true)
        if storedUsedWords != nil {
            usedWords = storedUsedWords!
        }
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated:true)
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        
        if (!isAcceptableLength(word: lowerAnswer)){
            showErrorMessage(title: "Word length is not enough", description:  "Word length need to be greater than 3")
            return
        }
        if (!isReal(word: lowerAnswer)){
            showErrorMessage(title: "Word not recognized", description:  "You can't just make that up, you know")
            return
        }
        if (!isOriginal(word: lowerAnswer)){
            showErrorMessage(title: "Word already used", description:  "Be more original!")
            return
        }
        if (!isPossible(word: lowerAnswer)){
            guard let title = title else {
                self.showErrorMessage(title: "Word not possible", description:  "You can't spell that from given word")
                return
            }
            showErrorMessage(title: "Word not possible", description:  "You can't spell that word from \(title.lowercased())")
            return
        }
        if (!isWordEqualsTitle(word: lowerAnswer)){
            showErrorMessage(title: "Word not possible", description:  "You can't enter the same word as title")
            return
        }
        
        usedWords.insert(answer, at: 0)
        let indexPath = IndexPath(row:0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        saveData(guessedWord: answer)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
        
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location:0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isAcceptableLength(word: String) -> Bool {
        return word.count > 3
    }
    
    func isWordEqualsTitle(word: String) -> Bool {
        guard let title = title else { return false }
        return word != title
    }
    
    func showErrorMessage(title: String, description: String){
        let ac = UIAlertController(title: title, message: description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func saveData(guessedWord: String) {
        let guessedWordsKey = "guessedWords"
        
        let userDefaults = UserDefaults.standard
        if var guessedWords = userDefaults.object(forKey: guessedWordsKey) as? [String] {
            guessedWords.append(guessedWord)
            userDefaults.set(guessedWords, forKey: guessedWordsKey)
        } else {
            userDefaults.set([guessedWord], forKey: guessedWordsKey)
        }
    }
    
    func saveData(word: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(word, forKey: "word")
    }
    
    func clearData () {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "word")
        userDefaults.removeObject(forKey: "guessedWords")
    }
    
}

