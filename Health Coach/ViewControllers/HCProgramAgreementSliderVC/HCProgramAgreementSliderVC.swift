//
//  HCProgramAgreementSliderVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 22/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCProgramAgreementSliderVC: UIViewController {
        var previousVC: UIViewController?
        var showingIndex: Int = 0
        var pageVC: UIPageViewController?
        @IBOutlet var viewBottom: UIView!
        @IBOutlet var btnBack : UIButton!
        @IBOutlet var titleOfScreen : UILabel!
        var isComeFromSignUpOrMain : String?

        var pageControl = UIPageControl()
        let nc = NotificationCenter.default
        let nc1 = NotificationCenter.default


        
    override func viewDidLoad() {
        super.viewDidLoad()
        setPager()
//        nc.addObserver(self, selector: #selector(BLIntoViewController.hideBottomView), name: Notification.Name("isBottomAndTopHide"), object: nil)
//        nc1.addObserver(self, selector: #selector(BLIntoViewController.show), name: Notification.Name("isShowTab"), object: nil)
        self.view.bringSubviewToFront(viewBottom)
        self.view.bringSubviewToFront(titleOfScreen)
        self.view.bringSubviewToFront(btnBack)
        configurePageControl()

    }
    
    func hideBottomView() {
        viewBottom.isHidden = true
        btnBack.isHidden = true
        titleOfScreen.isHidden = true
        pageControl.isHidden = true
    }
    
     func show() {
        viewBottom.isHidden = false
        btnBack.isHidden = false
        titleOfScreen.isHidden = false
        pageControl.isHidden = false
    }
    
    func configurePageControl() {
            pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width,height: 40))
            self.pageControl.numberOfPages = 4
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProgramAgreementSlider1" ) as! ProgramAgreementSlider1
//                vc.index = 0
//                show()
                return vc
            }else if tempIndex == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProgramAgreementSlider2" ) as! ProgramAgreementSlider2
//                vc.index = 1
//                show()

                return vc
            } else if tempIndex == 2 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProgramAgreementSlider3" ) as! ProgramAgreementSlider3
//                show()

                return vc
                
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCProgramAgreementVC" ) as! HCProgramAgreementVC
//                hideBottomView()
                return vc

                
            }
        }
    }

extension HCProgramAgreementSliderVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currIndex: Int = 0
        if viewController is ProgramAgreementSlider1 {
            currIndex = 0
            self.pageControl.currentPage = 0
            show()
        }  else if  viewController is ProgramAgreementSlider2 {
            currIndex = 1
            self.pageControl.currentPage = 1
        } else if  viewController is ProgramAgreementSlider3 {
            currIndex = 2
            self.pageControl.currentPage = 2
            show()
        } else if  viewController is HCProgramAgreementVC {
            currIndex = 3
            self.pageControl.currentPage = 3
            hideBottomView()
        }
        
        if currIndex == NSNotFound {
            return nil
        }
        currIndex = currIndex + 1
        if currIndex == 4 {
            return nil
        }
        
        if currIndex == 3 {
            hideBottomView()

        } else {
            show()
        }
        let vc = viewControllerAtIndex(tempIndex: currIndex)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var currIndex: Int = 0
        if viewController is HCProgramAgreementVC {
            currIndex = 3
            hideBottomView()
            self.pageControl.currentPage = 3
                   
        }
       else if viewController is ProgramAgreementSlider3 {
            currIndex = 2
            show()
            self.pageControl.currentPage = 2
        }
        else  if viewController is ProgramAgreementSlider2 {
            currIndex = 1
            show()

            self.pageControl.currentPage = 1
            
        } else {
            currIndex = 0
            show()

            self.pageControl.currentPage = 0
        }
        
        if currIndex == 3 {
            hideBottomView()

        } else {
            show()
        }

        if currIndex == 0 || currIndex == NSNotFound {
            return nil
        }
        currIndex = currIndex - 1
        return viewControllerAtIndex(tempIndex: currIndex)
    }
}

