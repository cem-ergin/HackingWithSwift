//
//  ViewController.swift
//  Milestone Project 7-9 Hangman
//
//  Created by Cem Ergin on 01/07/2022.
//

import UIKit

class ViewController: UIViewController {
    var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myView = UIView()
        myView.backgroundColor = .red
        view = myView
        // Do any additional setup after loading the view.
    }
}

