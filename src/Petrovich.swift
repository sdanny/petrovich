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
        let suffix: String
        
        func apply(_ value: String) -> String {
            let index = value.index(value.endIndex, offsetBy: -letters)
            // copy substring without ending characters
            let string = value.substring(to: index)
            // add suffix value
            return string + suffix
        }
    }
    
    struct Rule {
        
        enum Kind {
            case exception(Bool) // bool is for first word flag
            case suffix([Declension : Mod])
        }
        
        let kind: Kind
        let gender: Gender
        let tests: [String]
        
        func matches(with value: String, gender: Gender, first: Bool) -> Bool {
            if gender != self.gender && self.gender != .androgynous {
                return false
            }
            for test in tests {
                switch kind {
                case .exception(let firstWord):
                    if first == firstWord {
                        if value.lowercased() == test {
                            return true
                        }
                    }
                case .suffix(_):
                    if value.lowercased().hasSuffix(test) {
                        return true
                    }
                }
            }
            return false
        }
        
        func apply(_ value: String, declension: Declension) -> String {
            switch kind {
            case .exception(_):
                return value
            case .suffix(let mods):
                if let mod = mods[declension] {
                    return mod.apply(value)
                } else {
                    return value
                }
            }
        }
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
        return process(value, gender: gender, declension: declension, with: firstnameRules)
    }
    
    func middlename(_ value: String, gender: Gender, declension: Declension) -> String {
        return process(value, gender: gender, declension: declension, with: middlenameRules)
    }
    
    func lastname(_ value: String, gender: Gender, declension: Declension) -> String {
        return process(value, gender: gender, declension: declension, with: lastnameRules)
    }
    
    fileprivate func process(_ value: String, gender: Gender, declension: Declension, with rules: [Rule]) -> String {
        let set = CharacterSet(charactersIn: "-")
        let words = value.components(separatedBy: set)
        // iterate through the words
        var result = ""
        for index in 0..<words.count {
            let first = index == 0
            let word = words[index]
            // iterate through the rules
            for rule in rules {
                if rule.matches(with: word, gender: gender, first: first) {
                    result += rule.apply(word, declension: declension) + "-"
                    break
                }
            }
        }
        return result.trimmingCharacters(in: set)
    }
}
