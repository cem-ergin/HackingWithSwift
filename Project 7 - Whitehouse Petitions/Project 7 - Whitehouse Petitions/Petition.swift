//
//  Petition.swift
//  Project 7 - Whitehouse Petitions
//
//  Created by Cem Ergin on 25/06/2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

