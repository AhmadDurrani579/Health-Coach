//
//  IntoViewController1.swift
//  blink
//
//  Created by Ahmed Durrani on 01/11/2017.
//  Copyright © 2017 blink_APP. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class IntoViewController1: UIViewController {
    var index: Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("isButtonHide"), object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.indexSelect =  1
        appDelegate.previousIndex = 0

    }
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
        //        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.NEXTPAGER)
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KHCLogin)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
