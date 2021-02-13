//
//  HealthGaolInfoVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 24/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HealthGaolInfoVC: UIViewController {
    
    @IBOutlet weak var txtMaritlaStatus: UITextField!
    @IBOutlet weak var txtNumberOfChildres: UITextField!
    @IBOutlet weak var txtHourPerWeek: UITextField!
    @IBOutlet weak var txtNationality: UITextField!
    @IBOutlet weak var txtCurrentLiving: UITextField!

    @IBOutlet weak var txtOccupation: UITextView!
    @IBOutlet weak var lblName: UILabel!

    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"
        
        txtMaritlaStatus.text  = responseObj?.getUserDetail?.userDetailObject?.relation_status
        txtNumberOfChildres.text  = responseObj?.getUserDetail?.userDetailObject?.no_childs
        txtHourPerWeek.text  = responseObj?.getUserDetail?.userDetailObject?.hours_per_week
        txtNationality.text  = responseObj?.getUserDetail?.userDetailObject?.nationality
        txtCurrentLiving.text  = responseObj?.getUserDetail?.userDetailObject?.current_living
        txtOccupation.text  = responseObj?.getUserDetail?.userDetailObject?.occupation

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEdit_Pressed(_ sender: UIButton) {
        updatrSocialInfo()
    }
    
    @IBAction func btnSave_Pressed(_ sender: UIButton) {
        updatrSocialInfo()
    }
    func updatrSocialInfo() {
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             : userId! ,
                                "relation_status"             :  txtMaritlaStatus.text! ,
                                "no_childs"         :  txtNumberOfChildres.text! ,
                                "occupation"         :  txtOccupation.text! ,
                                "hours_per_week"         :  txtHourPerWeek.text! ,
                                "nationality"         :  txtNationality.text! ,
                                "current_living"         :  txtCurrentLiving.text!
                             ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: RELATIONSHIP , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("UpdateInfo"), object: nil)

                self!.showAlert(title: KMessageTitle , message: responseObj!.message ?? "Health Information Updated", controller: self)
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
        
    }

}
