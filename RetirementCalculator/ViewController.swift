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
    
    func calculateRetirementAmount(current_age: Int, retirement_Age: Int, monthly_Investment: Float, current_Savings: Float, interest_Rate: Float) -> Double {
        let months_until_retirement = (retirement_Age - current_age) * 12
        
        var retirement_Amount = Double(current_Savings) * pow(Double(1 + interest_Rate/100), Double(months_until_retirement))
        
        for i in 1...months_until_retirement {
            let monthly_rate = interest_Rate / 100 / 12
            retirement_Amount += Double(monthly_Investment) * pow(Double(1 + monthly_rate), Double(i))
        }
        return retirement_Amount
    }
    
    @IBAction func calculateButton_TouchUpInside(_ sender: UIButton) {
       // MSCrashes.generateTestCrash()
        let current_Age: Int? = Int(ageTextField.text!)
        let planned_Retirement_Age: Int? = Int(retirementAgeTextField.text!)
        let monthly_Investment: Float? = Float(monthlyInvestmentTextField.text!)
        let current_Savings: Float? = Float(savingsTextField.text!)
        let interest_Rate: Float? = Float(interestRateTextField.text!)
        
        let retirement_Amount = calculateRetirementAmount(current_age: current_Age!, retirement_Age: planned_Retirement_Age!, monthly_Investment: monthly_Investment!, current_Savings: current_Savings!, interest_Rate: interest_Rate!)
        
        resultLabel.text = "If you save $\(monthly_Investment!) every month for \(planned_Retirement_Age! - current_Age!) years, and invest that money plus your current investment of \(current_Savings!) at a \(interest_Rate!)% annual Interest Rate, you will have $\(retirement_Amount) by the time you are \(planned_Retirement_Age!)"
        
        let properties = ["current_Age": String(current_Age!),
                          "planned_Retirement_Age": String(planned_Retirement_Age!)]
        MSAnalytics.trackEvent("calculate_retirement_amount", withProperties: properties)
    }
    

}

