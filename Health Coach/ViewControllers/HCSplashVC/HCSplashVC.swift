//
//  HCSplashVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 14/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import DWAnimatedLabel

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HCSplashVC: UIViewController {

    @IBOutlet weak var lblTitle: DWAnimatedLabel!
    @IBOutlet weak var lblSubTitle: DWAnimatedLabel!
    @IBOutlet weak var lblFooterTitle: DWAnimatedLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        lblTitle.animationType = .fade
        lblTitle.startAnimation(duration: 3.0, nil)
                    
        lblSubTitle.animationType = .fade
        lblSubTitle.startAnimation(duration: 3.0, nil)
        
        lblFooterTitle.animationType = .fade
        lblFooterTitle.startAnimation(duration: 3.0, nil)


        // Do any additional setup after loading the view.
//        playVideo()
    }
    
//    private func playVideo() {
//        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
//            debugPrint("video.m4v not found")
//            return
//        }
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        present(playerController, animated: true) {
//            player.play()
//        }
//    }
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            let userId = UserDefaults.standard.string(forKey:"id" )
//            userId = nil
            if userId == nil {
//                self.pushToViewControllerWithStoryboardID(storyboardId: "BLIntoViewController")
                
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextPagerVC") as? HCNextPagerVC
//                self.navigationController?.pushViewController(vc!, animated: true)
                  self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KHCSTARTVC)
//                self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.HCNextPagerVC)
//                let vc = self.storyboard?.instantiateViewController(identifier: "HCNextPagerVC") as? HCNextPagerVC
//                self.navigationController?.pushViewController(vc!, animated: true)


            } else {
                
//            let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "HCAppointmentSelectionVC")
//            self.navigationController?.pushViewController(vc, animated: true)

                
                let story = UIStoryboard(name: "Home", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "HCTabBarController")
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                UIApplication.shared.keyWindow?.rootViewController = nav

            }
            
        })
        
    }

    

  
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

