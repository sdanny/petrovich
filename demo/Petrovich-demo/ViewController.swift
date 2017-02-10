//
//  ViewController.swift
//  Petrovich-demo
//
//  Created by Daniyar Salakhutdinov on 08.02.17.
//  Copyright © 2017 Runtime LLC. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet fileprivate var inputField:NSTextField!
    @IBOutlet fileprivate var maleRadioButton: NSButton!
    @IBOutlet fileprivate var femaleRadioButton: NSButton!
    @IBOutlet fileprivate var genOutput: NSTextField!
    @IBOutlet fileprivate var datOutput: NSTextField!
    @IBOutlet fileprivate var accOutput: NSTextField!
    @IBOutlet fileprivate var insOutput: NSTextField!
    @IBOutlet fileprivate var preOutput: NSTextField!
    
    let petrovich = Petrovich.shared
    var gender = Gender.male

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        inputField.stringValue = "Иванов Иван Иванович"
        processValue()
    }
    
    // MARK: - actions
    @IBAction func genderRadioButtonDidSelect(_ sender: NSButton) {
        if sender === maleRadioButton {
            gender = .male
        } else {
            gender = .female
        }
    }
    
    @IBAction func goButtonDidSelect(_ sender: NSButton) {
        processValue()
    }
    
    fileprivate func processValue() {
        let components = inputField.stringValue.components(separatedBy: " ")
        guard components.count == 3 else {
            return
        }
        let lastname = components[0]
        let firstname = components[1]
        let middlename = components[2]
        genOutput.stringValue = petrovich.lastname(lastname, gender: gender, declension: .genitive) + " " + petrovich.firstname(firstname, gender: gender, declension: .genitive) + " " + petrovich.middlename(middlename, gender: gender, declension: .genitive)
        datOutput.stringValue = petrovich.lastname(lastname, gender: gender, declension: .dative) + " " + petrovich.firstname(firstname, gender: gender, declension: .dative) + " " + petrovich.middlename(middlename, gender: gender, declension: .dative)
        accOutput.stringValue = petrovich.lastname(lastname, gender: gender, declension: .accusative) + " " + petrovich.firstname(firstname, gender: gender, declension: .accusative) + " " + petrovich.middlename(middlename, gender: gender, declension: .accusative)
        insOutput.stringValue = petrovich.lastname(lastname, gender: gender, declension: .instrumental) + " " + petrovich.firstname(firstname, gender: gender, declension: .instrumental) + " " + petrovich.middlename(middlename, gender: gender, declension: .instrumental)
        preOutput.stringValue = petrovich.lastname(lastname, gender: gender, declension: .prepositional) + " " + petrovich.firstname(firstname, gender: gender, declension: .prepositional) + " " + petrovich.middlename(middlename, gender: gender, declension: .prepositional)
        
    }
}

