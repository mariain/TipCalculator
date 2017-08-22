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
    var tipPercentage: Double = 0.00
    var total = 0.00
    var numPeople: Double = 1.00
    var each: Double = 1.00
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        calculate()
    }
    
    @IBOutlet weak var numberPeople: UITextField!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var perPerson: UILabel!
    
    
    @IBOutlet weak var numDesc: UILabel!
    @IBOutlet weak var billDesc: UILabel!
    @IBOutlet weak var taxDesc: UILabel!
    @IBOutlet weak var tipDesc: UILabel!
    @IBOutlet weak var totalDesc: UILabel!
    @IBOutlet weak var eachDesc: UILabel!
    func calculate() {
        let tipPercentageOptions = [0.10, 0.15, 0.20]
        billField.placeholder = NSLocale.current.currencySymbol
        bill = Double(billField.text!) ?? 0
        tipPercentage = tipPercentageOptions[tipControl.selectedSegmentIndex]
        tip = bill * tipPercentage
        tax = defaults.double(forKey: "tax")
        total = bill * ( 1 + tax / 100 ) + tip
        taxLabel.text = NumberFormatter.localizedString(from: NSNumber.init(value: tax * bill / 100), number: NumberFormatter.Style.currency)
        tipLabel.text = NumberFormatter.localizedString(from: NSNumber.init(value: tip), number: NumberFormatter.Style.currency)
        totalLabel.text = NumberFormatter.localizedString(from: NSNumber.init(value: total), number: NumberFormatter.Style.currency)
        numPeople = Double(numberPeople.text!) ?? 1.00
        
        each = total / numPeople
        perPerson.text = NumberFormatter.localizedString(from: NSNumber.init(value: each), number: NumberFormatter.Style.currency)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipIndex")
        billField.delegate = self
        
        numberPeople.delegate = self
        tipControl.addTarget(self, action: #selector(TipViewController.calculateTip(_:)), for: .valueChanged)
        defaults.addObserver(self, forKeyPath: "tax", options: NSKeyValueObservingOptions.new, context: nil)
        defaults.addObserver(self, forKeyPath: "tipIndex", options: NSKeyValueObservingOptions.new, context: nil)
        defaults.addObserver(self, forKeyPath: "themeIndex", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        billField.becomeFirstResponder()
        switch defaults.integer(forKey: "themeIndex") {
        case 0:
            setTheme(isLight: true)
        case 1:
            setTheme(isLight: false)
        default:
            setTheme(isLight: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipIndex")
        switch defaults.integer(forKey: "themeIndex") {
        case 0:
            setTheme(isLight: true)
        case 1:
            setTheme(isLight: false)
        default:
            setTheme(isLight: true)
        }
        calculate()
    }
    
    func setTheme(isLight: Bool){
        if (isLight) {
            self.view.backgroundColor = UIColor.white
            numberPeople.backgroundColor = .white
            numberPeople.textColor = .black
            billField.backgroundColor = .white
            billField.textColor = .black
            billField.layer.borderColor = UIColor.red.cgColor
            numDesc.textColor = .black
            billDesc.textColor = .black
            taxDesc.textColor = .black
            tipDesc.textColor = .black
            totalDesc.textColor = .black
            eachDesc.textColor = .black
            taxLabel.textColor = .black
            tipLabel.textColor = .black
            totalLabel.textColor = .black
            perPerson.textColor = .black
            tipControl.tintColor = .black
        } else {
            self.view.backgroundColor = .black
            numberPeople.backgroundColor = .black
            numberPeople.textColor = .white
            billField.backgroundColor = .black
            billField.textColor = .white
            numDesc.textColor = .white
            billDesc.textColor = .white
            taxDesc.textColor = .white
            tipDesc.textColor = .white
            totalDesc.textColor = .white
            eachDesc.textColor = .white
            taxLabel.textColor = .white
            tipLabel.textColor = .white
            totalLabel.textColor = .white
            perPerson.textColor = .white
            tipControl.tintColor = .white
        }
        
    }
}
