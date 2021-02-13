//
//  HCForgotPasswordVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 01/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)

class HCForgotPasswordVC : UIViewController {
    @IBOutlet var txtEmail: UITextField!
    var presenter : RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(10.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSendCode_Pressed(_ sender: UIButton) {
        self.presenter?.forgotPasswordValidation(email: txtEmail.text!)
    }



}

@available(iOS 13.0, *)
extension HCForgotPasswordVC: RegistrationDelegate{
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    func registrationDidSucceed(){
        let forgotParam = [ kEmail        : txtEmail.text!
                          ] as [String : Any]
        WebServiceManager.post(params: forgotParam as Dictionary<String, AnyObject> , serviceName: FORGOTPASSWORD, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                let vc = self?.storyboard?.instantiateViewController(identifier: "HCVerifyCodeVC") as? HCVerifyCodeVC
                vc?.email = self!.txtEmail.text
                self?.navigationController?.pushViewController(vc!, animated: true)
            } else {
                
                self!.showAlert(title: KMessageTitle, message: responseObj.message! , controller: self)
            }
        }, fail: { (error) in
        }, showHUD: true)

    }
    func registrationDidFailed(message: String){
        self.showToast(message)
    }
}
