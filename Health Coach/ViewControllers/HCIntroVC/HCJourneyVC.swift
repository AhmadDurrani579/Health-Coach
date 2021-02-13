//
//  HCJourneyVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HCJourneyVC: UIViewController {

    @IBOutlet weak var txtLabe: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtLabe.text = "Thank you for taking your first step to improving your health! You are about to embark on a journey that will take your health to a whole new level. \n  \n I mean, seriously. \n  \n  But first  here are some importants things , you should know  "
    }
    
    
    @IBAction func btnStartJourney_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextPagerVC") as? HCNextPagerVC
        vc!.isComeFromSignUpOrMain = "signUp"
        self.navigationController?.pushViewController(vc!, animated: true)
//        self.pushToViewControllerWithStoryboardID(storyboardId: "HCNextPagerVC")

    }
    
  
}
