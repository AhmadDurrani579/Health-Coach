//
//  HCLoginVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 15/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCLoginVC: UIViewController {
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    var selectTerm : Bool?
    var presenter: RegistrationPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTerm = false
        btnSignIn.layer.shadowOpacity = 0.5
        btnSignIn.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnSignIn.layer.shadowRadius = 5.0
        btnSignIn.layer.shadowColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0).cgColor
        presenter = RegistrationPresenter(delegate: self)
        
//        txtEmail.text =      "a.khan@seersolutionz.com"
//        txtPassword.text =    "123456"

//        txtEmail.text =      "ahmad@yahoo.com"
//        txtPassword.text =    "ahmad12345"
//
//        txtEmail.text = "Hassan@gmail.com"
//        txtPassword.text = "123456"
//
    }
    
    @IBAction func btnHideOrShowPassweord(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true

        }
    }

    
    @IBAction private func btnLogin_Pressed(_ sender : UIButton) {
        
//        self.pushToViewControllerWithStoryboardID(storyboardId: "HCJourneyVC")

        presenter?.signIn(email: txtEmail.text! , password: txtPassword.text!)
    }
    
        @IBAction private func btnForgotPasswordVC(_ sender : UIButton) {
            
            self.pushToViewControllerWithStoryboardID(storyboardId: "HCForgotPasswordVC")

        }


    @IBAction private func btnSelectTermCondition_Pressed(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            selectTerm = true
        } else {
            selectTerm = false
        }
    }
}

extension HCLoginVC: RegistrationDelegate {
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){

        let loginParam =        [ kEmail         : txtEmail.text!,
                                  kPassword      : txtPassword.text! ,
                                  "device_id"    : DEVICE_TOKEN
                                ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                localUserData = responseObj.data
                
                UserDefaults.standard.set(responseObj.data?.first_name , forKey: "firstName")
                UserDefaults.standard.set(responseObj.data?.last_name , forKey: "lastName")

//                let userId = responseObj.data?.id!
                UserDefaults.standard.set(responseObj.data?.id , forKey: "id")
                UserDefaults.standard.set(self!.txtPassword.text , forKey: "pass")

                UserDefaults.standard.set(responseObj.data?.profile_pic , forKey: "profile")

                self?.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KDashboardVC)
//                UserDefaults.standard.set(responseObj.data?.user?.phoneNumber , forKey: "phoneNum")
//                UserDefaults.standard.set(responseObj.data?.user?.profilePicture , forKey: "profile")
//
//                let story = UIStoryboard(name: "Home", bundle: nil)
//                let vc = story.instantiateViewController(withIdentifier: VCIdentifier.kMainTabbarController)
//                let nav = UINavigationController(rootViewController: vc)
//                nav.isNavigationBarHidden = true
//                UIApplication.shared.keyWindow?.rootViewController = nav
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                
        }, showHUD: true)
    }
    
    func registrationDidFailed(message: String){
        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}
