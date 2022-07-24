//
//  Person.swift
//  Project 10 - Names to Faces
//
//  Created by Cem Ergin on 07/07/2022.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image:String) {
        self.name = name
        self.image = image
    }
}
