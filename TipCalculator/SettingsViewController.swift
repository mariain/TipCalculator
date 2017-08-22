//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Maria on 8/4/17.
//  Copyright © 2017 Maria Notohusodo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    let defaults = UserDefaults.standard

    @IBOutlet weak var taxLabel: UITextField!
    
    @IBOutlet weak var tipDefault: UISegmentedControl!
    @IBOutlet weak var themeDefault: UISegmentedControl!
    @IBAction func enterTax(_ sender: UITextField) {
        defaults.set(Double(sender.text!), forKey: "tax")
        defaults.synchronize()
    }
    
    @IBAction func selectTipDefault(_ sender: UISegmentedControl) {
        defaults.set(tipDefault.selectedSegmentIndex, forKey: "tipIndex")
        defaults.synchronize()
    }
    
    @IBAction func selectTheme(_ sender: UISegmentedControl) {
        defaults.set(themeDefault.selectedSegmentIndex, forKey: "themeIndex")
        defaults.synchronize()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        taxLabel.text = defaults.string(forKey: "tax")
        
        taxLabel.delegate = self
        taxLabel.becomeFirstResponder()
        if ((defaults.integer(forKey: "tipIndex")) != nil) {
            tipDefault.selectedSegmentIndex = defaults.integer(forKey: "tipIndex")
        }
        if ((defaults.integer(forKey: "themeIndex")) != nil) {
            themeDefault.selectedSegmentIndex = defaults.integer(forKey: "themeIndex")
        }
        
    }
}
