//
//  HCMainPagerVC4.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCMainPagerVC4: UIViewController {
    var index: Int?
    var selectTitle : String?
    var selectDescription : String?
    var selectImage : String?

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtOfIntro: UITextView!
    @IBOutlet weak var imgOfIntro4 : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = selectTitle
        txtOfIntro.text = selectDescription
        
        imgOfIntro4.image = UIImage(named: selectImage!)

        // Do any additional setup after loading the view.
    }
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
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
