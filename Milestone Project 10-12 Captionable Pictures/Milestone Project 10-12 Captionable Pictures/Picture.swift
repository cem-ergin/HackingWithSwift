//
//  Picture.swift
//  Milestone Project 10-12 Captionable Pictures
//
//  Created by Cem Ergin on 30/07/2022.
//

import Foundation

class Picture: NSObject, Codable {
    var imageName: String
    var caption: String
    
    init(imageName: String, caption: String?) {
        self.imageName = imageName
        self.caption = caption ?? ""
    }
    
    init(imageName: String) {
        self.imageName = imageName
        self.caption = ""
    }
}
