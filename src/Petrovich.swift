//
//  Petrovich.swift
//  Petrovich-demo
//
//  Created by Daniyar Salakhutdinov on 08.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import Cocoa

class Petrovich: PetrovichProtocol {
    
    struct Mod {
        
        let letters: Int
        let value: String
        
        func apply(_ value: String) -> String {
            return value
        }
    }
    
    struct Rule {
        
        enum Kind {
            case exception
            case suffixe
        }
        
        let type: Kind
        let gender: Gender
        let tests: [String]
    }
    
    fileprivate let firstnameRules: [Rule]
    fileprivate let middlenameRules: [Rule]
    fileprivate let lastnameRules: [Rule]
    
    init(firstnameRules: [Rule], middlenameRules: [Rule], lastnameRules: [Rule]) {
        self.firstnameRules = firstnameRules
        self.middlenameRules = middlenameRules
        self.lastnameRules = lastnameRules
    }
    
    // MARK: - petrovich protocol methods
    func firstname(_ value: String, gender: Gender, declension: Declension) -> String {
        return value
    }
    
    func middlename(_ value: String, gender: Gender, declension: Declension) -> String {
        return value
    }
    
    func lastname(_ value: String, gender: Gender, declension: Declension) -> String {
        return value
    }
}
