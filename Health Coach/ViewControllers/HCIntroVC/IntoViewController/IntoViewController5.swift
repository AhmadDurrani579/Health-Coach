//
//  IntoViewController5.swift
//  blink
//
//  Created by Ahmed Durrani on 01/11/2017.
//  Copyright © 2017 blink_APP. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class IntoViewController5: UIViewController {
    var index: Int?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var imgOfGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgOfGif.image = UIImage.gif(name: "welcome5")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        appDelegate.indexSelect =  5
//        appDelegate.previousIndex = 3

    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("isHide") , object: nil)

    }
//    @objc func hideBottomView() {
//
//    }

    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
