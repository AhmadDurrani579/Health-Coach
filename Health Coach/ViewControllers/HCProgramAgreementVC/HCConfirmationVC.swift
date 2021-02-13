//
//  HCConfirmationVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 03/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCConfirmationVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewOfPay: CardView!

    override func viewDidLoad() {
            super.viewDidLoad()
            
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("IsImageUpload"), object: nil)

        WAShareHelper.setBorderAndCornerRadius(layer: viewOfPay.layer, width: 2.0 , radius: 15.0, color: UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0))

    //        txtDescription.placeholder = "Enter description"
            let firstName = UserDefaults.standard.string(forKey: "firstName")
            let lastNAme = UserDefaults.standard.string(forKey: "lastName")

            lblName.text = "\(firstName!) \(lastNAme!)"
    
    }
    
    @IBAction private func btnPayNow_Pressed(_ sender : UIButton) {
//        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KDashboardVC)
        
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
