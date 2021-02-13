//
//  HCSocialInfoVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 24/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCSocialInfoVC: UIViewController {

//    @IBOutlet weak var txtTargetWeight: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    var responseObj: UserResponse?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSomeWords : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtDescription.placeholder = "Enter description"
        let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"
        
        if responseObj?.getUserDetail?.userDetailObject?.goal == "" {
//            lblSomeWords.text = ""
        } else {
            lblSomeWords.text = ""
        }
        txtDescription.text = responseObj?.getUserDetail?.userDetailObject?.goal

//        txtTargetWeight.text = responseObj?.getUserDetail?.userDetailObject?.target_weight
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEdit_Pressed(_ sender: UIButton) {
        updatrSocialInf()
    }
    
    @IBAction func btnSave_Pressed(_ sender: UIButton) {
        updatrSocialInf()
        
    }
    func updatrSocialInf() {
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             : userId! ,
                                "goal"               : txtDescription.text!
                             ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: HEALTGOAL , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("updateProfilePic"), object: nil)
                this.showAlert(title: KMessageTitle , message: responseObj!.message ?? "Health Information Updated", controller: this)
            }
            else {
                this.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: this)
            }
            }, fail: { (error) in
        }, showHUD: true)

    }
}
