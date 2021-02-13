//
//  HCTrialVersionOrPaidVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 04/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCTrialVersionOrPaidVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBookTrial_Pressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HCAppointmentSelectionVC") as? HCAppointmentSelectionVC
        vc?.isComingFromSignUpOrMain = "signUp"
        self.navigationController?.pushViewController(vc!, animated: true)

//        let story = UIStoryboard(name: "Home", bundle: nil)
//        let vc = story.instantiateViewController(identifier: "HCAppointmentSelectionVC") as? HCAppointmentSelectionVC
//        self.navigationController?.pushViewController(vc!, animated: true)
                    
        //                let vc = story.instantiateViewController(withIdentifier: "HCTabBarController")
        //                let nav = UINavigationController(rootViewController: vc)
        //                nav.isNavigationBarHidden = true
        //                UIApplication.shared.keyWindow?.rootViewController = nav

    }
    @available(iOS 13.0, *)
    @IBAction func btnSkip_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCSelectedProgramVC") as? HCSelectedProgramVC
        self.navigationController?.pushViewController(vc!, animated: true)
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
