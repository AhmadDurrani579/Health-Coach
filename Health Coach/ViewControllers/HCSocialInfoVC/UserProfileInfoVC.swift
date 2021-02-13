//
//  UserProfileInfoVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 24/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class UserProfileInfoVC: UIViewController {
    
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtFirstName : UITextField!
    @IBOutlet weak var txtLastName  : UITextField!
//    @IBOutlet weak var txtPassword  : UITextField!
    @IBOutlet weak var lblAccountType  : UILabel!
    @IBOutlet weak var lblExpiryDate  : UILabel!

    var responseObj: UserResponse?
    @IBOutlet weak var lblName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"
        
        if #available(iOS 13.0, *) {
            if let subscription = appDelegate().responseObj?.getUserDetail?.subscription {
                lblAccountType.text = "\(subscription.duration ?? "") months"
                lblExpiryDate.text = subscription.expiryDate
            }
        } else {
            // Fallback on earlier versions
        }

//        self!.appDelegate.responseObj?.getUserDetail?.subscription
        txtEmail.text  = responseObj?.getUserDetail?.userDetailObject?.email
        txtFirstName.text  = responseObj?.getUserDetail?.userDetailObject?.first_name
        txtLastName.text  = responseObj?.getUserDetail?.userDetailObject?.last_name
//        txtPassword.text  = password

        // Do any additional setup after loading the view.
    }
    
    @available(iOS 13.0, *)
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    @IBAction func btnWebsiteOpen_Pressed(_ sender: UIButton) {
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        if let url = URL(string: "http://coogekihealth.com/") {
            UIApplication.shared.open(url)
        }
    }

    @IBAction func btnChangePAssword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCChangePassVC") as? HCChangePassVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func btntermsCondition(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "HCTermAndConditionVC") as? HCTermAndConditionVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }

    
    
    
    @IBAction func btnProgramAgreement_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCProgramAgreementSliderVC") as? HCProgramAgreementSliderVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    
    @IBAction func btnDeleteAccount_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCDeleteAccountVC") as? HCDeleteAccountVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//        UserDefaults.standard.set(nil  , forKey : "id")
//        UserDefaults.standard.set(nil  , forKey : "firstName")
//        UserDefaults.standard.set(nil  , forKey : "profile")
//        
////        UIApplication.shared.keyWindow?.rootViewController = vc
//        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)


    }
    
    @IBAction private func btnSave_Pressed(_ sender : UIButton) {
        let userId = UserDefaults.standard.string(forKey: "id")
        let password = UserDefaults.standard.string(forKey: "pass")

        let loginParam =      [ kEmail         : txtEmail.text!,
                                kPassword      : password ?? "" ,
                                "first_name"   : txtFirstName.text! ,
                                "last_name"    : txtLastName.text! ,
                                "userid"       : userId!
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: UPDATEPROFILE, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("UpdateInfo"), object: nil)

                localUserData = responseObj.data
                UserDefaults.standard.set(self!.txtFirstName.text , forKey: "firstName")
//                UserDefaults.standard.set(self!.txtPassword.text , forKey: "pass")
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
            }
            }, fail: { (error) in
                
        }, showHUD: true)
    }
    

}

