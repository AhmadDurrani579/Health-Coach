//
//  HCSelectSignUpVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import DatePickerDialog
class HCSelectSignUpVC: UIViewController {
    
    var selectInterest : String?
    var txtInterest : String?
    var choseHealth : String?

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var btnSelectDate: UIButton!
    var isDateSelect : Bool?
    var presenter: RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        isDateSelect = false
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnSelectDate(_ sender : UIButton) {
        datePickerTapped()
    }

    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 1970
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("DatePickerDialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                self.isDateSelect = true
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                let dateValue = formatter.string(from: dt)
                                self.btnSelectDate.setTitle(dateValue, for: .normal)
                            }
        }
    }
   
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        presenter?.registerValidation(firstName: txtFirstName.text! , lastName: txtLastName.text!, DOB: isDateSelect!)
        
    }
    
}

extension HCSelectSignUpVC: RegistrationDelegate {
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCsignUpVc") as? HCsignUpVc
        vc?.selectInterest = selectInterest
        vc?.choseHealth = choseHealth
        vc?.txtInterest  = txtInterest
        vc?.dateSelect = self.btnSelectDate.titleLabel?.text!
        vc?.firstName = txtFirstName.text!
        vc?.lastName = txtLastName.text!
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func registrationDidFailed(message: String){
        self.showToast(message )
        

//        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}
