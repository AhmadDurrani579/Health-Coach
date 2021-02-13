//
//  HCSelectGoalVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCSelectGoalVC: UIViewController  {

    @IBOutlet weak var txtOfInterest: UITextView!
    var selectInterest : String?
    var presenter: RegistrationPresenter?

    @IBOutlet weak var lblExplain: UILabel!
    @IBOutlet weak var lblAlert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtOfInterest.delegate = self
        presenter = RegistrationPresenter(delegate: self)
        WAShareHelper.setViewCornerRadius(txtOfInterest, radius: 5.0)
//        txtOfInterest.placeholder = "Explain here"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        presenter?.healthGoal(txtDesc: txtOfInterest.text!)
    }
    
   
}
extension HCSelectGoalVC: RegistrationDelegate {
    func showProgress(){
        
    }
    func hideProgress(){
        
    }
    
    func registrationDidSucceed(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCHealthGoalVC") as? HCHealthGoalVC
        vc?.selectInterest = selectInterest
        vc?.txtInterest   = txtOfInterest.text!
        self.navigationController?.pushViewController(vc!, animated: true)

        
    }
    
    func registrationDidFailed(message: String){
//        lblExplain.isHidden = false
        lblAlert.isHidden = false
        lblExplain.textColor = UIColor(red: 244/255.0, green: 77/255.0, blue: 78/255.0, alpha: 1.0)

//        self.showAlert(title: KMessageTitle , message: message, controller: self)
    }
}

extension HCSelectGoalVC : UITextViewDelegate {
   func textViewDidBeginEditing(_ textView: UITextView) {
      lblAlert.isHidden = true
//      lblExplain.isHidden = true
      lblExplain.textColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)

    }
}
