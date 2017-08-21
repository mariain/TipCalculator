//
//  ViewController.swift
//  TipCalculator
//
//  Created by Maria on 8/4/17.
//  Copyright © 2017 Maria Notohusodo. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextFieldDelegate {
    let defaults = UserDefaults.standard
    var bill: Double = 0.00
    var tax: Double = 0.00
    var tip: Double = 0.00
    var total = 0.00
    var numPeople: Double = 1.00
    var each: Double = 1.00
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentage = [0.10, 0.15, 0.20]
        bill = Double(billField.text!) ?? 0
        tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        calculate()
    }
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var perPerson: UILabel!
    @IBOutlet weak var numberPeople: UITextField!
    
    func calculate() {
        tax = defaults.double(forKey: "tax")
        total = bill * ( 1 + tax / 100 ) + tip
        taxLabel.text = String(format: "$%.2f", tax * bill / 100)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        numPeople = Double(numberPeople.text!) ?? 1.00
        
        each = total / numPeople
        perPerson.text = String(format: "$%.2f", each)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.delegate = self
        numberPeople.delegate = self
        tipControl.addTarget(self, action: #selector(TipViewController.calculateTip(_:)), for: .valueChanged)
        defaults.addObserver(self, forKeyPath: "tax", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        calculate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
