//
//  HCNextPagerVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HCNextPagerVC: UIViewController {
    
    var previousVC: UIViewController?
    var showingIndex: Int = 0
    var pageVC: UIPageViewController?
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var btnBack : UIButton!
    @IBOutlet var titleOfScreen : UILabel!
//    @IBOutlet var btnNext : UIButton!
    var isComeFromSignUpOrMain : String?

    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setPager()

        self.view.bringSubviewToFront(viewBottom)
        self.view.bringSubviewToFront(titleOfScreen)
        self.view.bringSubviewToFront(btnBack)
        configurePageControl()

    }
    
//    @objc func pressButton(_ button: UIButton) {
//        print("Button with tag: \(button.tag) clicked!")
//    }

    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width,height: 40))
        self.pageControl.numberOfPages = 6
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 1.0
        self.pageControl.tintColor = UIColor.lightGray
        self.pageControl.pageIndicatorTintColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
        self.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        self.view.addSubview(pageControl)
    }
    
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageViewControllerIntro") as! UIPageViewController?
        pageVC?.dataSource = self
        pageVC?.delegate = self
        let startVC = viewControllerAtIndex(tempIndex: 0)
        _ = startVC.view
        pageVC?.setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        pageVC?.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEGHT)
        self.addChild(pageVC!)
        self.view.addSubview((pageVC?.view)!)
        self.pageVC?.didMove(toParent: self)
        
    }
    
    @IBAction private func btnNext_Pressed(_ sender : UIButton) {
        print("Ahmad")
    }
    
    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
        
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextIntroVC1" ) as! HCNextIntroVC1
            vc.index = 0
            return vc
        }else if tempIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextIntroVC2" ) as! HCNextIntroVC2
            vc.index = 1
            return vc
        }
        else if tempIndex == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextIntroVC3" ) as! HCNextIntroVC3
            vc.index = 2
            
            
            return vc
        } else if tempIndex == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextIntroVC4" ) as! HCNextIntroVC4
            vc.index = 3
            return vc
        } else if tempIndex == 4  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextIntroVC5" ) as! HCNextIntroVC5
            vc.index = 4
            
            return vc
            
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCNextIntroVC6" ) as! HCNextIntroVC6
            vc.index = 5
            vc.isComeFromWhichScreen = isComeFromSignUpOrMain
            return vc
            
        }
    }
}



@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension HCNextPagerVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currIndex: Int = 0
        if viewController is HCNextIntroVC1 {
            currIndex = 0
            self.pageControl.currentPage = 0
            
        }  else if  viewController is HCNextIntroVC2 {
            currIndex = 1
            self.pageControl.currentPage = 1
        } else if  viewController is HCNextIntroVC3 {
            currIndex = 2
            self.pageControl.currentPage = 2
            
            
        }else if  viewController is HCNextIntroVC4 {
            currIndex = 3
            self.pageControl.currentPage = 3
            
            
        } else if  viewController is HCNextIntroVC5 {
            currIndex = 4
            self.pageControl.currentPage = 4
            
            
        } else if  viewController is HCNextIntroVC6 {
            currIndex = 5
            self.pageControl.currentPage = 5
            
            
        }
        
        if currIndex == NSNotFound {
            return nil
        }
        currIndex = currIndex + 1
        if currIndex == 6 {
            return nil
        }
        
        let vc = viewControllerAtIndex(tempIndex: currIndex)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var currIndex: Int = 0
        if viewController is HCNextIntroVC6 {
            currIndex = 5
            self.pageControl.currentPage = 5
            
        }
        else  if viewController is HCNextIntroVC5 {
            currIndex = 4
            self.pageControl.currentPage = 4
            
        }else if viewController is HCNextIntroVC4 {
            currIndex = 3
            self.pageControl.currentPage = 3
            
        } else if viewController is HCNextIntroVC3 {
            currIndex = 2
            self.pageControl.currentPage = 2
        }else if viewController is HCNextIntroVC2 {
            currIndex = 1
            self.pageControl.currentPage = 1
        } else {
            currIndex = 0
            self.pageControl.currentPage = 0
        }
        if currIndex == 0 || currIndex == NSNotFound {
            return nil
        }
        currIndex = currIndex - 1
        return viewControllerAtIndex(tempIndex: currIndex)
    }
    
  
    
}

