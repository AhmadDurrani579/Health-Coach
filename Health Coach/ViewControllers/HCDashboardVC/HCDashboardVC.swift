//
//  HCDashboardVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 15/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCDashboardVC: UIViewController {
    @IBOutlet weak var btnDashboard: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDashboard.layer.shadowOpacity = 0.5
        btnDashboard.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        btnDashboard.layer.shadowRadius = 5.0
        btnDashboard.layer.shadowColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0).cgColor

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnDashboard_Pressed(_ sender : UIButton) {
        
        
        let story = UIStoryboard(name: "Home", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "HCTabBarController")
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = nav

        
//        self?.pushToViewControllerWithStoryboardID(storyboardId: )

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
