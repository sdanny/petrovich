//
//  PetrovichProtocol.swift
//  Petrovich-demo
//
//  Created by Daniyar Salakhutdinov on 08.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import Foundation

enum Gender {
    case male
    case female
    case androgynous
}

enum Declension {
    case nominative
    case genitive
    case dative
    case accusative
    case instrumental
    case prepositional
}

protocol PetrovichProtocol {
    
    func firstname(_ value: String, gender: Gender, declension: Declension) -> String
    
    func middlename(_ value: String, gender: Gender, declension: Declension) -> String
    
    func lastname(_ value: String, gender: Gender, declension: Declension) -> String
}
