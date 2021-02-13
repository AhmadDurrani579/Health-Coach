//
//  HCSelectedProgramVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 04/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCSelectedProgramVC: UIViewController {

    @IBOutlet weak var btnSelectedInterest: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        if appDelegate.selectGoal == "1" {
            btnSelectedInterest.setTitle("Fat loss", for: .normal)
        } else if  appDelegate.selectGoal == "2" {
            btnSelectedInterest.setTitle("Sleep disorder", for: .normal)
        } else if  appDelegate.selectGoal == "3" {
            btnSelectedInterest.setTitle("Stress managnment", for: .normal)
        } else if  appDelegate.selectGoal == "4" {
            btnSelectedInterest.setTitle("Increase Energy", for: .normal)
        } else if appDelegate.selectGoal == "5" {
            btnSelectedInterest.setTitle("Harmone Balance", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnPre_Pressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @available(iOS 13.0, *)
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCGoalMainVC") as? HCGoalMainVC
        vc?.isComeFromSignUpOrMain = "signUp"
        self.navigationController?.pushViewController(vc!, animated: true)
//        self.pushToViewControllerWithStoryboardID(storyboardId: "HCGoalMainVC")

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
