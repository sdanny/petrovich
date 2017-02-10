//
//  PetrovichTests.swift
//  PetrovichTests
//
//  Created by Daniyar Salakhutdinov on 08.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import XCTest
import Nimble
@testable import Petrovich_demo

class PetrovichTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUsesFirstMatch() {
        // create rules
        let dativeCaseFirst = [Declension.dative : Petrovich.Mod(letters: 0, suffix: "у")]
        let first = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix(dativeCaseFirst), gender: .male, tests: ["ич"])
        let dativeCaseSecond = [Declension.dative : Petrovich.Mod(letters: 0, suffix: "")]
        let second = Petrovich.Rule(kind: Petrovich.Rule.Kind.suffix(dativeCaseSecond), gender: .male, tests: ["ич"])
        // check both matches to petrovich
        let value = "Петрович"
        expect(first.matches(with: value, gender: .male, first: true)).to(equal(second.matches(with: value, gender: .male, first: true)))
        // create helper
        let petrovich = Petrovich(firstnameRules: [], middlenameRules: [first, second], lastnameRules: [])
        // check uses first match
        let result = petrovich.middlename(value, gender: .male, declension: .dative)
        expect(result).to(equal("Петровичу"))
    }
}
