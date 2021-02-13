//
//  IntroViewController6.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class IntroViewController6: UIViewController {
    var index: Int?
    @IBOutlet weak var btnStart: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private  func btnGetStarted(_ sender: UIButton) {
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KHCInterentListVC)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.indexSelect =  6
        appDelegate.previousIndex = 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("IsBottomView"), object: nil)

    }
    

}
