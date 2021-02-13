//
//  BLIntoViewController.swift
//  blink
//
//  Created by Ahmed Durrani on 01/11/2017.
//  Copyright © 2017 blink_APP. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class BLIntoViewController: UIViewController  {
    var previousVC: UIViewController?
    var showingIndex: Int = 0
    var pageVC: UIPageViewController?
    @IBOutlet var viewBottom: UIView!
    var pageControl = UIPageControl()
    let nc = NotificationCenter.default
    let nc1 = NotificationCenter.default
    let nc2 = NotificationCenter.default
    let nc3 = NotificationCenter.default

    @IBOutlet weak var btnPrev: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        btnPrev.isHidden = true
//        self.automaticallyAdjustsScrollViewInsets = false
        setPager()
        nc.addObserver(self, selector: #selector(BLIntoViewController.hideBottomView), name: Notification.Name("IsBottomView"), object: nil)
        nc1.addObserver(self, selector: #selector(BLIntoViewController.showBottomView), name: Notification.Name("isHide"), object: nil)
        nc2.addObserver(self, selector: #selector(BLIntoViewController.hideButton), name: Notification.Name("isButtonHide"), object: nil)
        nc3.addObserver(self, selector: #selector(BLIntoViewController.showButton), name: Notification.Name("isShowPreButton"), object: nil)
        configurePageControl()

        
        self.view.bringSubviewToFront(viewBottom)
    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//        
//    }
    
    @objc func hideBottomView() {
        viewBottom.isHidden = true
    }
    
    @objc func showBottomView() {
        viewBottom.isHidden = false
    }
    
    @objc func hideButton() {
        btnPrev.isHidden = true
    }
    

    @objc func showButton() {
        btnPrev.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configurePageControl() {
       pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 40,width: UIScreen.main.bounds.width,height: 20))
       self.pageControl.numberOfPages = 6
        self.pageControl.currentPage = 0
       self.pageControl.alpha = 1.0
       self.pageControl.tintColor = UIColor.white
      self.pageControl.pageIndicatorTintColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
      self.pageControl.currentPageIndicatorTintColor = UIColor.white
      self.view.addSubview(pageControl)
    }
    
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        
        let startVC = viewControllerAtIndex(tempIndex: appDelegate.indexSelect!)
        _ = startVC.view
        self.pageControl.currentPage = appDelegate.indexSelect!
        pageVC?.setViewControllers([startVC], direction: .forward , animated: true, completion: nil)
        
    }
    
    @IBAction func btnPrevious_Pressed(_ sender: UIButton) {
        let startVC = viewControllerAtIndex(tempIndex: appDelegate.previousIndex!)
        _ = startVC.view
        self.pageControl.currentPage = appDelegate.previousIndex!

        pageVC?.setViewControllers([startVC], direction: .reverse , animated: true, completion: nil)
    }
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
//        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.NEXTPAGER)
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KHCLogin)
    }
//
    
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageViewControllerForSignUp") as! UIPageViewController?
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
    
    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
      
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntoViewController1" ) as! IntoViewController1
            vc.index = 0
          //  showingIndex = 0
//            self.pageControl.currentPage = 1
//            self.pageControl.alpha = 0.5

            return vc
        }else if tempIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntoViewController2" ) as! IntoViewController2
            vc.index = 1
//            self.pageControl.currentPage = 2
//            self.pageControl.alpha = 0.5

//            showingIndex = 1
            return vc
        }
        else if tempIndex == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntoViewController3" ) as! IntoViewController3
            vc.index = 2
//            showingIndex = 2
//            self.pageControl.currentPage = 3
//            self.pageControl.alpha = 0.5


            return vc
        } else if tempIndex == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntoViewController4" ) as! IntoViewController4
            vc.index = 3
//            showingIndex = 3
//            self.pageControl.currentPage = 4
//            self.pageControl.alpha = 0.5


            return vc
        } else if tempIndex == 4  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntoViewController5" ) as! IntoViewController5
            vc.index = 4
//            showingIndex = 4
//            self.pageControl.currentPage = 5
//            self.pageControl.alpha = 0.5

            return vc

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController6" ) as! IntroViewController6
            vc.index = 5
//            showingIndex = 5
//            self.pageControl.currentPage = 5
            
            return vc

        }
    }
}

@available(iOS 13.0, *)
extension BLIntoViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            var currIndex: Int = 0
            if viewController is IntoViewController1 {
                currIndex = 0
                self.pageControl.currentPage = 0

            }  else if  viewController is IntoViewController2 {
                currIndex = 1
                self.pageControl.currentPage = 1
            } else if  viewController is IntoViewController3 {
                currIndex = 2
                self.pageControl.currentPage = 2

                
            }else if  viewController is IntoViewController4 {
                currIndex = 3
                self.pageControl.currentPage = 3

                
            }else if  viewController is IntoViewController5 {
                currIndex = 4
                self.pageControl.currentPage = 4

                
            }else if  viewController is IntroViewController6 {
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

//            if viewController is IntoViewController1 {
//                currIndex = (viewController as! IntoViewController1).index!
//
//            }else if viewController is IntoViewController2 {
//                currIndex = (viewController as! IntoViewController2).index!
//            } else if viewController is IntoViewController3 {
//                currIndex = (viewController as! IntoViewController3).index!
//            }else if viewController is IntoViewController4 {
//                currIndex = (viewController as! IntoViewController4).index!
//            } else if viewController is IntoViewController5 {
//                currIndex = (viewController as! IntoViewController5).index!
//            } else if viewController is IntroViewController6 {
//                currIndex = (viewController as! IntroViewController6).index!
//
//            }
//            if currIndex == NSNotFound {
//                return nil
//            }
//
//            currIndex = currIndex + 1
//            if currIndex == 6 {
//                return nil
//            }
//            let vc = viewControllerAtIndex(tempIndex: currIndex)
//            return vc
    
        }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
            var currIndex: Int = 0
            if viewController is IntroViewController6 {
                currIndex = 5
                self.pageControl.currentPage = 5

            }
           else  if viewController is IntoViewController5 {
                currIndex = 4
                self.pageControl.currentPage = 4

            }else if viewController is IntoViewController4 {
                currIndex = 3
                self.pageControl.currentPage = 3

            } else if viewController is IntoViewController3 {
                currIndex = 2
                self.pageControl.currentPage = 2
            }else if viewController is IntoViewController2 {
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
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 4
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
   
    
}

