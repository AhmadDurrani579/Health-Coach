
//
//  HCDeleteAccountVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 03/09/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCDeleteAccountVC: UIViewController {
    
    @IBOutlet weak var imgOfSexualContent : UIButton!
    @IBOutlet weak var imgOfHateFul : UIButton!
    @IBOutlet weak var imgOfSpam : UIButton!
    @IBOutlet weak var imgOFOther : UIButton!
    @IBOutlet weak var imgOFAlready : UIButton!

    var isRepot : String?
    @IBOutlet weak var txtOfExplain: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOfExplain.placeholder = "Please explain"
        imgOfSexualContent.isSelected = true
        imgOfHateFul.isSelected = false
        imgOfSpam.isSelected = false
        imgOFOther.isSelected = false
        imgOFAlready.isSelected = false

        isRepot = "Too many system glitches"
        WAShareHelper.setBorderAndCornerRadius(layer: txtOfExplain.layer, width: 4.0, radius: 5.0, color: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))
        txtOfExplain.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSexualContent_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        imgOfSexualContent.isSelected = true
        imgOfHateFul.isSelected = false
        imgOfSpam.isSelected = false
        imgOFOther.isSelected = false
        imgOFAlready.isSelected = false
        isRepot = "Too many system glitches"
        txtOfExplain.isHidden = true

    }
    
    
    @IBAction func btnHateFull_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        imgOfSexualContent.isSelected = false
        imgOfHateFul.isSelected = true
        imgOfSpam.isSelected = false
        imgOFOther.isSelected = false
        txtOfExplain.isHidden = true
        imgOFAlready.isSelected = false

        isRepot = "Too many notifications"
        
    }
    
    @IBAction func btnSpam(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        imgOfSexualContent.isSelected = false
        imgOfHateFul.isSelected = false
        imgOfSpam.isSelected = true
        imgOFOther.isSelected = false
        txtOfExplain.isHidden = true
        imgOFAlready.isSelected = false

        isRepot = "I don't know how to use the function"
        
    }
    
    @IBAction func btnOther_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        imgOfSexualContent.isSelected = false
        imgOfHateFul.isSelected = false
        imgOfSpam.isSelected = false
        imgOFAlready.isSelected = false

        imgOFOther.isSelected = true
        isRepot = "I am using similar apps already"
        txtOfExplain.isHidden = true

    }
    
    @IBAction func btnAlready(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        imgOfSexualContent.isSelected = false
        imgOfHateFul.isSelected = false
        imgOfSpam.isSelected = false
        imgOFOther.isSelected = false
        imgOFAlready.isSelected = true
        isRepot = "Other"
        txtOfExplain.isHidden = false

    }


    @IBAction func btnDelete_Pressed(_ sender: UIButton) {
        let userId = UserDefaults.standard.string(forKey: "id")
        var param =    [ : ] as [String : Any]
        
        if imgOFAlready.isSelected == true {
            param =   [ "userid"              :  userId! ,
                        "reason"              :  txtOfExplain.text ?? " "
                     ]
        } else {
            param =   [ "userid"              :  userId! ,
                        "reason"              :  isRepot ?? " "
            ]
        }
        WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: DELETEACCOUNT , isLoaderShow: true, serviceType: "Delete Account", modelType: UserResponse.self, success: { [weak self] (response) in
            
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            
            if responseObj!.success == true {
                UserDefaults.standard.set(nil  , forKey : "id")
                UserDefaults.standard.set(nil  , forKey : "firstName")
                UserDefaults.standard.set(nil  , forKey : "profile")
                self!.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)

            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
    }
}
