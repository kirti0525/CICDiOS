//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Kirti Kalra on 14/08/20.
//  Copyright © 2020 Kirti Kalra. All rights reserved.
//

import UIKit
import AppCenterCrashes
import AppCenterAnalytics

class ViewController: UIViewController {
    
    @IBOutlet weak var monthlyInvestmentTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var retirementAgeTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var savingsTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if MSCrashes.hasCrashedInLastSession() {
            let alert = UIAlertController(title: "Oops", message: "Sorry about that, an error occured", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "It's a cool", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        MSAnalytics.trackEvent("navigated_to_calculator")
    }
    
    
    @IBAction func calculateButton_TouchUpInside(_ sender: UIButton) {
       // MSCrashes.generateTestCrash()
        let current_Age: Int? = Int(ageTextField.text!)
        let planned_Retirement_Age: Int? = Int(retirementAgeTextField.text!)
        
        let properties = ["current_Age": String(current_Age!),
                          "planned_Retirement_Age": String(planned_Retirement_Age!)]
        MSAnalytics.trackEvent("calculate_retirement_amount", withProperties: properties)
    }
    

}

