//
//  JediModel.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/4/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import Foundation
struct Jedi : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Result]?
}

struct Result : Codable, Equatable{
    let name : String?
    let height : String?
    let mass : String?
    let hair_color : String?
    let skin_color : String?
    let eye_color : String?
    let birth_year : String?
    let gender : String?
    let created : String?
    let isSaved : Bool = false
}

