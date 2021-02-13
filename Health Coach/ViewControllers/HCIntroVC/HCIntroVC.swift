//
//  HCIntroVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 15/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import ImageSlideshow


class HCIntroVC: UIViewController {
    
    @IBOutlet var slideshow: ImageSlideshow!
    
    let localSource = [BundleImageSource(imageString: "background"), BundleImageSource(imageString: "background2"), BundleImageSource(imageString: "group3"), BundleImageSource(imageString: "group5"),BundleImageSource(imageString: "rectangle")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.white
        slideshow.pageIndicator = pageControl
        
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
//        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.delegate = self
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource)
        slideshow.presentFullScreenController(from: self)
//        let fullScreenController = slideshow.presentFullScreenController(from: self)
//        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)

        // Do any additional setup after loading the view.
    }
   
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
extension HCIntroVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
