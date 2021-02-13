//
//  HCMainPagerVC5.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCMainPagerVC5: UIViewController {
    var index: Int?
    var selectDescription : String?
    var selectTitle : String?
    var selectImage : String?

    var isComeFromWhichScreen : String?
    @IBOutlet var btnNext : UIButton!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtOfIntro: UITextView!
    @IBOutlet weak var imgOfIntro5 : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isComeFromWhichScreen == "signUp" {
            btnNext.isHidden = false
        } else {
            btnNext.isHidden = true
            
        }
        lblTitle.text = selectTitle
        txtOfIntro.text = selectDescription
        imgOfIntro5.image = UIImage(named: selectImage!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        
//        let vc = self.
//        let story = UIStoryboard(name: "Home", bundle: nil)
//        let vc = story.instantiateViewController(withIdentifier: "HCTabBarController")
//        let nav = UINavigationController(rootViewController: vc)
//        nav.isNavigationBarHidden = true
//        UIApplication.shared.keyWindow?.rootViewController = nav

//        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "HCDashboardVC") as? HCDashboardVC
//        vc?.isComingFromSignUpOrMain = "signUp"
//        self.navigationController?.pushViewController(vc!, animated: true)
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KDashboardVC)
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
