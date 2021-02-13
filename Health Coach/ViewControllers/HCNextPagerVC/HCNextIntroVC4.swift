//
//  HCNextIntroVC4.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HCNextIntroVC4: UIViewController {
    var index: Int?

    @IBOutlet weak var txtOfIntro3rd: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtOfIntro3rd.text = "Daily Support Your health coach will support you providing the daily motivations and encouragements you need. \n  They will keep in touch with you and send you: \n - personalised messages and notifications \n - relevant articles \n - health tips of the day  \n - constructive feedback of your progress  /n Monitoring and Tracking  /n You and your health coach will both be monitoring your progress. /n You will be able to monitor your  /n - body composition  \n - food intake and choices  \n - physical activities \n - moods through the day  \n - sleep conditions \n  - specific health condition (optional)"

        // Do any additional setup after loading the view.
    }
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCTrialVersionOrPaidVC") as? HCTrialVersionOrPaidVC
        self.navigationController?.pushViewController(vc! , animated: true)
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
