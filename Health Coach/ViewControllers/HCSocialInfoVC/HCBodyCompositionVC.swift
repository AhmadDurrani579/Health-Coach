//
//  HCBodyCompositionVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 24/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCBodyCompositionVC: UIViewController {
    
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtBMI : UITextField!
    @IBOutlet weak var txtMuscle : UITextField!
    @IBOutlet weak var txtWater : UITextField!
    @IBOutlet weak var txtBMR: UITextField!
    @IBOutlet weak var txtMetabolicAge : UITextField!
    @IBOutlet weak var txtBone : UITextField!
    @IBOutlet weak var txtVisceralFat: UITextField!
    var responseObj: UserResponse?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCurrentDate : UILabel!

    var dateOfFood = Calendar.current.startOfDay(for: Date())
    var dateFormatted : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMMM-dd"
        self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
        lblCurrentDate.text = "Today , \(self.dateFormatted!)"

        if (responseObj?.getUserDetail?.userHealth!.count)! > 0 {
            txtWeight.text  = responseObj?.getUserDetail?.userHealth![0].weight
            txtBMI.text  = responseObj?.getUserDetail?.userHealth![0].bmi
            txtMuscle.text  = responseObj?.getUserDetail?.userHealth![0].muscle
            txtWater.text  = responseObj?.getUserDetail?.userHealth![0].water
            txtBMR.text  = responseObj?.getUserDetail?.userHealth![0].bmr
            txtMetabolicAge.text  = responseObj?.getUserDetail?.userHealth![0].metabolic
            txtBone.text  = responseObj?.getUserDetail?.userHealth![0].bone
            txtVisceralFat.text  = responseObj?.getUserDetail?.userHealth![0].fat

        }
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
                                "weight"        :  txtWeight.text! ,
                                "bmi"         :  txtBMI.text! ,
                                "bmr"         :  txtBMR.text! ,
                                "water"         :  txtWater.text! ,
                                "muscle"         :  txtMuscle.text! ,
                                "metabolic"         :  txtMetabolicAge.text! ,
                                "bone"         :  txtBone.text! ,
                                "fat"         :  txtVisceralFat.text!

            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: USERHEALTHINFO , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
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
