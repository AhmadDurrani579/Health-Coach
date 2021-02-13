//
//  HCNextIntroVC6.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HCNextIntroVC6: UIViewController {
    
    var index: Int?
    var isComeFromWhichScreen : String?
    @IBOutlet var btnNext : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        if isComeFromWhichScreen == "main" {
            btnNext.isHidden = true
        } else {
            btnNext.isHidden = false

        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCTrialVersionOrPaidVC") as? HCTrialVersionOrPaidVC
        self.navigationController?.pushViewController(vc! , animated: true)

    }

   

}
