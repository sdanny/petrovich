//
//  PetrovichRuleTests.swift
//  Petrovich-demo
//
//  Created by Daniyar Salakhutdinov on 09.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import XCTest
import Nimble
@testable import Petrovich_demo

class PetrovichRuleTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testReturnsFalseWithEmptyTests() {
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix([:]), gender: .male, tests: [String]())
        expect(rule.matches(with: "Петрович", gender: .male, first: false)).to(equal(false))
    }
    
    func testSubmitsOnFirstWordException() {
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.exception(true), gender: .male, tests: ["петрович"])
        expect(rule.matches(with: "Петрович", gender: .male, first: true)).to(equal(true))
    }
    
    func testDoesntSubmitOnFirstException() {
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.exception(true), gender: .male, tests: ["петрович"])
        expect(rule.matches(with: "Петрович", gender: .male, first: false)).to(equal(false))
    }
    
    func testSubmitsOnHasTestSuffix() {
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix([:]), gender: .male, tests: ["ич", "ян"])
        expect(rule.matches(with: "Петрович", gender: .male, first: true)).to(equal(true))
    }
    
    func testDoesntSubmitOnHasntTestSuffix() {
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix([:]), gender: .male, tests: ["ник", "ян"])
        expect(rule.matches(with: "Петрович", gender: .male, first: true)).to(equal(false))
    }
    
    func testSubmitsOnAndrogynousRule() {
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix([:]), gender: .androgynous, tests: ["вич"])
        expect(rule.matches(with: "Петрович", gender: .male, first: true)).to(equal(true))
    }
    
    func testAppliesValueHavingMod() {
        let mod = Petrovich.Mod(letters: 0, suffix: "у")
        let suffs = [Declension.dative : mod]
        let rule = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix(suffs), gender: .male, tests: ["вич"])
        expect(rule.apply("Петрович", declension: .dative)).to(equal("Петровичу"))
    }
}
