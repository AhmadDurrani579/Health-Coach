//
//  HCNextIntroVC3.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HCNextIntroVC3: UIViewController {
    var index: Int?

    @IBOutlet weak var txtOfIntro: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtOfIntro.text = "Over the course  of 16 weeks, you’ll work with your personal health coach to define, discover, explore and achieve your health goals. \n Discovery Sessions \n The 45min discovery sessions will be held once a fortnight. \n The goal of the discovery sessions with your health coach are (but not limited to): \n - Digging deep into the root cause of your health concerns \n - Evaluating ongoing and new challenges \n - Exploring new methods to overcome those challenges \n - Reviewing the effectiveness of implemented strategies"

        // Do any additional setup after loading the view.
    }
    
    @available(iOS 13.0, *)
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
