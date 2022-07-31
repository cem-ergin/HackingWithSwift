//
//  PictureDetailViewController.swift
//  Milestone Project 10-12 Captionable Pictures
//
//  Created by Cem Ergin on 31/07/2022.
//

import UIKit

class PictureDetailViewController: UIViewController {
    var myTitle: String?
    var myImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myImage = myImage {
            imageView.image = myImage
        }
        if let myTitle = myTitle {
            title = myTitle
        }
    }
}
