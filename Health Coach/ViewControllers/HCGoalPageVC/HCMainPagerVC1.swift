//
//  HCMainPagerVC1.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCMainPagerVC1: UIViewController {
    
    var selectGoalTitle : String?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgOfIntro1: UIImageView!
    @IBOutlet weak var txtOfIntro: UITextView!
    var index: Int?
    var selectDescription : String?
    var selectImage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = selectGoalTitle
        txtOfIntro.text = selectDescription
        imgOfIntro1.image = UIImage(named: selectImage ?? "welcome")
        
    }
    
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KDashboardVC)
    }
    

    

}
