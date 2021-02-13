//
//  HCHealthInfoVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/09/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCHealthInfoVC: UIViewController {
    
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtBMI : UITextField!
    @IBOutlet weak var txtMuscle : UITextField!
    @IBOutlet weak var txtWater : UITextField!
    @IBOutlet weak var txtBMR: UITextField!
    @IBOutlet weak var txtMetabolicAge : UITextField!
    @IBOutlet weak var txtBone : UITextField!
    @IBOutlet weak var lblName: UILabel!
    var responseObj: UserResponse?

    @IBOutlet weak var txtSuppliment: UITextField!
    @IBOutlet weak var txtTherape: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"
            txtWeight.text  = responseObj?.getUserDetail?.userDetailObject?.height
            txtBMI.text  = responseObj?.getUserDetail?.userDetailObject?.weight
            txtMuscle.text  = responseObj?.getUserDetail?.userDetailObject?.health_parents
            txtWater.text  = responseObj?.getUserDetail?.userDetailObject?.sleep
            txtBMR.text  = responseObj?.getUserDetail?.userDetailObject?.allergies
            txtMetabolicAge.text  = responseObj?.getUserDetail?.userDetailObject!.serious_illness
            txtBone.text  = responseObj?.getUserDetail?.userDetailObject!.major_addiction
            
            txtSuppliment.text  = responseObj?.getUserDetail?.userDetailObject?.medications
            txtTherape.text  = responseObj?.getUserDetail?.userDetailObject?.therapies


        // Do any additional setup after loading the view.
    }
    
    func updatrHealthInfo() {
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             : userId! ,
                                "height"        :  txtWeight.text! ,
                                "weight"         :  txtBMI.text! ,
                                "health_parents"         :  txtMuscle.text! ,
                                "sleep"         :  txtWater.text! ,
                                "allergies"         :  txtBMR.text! ,
                                "serious_illness"         :  txtMetabolicAge.text! ,
                                "major_addiction"         :  txtBone.text! ,
                                "medications"         :  txtSuppliment.text! ,
                                "therapies"         :  txtTherape.text!

            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: HEALTHINFOUPDATE , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("UpdateInfo"), object: nil)
                self?.showToast(responseObj!.message ?? "Health Information Updated")
//                self!.showAlert(title: KMessageTitle , message: , controller: self)
            }
            else {
                 self?.showToast(responseObj!.message!)
//                self!.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
        
    }
    
    @IBAction private func btnSave_Pressed(_ sender : UIButton) {
        updatrHealthInfo()
    }

}
