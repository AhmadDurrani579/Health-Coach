//
//  HCStartVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 20/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import DWAnimatedLabel

class HCStartVC: UIViewController {
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
//    var playerLayer = AVPlayerLayer()
    var playerController = AVPlayerViewController()
    
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var lblTitle: DWAnimatedLabel!
    @IBOutlet weak var lblSubTitle: DWAnimatedLabel!
    @IBOutlet weak var lblFooterTitle: DWAnimatedLabel!
    var inactiveQueue : DispatchQueue!
    override func viewDidLoad() {
        super.viewDidLoad()
        playerController.view.backgroundColor = UIColor.white
        
//        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .initiallyInactive)
//        inactiveQueue = anotherQueue
        
//        let queue = DispatchQueue(label: "Some serial queue")
//        let group = DispatchGroup()

        // Do work synchronously
//        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility)
        
//        inactiveQueue.async {
//
//        }
//
//        inactiveQueue.async {
//        }
//
//
//
//        queue.async(group: group) {
//            sleep(2)
//        }
            self.lblTitle.isHidden = true
            self.lblSubTitle.isHidden = true
            self.lblFooterTitle.isHidden = true

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.lblTitle.isHidden = false

            self.lblTitle.animationType = .fade
            self.lblTitle.startAnimation(duration: 8.0, nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                self.lblSubTitle.isHidden = false
                self.lblSubTitle.animationType = .fade
                self.lblSubTitle.startAnimation(duration: 8.0, nil)
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
                self.lblFooterTitle.isHidden = false

                self.lblFooterTitle.animationType = .fade
                self.lblFooterTitle.startAnimation(duration: 8.0, nil)
            })

        })

        
        




        // Do work asynchronously

        
        playVideo()
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.player = player
        playerController.showsPlaybackControls = false

        self.videoView.frame = self.view.frame
        self.view.backgroundColor = UIColor.white
        playerController.view.backgroundColor = UIColor.white
        self.videoView.addSubview(playerController.view)
        videoView.layer.masksToBounds = false
        self.videoView.addSubview(playerController.view)
        player!.play()
        NotificationCenter.default.addObserver(self, selector: #selector(HCStartVC.playerItemDidReachEnd(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = videoView.bounds
//        videoView.layer.addSublayer(playerLayer)
//        player!.play()

//        playerController = AVPlayerViewController()
//        playerController!.showsPlaybackControls = true
//
//
//        playerController!.player = player
//        present(playerController!, animated: true) {
//            self.player!.play()
//        }
//

        
//        let item = AVPlayerItem(url: URL(fileURLWithPath: path))
//        let player = AVPlayer(playerItem: item)
//        player.actionAtItemEnd = .none

        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem, queue: nil)
//        { notification in
////            let t1 = CMTimeMake(value: 5, timescale: 100);
////            self.player!.seek(to: t1)
////            self.player!.play()
//            self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)
//
//        }

    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)
        

//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
//            self.player!.pause()
//            self.playerLayer.removeFromSuperlayer()
//            self.player = nil
//        }
//
//        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)
//
    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//            self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)
//
//        })
//
//    }
//


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
