//
//  ViewController.swift
//  Milestone Project 7-9 Hangman
//
//  Created by Cem Ergin on 01/07/2022.
//

import UIKit

class ViewController: UIViewController {
    let letters = "abcdefghijklmnopqrstuvwxyz".enumerated()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        let rowLength = 5
        let width = Int(view.frame.width) * 1/rowLength
        let height = 80
        var currentColumnIndex = 0
        var currentRowIndex = 0
        
        for letter in letters {
            currentColumnIndex = letter.offset % rowLength
            currentRowIndex = Int(letter.offset / rowLength)
            
            let letterButton = UIButton(type: .system)
            letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            letterButton.setTitle(String(letter.element), for: .normal)
            letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            
            let frame = CGRect(x: currentColumnIndex * width, y: currentRowIndex * height, width: width, height: height)
            letterButton.frame = frame
            
            buttonsView.addSubview(letterButton)
                
        }
        
        buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10).isActive = true
        
    }
    
    @objc func letterTapped(){
        
    }
}

