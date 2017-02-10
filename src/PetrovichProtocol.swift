//
//  PetrovichProtocol.swift
//  Petrovich-demo
//
//  Created by Daniyar Salakhutdinov on 08.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import Foundation

enum Gender: Int {
    case male = 0
    case female
    case androgynous
}

enum Declension: Int {
    case nominative = 0
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

// since there's a bug where we cannot implement required initializer within an extension we should implement it inside the class
protocol DictionarySerializable {
    
    init?(dict: [String : AnyObject])
}

protocol PropertyListSerializable {
    
    init?(withContentsOf plist: String)
}

protocol StringSerializable {
    
    init?(withContentsOf string: String)
}
