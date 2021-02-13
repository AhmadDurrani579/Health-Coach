//
//  HCVerifyCodeVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 01/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

class HCVerifyCodeVC: UIViewController {
    @IBOutlet var txtCode : UITextField!
    var email : String?
    var presenter : RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtCode.setLeftPaddingPoints(10.0)
        
        presenter = RegistrationPresenter(delegate: self)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnVerifyCode(_ sender: UIButton) {
           self.presenter?.checkCode(code: txtCode.text!)
    }
}

@available(iOS 13.0, *)
extension HCVerifyCodeVC : RegistrationDelegate{
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    func registrationDidSucceed(){
        let forgotParam = [ kEmail        : email! ,
                            "code"        : txtCode.text!
                          ] as [String : Any]

        WebServiceManager.post(params:forgotParam as Dictionary<String, AnyObject> , serviceName: CHECKCODE, isLoaderShow: true , serviceType: "Forgot", modelType: UserResponse.self, success: {[weak self] (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                let vc = self?.storyboard?.instantiateViewController(identifier: "HCChangePasswordVC") as? HCChangePasswordVC
                vc?.codeEnter = self!.txtCode.text
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
