//
//  Petrovich.swift
//  Petrovich-demo
//
//  Created by Daniyar Salakhutdinov on 08.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import Foundation

open class Petrovich: PetrovichProtocol, PropertyListSerializable {
    
    public struct Mod: StringSerializable {
        
        let letters: Int
        let suffix: String
        
        public func apply(_ value: String) -> String {
            let index = value.index(value.endIndex, offsetBy: -letters)
            // copy substring without ending characters
            let string = value.substring(to: index)
            // add suffix value
            return string + suffix
        }
        
        public init(letters: Int, suffix: String) {
            self.letters = letters
            self.suffix = suffix
        }
        
        // MARK: serialization
        init?(withContentsOf string: String) {
            let letters = string.components(separatedBy: "-").count - 1
            let suffix = string.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
            self.letters = letters
            self.suffix = suffix
        }
    }
    
    public struct Rule: DictionarySerializable {
        
        public enum Kind {
            case exception(Bool) // bool is for first word flag
            case suffix([Declension : Mod])
        }
        
        let kind: Kind
        let gender: Gender
        let tests: [String]
        
        public init(kind: Kind, gender: Gender, tests: [String]) {
            self.kind = kind
            self.gender = gender
            self.tests = tests
        }
        
        // MARK: serialization method
        init?(dict: [String : AnyObject]) {
            guard let exception = dict["exception"] as? Bool,
                let genderValue = dict["gender"] as? Int,
                let gender = Gender(rawValue: genderValue),
                let tests = dict["tests"] as? [String] else {
                return nil
            }
            // init kind value
            let kind: Kind
            if exception { // exception
                guard let firstFlag = dict["first_word"] as? Bool else {
                    return nil
                }
                kind = .exception(firstFlag)
            } else { // suffix
                guard let items = dict["suffixes"] as? [String] else {
                    return nil
                }
                var suffixes = [Declension : Mod]()
                // parse
                for index in 0..<items.count {
                    let value = items[index]
                    // there's no item for nominative declension, so first one will be for dative
                    guard let declension = Declension(rawValue: index + 1),
                        let mod = Mod(withContentsOf: value) else {
                            continue
                    }
                    suffixes[declension] = mod
                }
                kind = .suffix(suffixes)
            }
            // set properties
            self.kind = kind
            self.gender = gender
            self.tests = tests
        }
        
        // MARK: process methods
        public func matches(with value: String, gender: Gender, first: Bool) -> Bool {
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
        
        public func apply(_ value: String, declension: Declension) -> String {
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
    
    // MARK: - Petrovich properties
    fileprivate let firstnameRules: [Rule]
    fileprivate let middlenameRules: [Rule]
    fileprivate let lastnameRules: [Rule]
    
    init(firstnameRules: [Rule], middlenameRules: [Rule], lastnameRules: [Rule]) {
        self.firstnameRules = firstnameRules
        self.middlenameRules = middlenameRules
        self.lastnameRules = lastnameRules
    }
    
    // MARK: petrovich protocol methods
    open func firstname(_ value: String, gender: Gender, declension: Declension) -> String {
        return process(value, gender: gender, declension: declension, with: firstnameRules)
    }
    
    open func middlename(_ value: String, gender: Gender, declension: Declension) -> String {
        return process(value, gender: gender, declension: declension, with: middlenameRules)
    }
    
    open func lastname(_ value: String, gender: Gender, declension: Declension) -> String {
        return process(value, gender: gender, declension: declension, with: lastnameRules)
    }
    
    fileprivate func process(_ value: String, gender: Gender, declension: Declension, with rules: [Rule]) -> String {
        let set = CharacterSet(charactersIn: "-")
        let words = value.components(separatedBy: set)
        // iterate through the words
        var string = ""
        for index in 0..<words.count {
            let first = index == 0
            let word = words[index]
            // iterate through the rules
            for rule in rules {
                if rule.matches(with: word, gender: gender, first: first) {
                    string += rule.apply(word, declension: declension) + "-"
                    break
                }
            }
        }
        if string.characters.count > 0 {
            return string.trimmingCharacters(in: set)
        } else {
            return value
        }
    }
    
    // MARK: plist serialization, shared instance
    static let shared = Petrovich(withContentsOf: "Petrovich")!
    
    required convenience public init?(withContentsOf plist: String) {
        guard let path = Bundle.main.path(forResource: plist, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else {
                return nil
        }
        guard let first = dict["firstnames"] as? [AnyObject],
            let middles = dict["middlenames"] as? [AnyObject],
            let lasts = dict["lastnames"] as? [AnyObject] else {
            return nil
        }
        let firstnames = createRules(from: first)
        let middlenames = createRules(from: middles)
        let lastnames = createRules(from: lasts)
        // use
        self.init(firstnameRules: firstnames, middlenameRules: middlenames, lastnameRules: lastnames)
    }
    
}

fileprivate func createRules(from array: [AnyObject]) -> [Petrovich.Rule] {
    var result: [Petrovich.Rule] = []
    // iterate
    for object in array {
        guard let dict = object as? [String : AnyObject],
            let rule = Petrovich.Rule(dict: dict) else {
                continue
        }
        result.append(rule)
    }
    return result
}
