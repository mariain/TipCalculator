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
    
    @IBAction func enterTax(_ sender: UITextField) {
        defaults.set(Double(sender.text!), forKey: "tax")
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
