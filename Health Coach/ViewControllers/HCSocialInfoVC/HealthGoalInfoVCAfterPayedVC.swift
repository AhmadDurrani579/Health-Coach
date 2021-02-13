//
//  HealthGoalInfoVCAfterPayedVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 29/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HealthGoalInfoVCAfterPayedVC : UIViewController {
    @IBOutlet weak var lblName: UILabel!
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"

        // Do any additional setup after loading the view.
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
