//
//  HCNextIntroVC1.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HCNextIntroVC1: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var index: Int?
    
    @IBOutlet weak var imgOfIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if   appDelegate.selectGoal == "Fat Loss" {
            
        }
    }
    
    @available(iOS 13.0, *)
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCTrialVersionOrPaidVC") as? HCTrialVersionOrPaidVC
        self.navigationController?.pushViewController(vc! , animated: true)
    }
   
}
