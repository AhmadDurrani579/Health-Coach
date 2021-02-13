//
//  HCsignUpVc.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCsignUpVc: UIViewController {
    
    var selectInterest : String?
    var txtInterest : String?
    var choseHealth : String?
    var firstName : String?
    var lastName : String?
    var dateSelect : String?
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSelectTermCondition: UIButton!
    var presenter: RegistrationPresenter?

    var isTermAndCond : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        isTermAndCond = false

        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        presenter?.SecondStepRegistration(email: txtEmail.text! , password: txtPassword.text!, confirmPass: txtConfirmPassword.text!  , isTerm: isTermAndCond!)

    }
    
    
    @IBAction func btnSelectTermCondition_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            isTermAndCond = true
        } else {
            isTermAndCond = false
        }
        
    }

    @IBAction func btnTermCheckCondition_Pressed(_ sender: UIButton) {
        isTermAndCond = true
        btnSelectTermCondition.isSelected = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier : "HCTermAndConditionVC") as? HCTermAndConditionVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnHideOrShowPassweord(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true

        }
    }
    
    @IBAction func btnHideOrShowConfirmPassweord(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            txtConfirmPassword.isSecureTextEntry = false
        } else {
            txtConfirmPassword.isSecureTextEntry = true
            
        }
    }
}

extension HCsignUpVc: RegistrationDelegate {
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){
        
        let loginParam =      [ kEmail          : txtEmail.text!,
                                kPassword       : txtPassword.text! ,
                                "first_name"    : firstName! ,
                                "last_name"     : lastName! ,
                                "dob"           : dateSelect! ,
                                "goal"          : txtInterest! ,
                                "interest_id"   : selectInterest! ,
                                "style"         : choseHealth! ,
                                "terms"         : "abc" ,
                                "device"        :  "iOS" ,
                                "device_id"     :  DEVICE_TOKEN
            
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SIGNUP, isLoaderShow: true, serviceType: "Sign Up", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                UserDefaults.standard.set(responseObj.data?.first_name , forKey: "firstName")
                UserDefaults.standard.set(responseObj.data?.last_name , forKey: "lastName")
                UserDefaults.standard.set(self!.txtPassword.text , forKey: "pass")
                UserDefaults.standard.set(responseObj.data?.id , forKey: "id")
                UserDefaults.standard.set(responseObj.data?.profile_pic , forKey: "profile")

                self?.pushToViewControllerWithStoryboardID(storyboardId: "HCJourneyVC")
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                
        }, showHUD: true)

    }
    
    func registrationDidFailed(message: String){
        self.showToast(message )

//        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}
