//
//  HCChangePasswordVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 01/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
//
class HCChangePasswordVC: UIViewController {
    var codeEnter : String?
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRetypePassword : UITextField!
    var presenter: RegistrationPresenter?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegistrationPresenter(delegate: self)
        txtPassword.setLeftPaddingPoints(10)
        txtRetypePassword.setLeftPaddingPoints(10)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnChangePassword_Pressed(_ sender: UIButton) {
        self.presenter?.validationOnChangePassword(password: txtPassword.text!, confirmPass: txtRetypePassword.text!)
        
    }



}

extension HCChangePasswordVC : RegistrationDelegate{
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){

        let params =      [ "code"                             :  codeEnter!  ,
                            "password"                         :  txtPassword.text!
                          ] as [String : Any]

        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: UPDATEPASSWORD , isLoaderShow: true, serviceType: "change Password", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                self!.showAlertViewWithTitle(title: KMessageTitle, message: responseObj.message! , dismissCompletion: {
                    self!.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)
                })
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                
        }, showHUD: true)

        
    }
    func registrationDidFailed(message: String){
        self.showToast(message)
    }
}
