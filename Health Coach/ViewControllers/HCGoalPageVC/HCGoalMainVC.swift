//
//  HCGoalMainVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 02/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCGoalMainVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var previousVC: UIViewController?
    var showingIndex: Int = 0
    var pageVC: UIPageViewController?
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var btnBack : UIButton!
    @IBOutlet var titleOfScreen : UILabel!
    
    var isComeFromSignUpOrMain : String?

    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isComeFromSignUpOrMain == "main" {
            titleOfScreen.text = "Program Guide"
        } else {
            titleOfScreen.text = "Intro"

        }
        setPager()
        
        self.view.bringSubviewToFront(viewBottom)
        self.view.bringSubviewToFront(titleOfScreen)
        self.view.bringSubviewToFront(btnBack)
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width ,height: 30))
        self.pageControl.numberOfPages = 5
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 1.0
        self.pageControl.tintColor = UIColor.lightGray

//        self.pageControl.tintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMainPagerVC1" ) as! HCMainPagerVC1
            if  appDelegate.selectGoal == "1" {
                vc.selectGoalTitle = "Fat loss"
                vc.selectDescription = "Do you wanna feel amazing? Lose the fats you always want to get rid of and live a more balanced healthier life? If yes, you are in the right place. \nWe are here to help you live well and feel amazing! What you need to know Here’s something you need to know about Fat Loss. Don’t start with Diet and Exercise. \nSacrificing the food you love to eat and garnishing will power to do exercises you don’t enjoy are all not sustainable.\n You probably have tried dieting to improve your health condition and either it’s not bringing you results, or you have given up trying.\n Starting from diet is a wrong place to begin"
                vc.selectImage = "fatloss"
                

            } else if appDelegate.selectGoal == "2" {
                vc.selectGoalTitle = "Sleep disorder"
                vc.selectDescription = "Here is something you need to know about sleep. Did you know that people who sleep 7-8 hrs/noc differ in their diets, compared to those who sleep less or more? And that gluten in food can affect your sleep? Nutritional factors play an important role in determining whether you are getting a good night sleep. And so does the other influencers like your fitness level, stress levels and environment etc."
                vc.selectImage = "sleep"

            } else if appDelegate.selectGoal == "3" {
                vc.selectGoalTitle = "Stress managnment"
                vc.selectDescription = "Stress is a normal reaction to exciting events like falling in love, getting a new job, or buying a home. Stress is also a hardwired survival technique built into your body as a means of protection. When triggers arise, the sympathetic nervous system (SNS) signals the “fight or flight response”, which mobilizes you to take action and avoid danger. The issue is that your body doesn’t know the difference between a bear chasing you and work-related anxiety.Your body’s stress response is perfectly health when there’s a real emergency (like a bear chase), but it your body is constantly getting stress signals for everyday issues (work-related anxiety), you’ll burn out over time. Stress levels are not only affected by your environment and surroundings or from your relationships. They are also affected by the foods that you take. Very often many of us are getting too few essential nutrients necessary for optimum cellular nutrition. This has impact on our nervous system which has influence on how we cope or response to stress"
                vc.selectImage = "stress"

            }
            
            else if appDelegate.selectGoal == "4" {
                vc.selectGoalTitle = "Increase Energy"
                vc.selectDescription = "Our energy levels are affected by a number of things. \n The quality of our sleep, the type of food that we eat, our fitness level, emotional health and our state of mind just to name a few. \n Often our low energy levels are affected by a combination of these factors. \n It may also be attributed to a prevailing health issue like adrenal fatigue. \n If you are stressed out daily, conscious or unconsciously, your adrenals In order to raise your energy levels for good, we need to identify what is the root cause of the issue. \n We will then address the most prevailing cause 1st while taking steps to improve the other aspects that contribute to your low energy levels.  The key is to identify the major cause/causes and work back to resolve your low energy levels at the root of the issue."
                vc.selectImage = "energy"

                
            }  else if appDelegate.selectGoal == "5" {
                vc.selectGoalTitle = "Harmone Balance"
                vc.selectDescription = "Our energy levels are affected by a number of things. \n The quality of our sleep, the type of food that we eat, our fitness level, emotional health and our state of mind just to name a few. \n Often our low energy levels are affected by a combination of these factors. \n It may also be attributed to a prevailing health issue like adrenal fatigue. \n If you are stressed out daily, conscious or unconsciously, your adrenals In order to raise your energy levels for good, we need to identify what is the root cause of the issue. \n We will then address the most prevailing cause 1st while taking steps to improve the other aspects that contribute to your low energy levels.  The key is to identify the major cause/causes and work back to resolve your low energy levels at the root of the issue."
                vc.selectImage = "hormone"

            }
            
            vc.index = 0
            return vc
        } else if tempIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMainPagerVC2" ) as! HCMainPagerVC2
            vc.index = 1
            if  appDelegate.selectGoal == "1" {
            vc.selectTitle = "Fat loss"
            vc.selectDescription = "Start by understanding your body 1st. Our bodies are affected by our microbiome, stress, inflammation, genetics, and lifestyle. First  how they all play an important role in your health and how they are affecting whatever health issue you may be struggling with. It is important to address your weight issue at its roots. So you not only lose fats but also improve your overall health at the same time. Two important things to know about the Fat Loss program before you get started."
                vc.selectImage = "fatloss"
            } else if appDelegate.selectGoal == "2" {
                vc.selectTitle = "Sleep disorder"
                vc.selectDescription = "Here is something you need to know about sleep. Did you know that people who sleep 7-8 hrs/noc differ in their diets, compared to those who sleep less or more? And that gluten in food can affect your sleep? Nutritional factors play an important role in determining whether you are getting a good night sleep. And so does the other influencers like your fitness level, stress levels and environment etc."
                vc.selectImage = "sleep"

            } else if appDelegate.selectGoal == "3" {
                vc.selectTitle = "Stress managnment"
                vc.selectDescription = "It is important then to understand how your body work. Our bodies are affected by our microbiome, stress, inflammation, genetics, and lifestyle. You will need to 1st understand how they all play an important role in your health and how they are affecting whatever health issue you may be struggling with. For example, eating certain foods will raise your cortisol levels (stress hormone) so you don’t want this to be elevated all the time. This will not only drain your energy levels leaving you feeling tired but in the longer term it may also contribute to health issues like organ related diseases. Two important things to know about the Stress Free for life program before you get started."
                vc.selectImage = "stress"

            } else if appDelegate.selectGoal == "4" {
                    vc.selectTitle = "Increase Energy"
                    vc.selectDescription = "Start by understanding your body 1st. Our bodies are affected by our microbiome, stress, inflammation, genetics, and lifestyle.\n . First how they all play an important role in your health and how they are affecting whatever health issue you may be struggling with. You may not only address your low energy issue but also address other health issues that are interrelated. \n Two important things to know about the Energy for life program before you get started."
                vc.selectImage = "energy"

            }   else if appDelegate.selectGoal == "5" {
                vc.selectTitle = "Harmone Balance"
                vc.selectDescription = "Start by understanding your body 1st. Our bodies are affected by our microbiome, stress, inflammation, genetics, and lifestyle.\n  First how they all play an important role in your health and how they are affecting whatever health issue you may be struggling with. You may not only address your low energy issue but also address other health issues that are interrelated. \n Two important things to know about the Energy for life program before you get started."
                vc.selectImage = "hormone"

            }
            return vc
        }
        else if tempIndex == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMainPagerVC3" ) as! HCMainPagerVC3
            vc.index = 2
            if  appDelegate.selectGoal == "1" {
            vc.selectTitle = "Fat loss"
            vc.selectDescription = "Don’t lose those precious body compositions First our program is termed Fat Loss and not weight loss because we want you to retain those precious muscles, bones and other essential body composition that keeps your body functional. \nThis is our differentiation. Not promoting weight loss at the expense of your health. \nThat is the reason why measuring your body composition with the digital scale is important to track that you are losing those unwanted fats while keeping those precious body parts! Your health coach and you will work with you to maximize fat loss and keeping what’s important as much as possible."
                vc.selectImage = "fatloss"

                
            } else if appDelegate.selectGoal == "2" {
                vc.selectTitle = "Sleep disorder"
                vc.selectDescription = "Optimising body compositions eliminating stress What you consume and the nutrients your body is receiving play an important role in regulating your stress hormones. \nIf you have high fat level and your body composition is not optimal, chances are your intake of food is not wholesome and probably not nutritious. \nThis is why tracking and monitoring your body composition gives you an indication of how you are doing with the foods you are consuming. Using your body composition scale measures your fat, muscle, bone, water composition among other things. \nYour health coach and you will work with you to maximize fat loss and keeping what’s important as much as possible. \nA personalized program designed for you by your health coach will prioritise what issues to address first so you are not overworking your stress hormones"
                vc.selectImage = "sleep"

            } else if appDelegate.selectGoal == "3" {
                vc.selectTitle = "Stress managnment"
                vc.selectDescription = "Optimising body compositions eliminating stress What you consume and the nutrients your body is receiving play an important role in regulating your stress hormones. \nIf you have high fat level and your body composition is not optimal, chances are your intake of food is not wholesome and probably not nutritious. \nThis is why tracking and monitoring your body composition gives you an indication of how you are doing with the foods you are consuming. Using your body composition scale measures your fat, muscle, bone, water composition among other things. \nYour health coach and you will work with you to maximize fat loss and keeping what’s important as much as possible. \nA personalized program designed for you by your health coach will prioritise what issues to address first so you are not overworking your stress hormones"
                vc.selectImage = "stress"

            } else if appDelegate.selectGoal == "4" {
                vc.selectTitle = "Increase Energy"
                vc.selectDescription = "Optimising body compositions improve energy What you consume and the nutrients your body is receiving play an important role in regulating your energy levels. If you have high fat level and your body composition is not optimal, chances are your intake of food is not wholesome and probably not nutritious. \nThis is why tracking and monitoring your body composition gives you an indication of how you are doing with the foods you are consuming.\n Using your body composition scale measures your fat, muscle, bone, water composition among other things. Your health coach and you will work with you to maximize fat loss and keeping what’s important as much as possible. A personalized program designed for you by your health coach will prioritise what issues to address first to improve your energy levels."
                vc.selectImage = "energy"

            }  else if appDelegate.selectGoal == "5" {
                vc.selectTitle = "Harmone Balance"
                vc.selectDescription = "Optimising body compositions improve energy What you consume and the nutrients your body is receiving play an important role in regulating your energy levels. If you have high fat level and your body composition is not optimal, chances are your intake of food is not wholesome and probably not nutritious. \nThis is why tracking and monitoring your body composition gives you an indication of how you are doing with the foods you are consuming.\n Using your body composition scale measures your fat, muscle, bone, water composition among other things. Your health coach and you will work with you to maximize fat loss and keeping what’s important as much as possible. A personalized program designed for you by your health coach will prioritise what issues to address first to improve your energy levels."
                vc.selectImage = "hormone"

            }
            return vc
        } else if tempIndex == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMainPagerVC4" ) as! HCMainPagerVC4
            vc.index = 3
            if  appDelegate.selectGoal == "1" {

            vc.selectTitle = "Fat loss"
            vc.selectDescription = "Take care of yourself the right way and lose fats The next important component in the program is for the health coach to guide you in taking care of yourself the right way. Taking care of yourself is more than just micromanaging your nutrition and fitness, it’s a full spectrum of wellness you need to nurture. Understanding how your body is affected by your genetics, hormones, environment, state of your emotional and mental well-being is the 1st step to understanding why you feel the way you do."
           vc.selectImage = "fatloss"

                

            } else if appDelegate.selectGoal == "2" {
                vc.selectTitle = "Sleep disorder"
                vc.selectDescription = "Take care of yourself the right way and be stress free The next important component in the program is for the health coach to guide you in taking care of yourself the right way. \nTaking care of yourself is more than just micromanaging your nutrition and fitness, it’s a full spectrum of wellness you need to nurture. \nUnderstanding how your body is affected by your genetics, hormones, environment, state of your emotional and mental well-being is the 1st step to understanding why you feel the way you do."
                vc.selectImage = "sleep"

                
            } else if appDelegate.selectGoal == "3" {
                vc.selectTitle = "Stress managnment"
                vc.selectDescription = "Take care of yourself the right way and be stress free The next important component in the program is for the health coach to guide you in taking care of yourself the right way. \nTaking care of yourself is more than just micromanaging your nutrition and fitness, it’s a full spectrum of wellness you need to nurture. \nUnderstanding how your body is affected by your genetics, hormones, environment, state of your emotional and mental well-being is the 1st step to understanding why you feel the way you do."
                vc.selectImage = "stress"

                
            } else if appDelegate.selectGoal == "4" {
                vc.selectTitle = "Increase Energy"
                vc.selectDescription = "Take care of yourself the right way and increase your energy The next important component in the program is for the health coach to guide you in taking care of yourself the right way. Taking care of yourself is more than just micromanaging your nutrition and fitness, it’s a full spectrum of wellness you need to nurture. Understanding how your body is affected by your genetics, hormones, environment, state of your emotional and mental well-being is the 1st step to understanding why you feel the way you do."
                vc.selectImage = "energy"

            } else if appDelegate.selectGoal == "5" {
                vc.selectTitle = "Harmone Balance"
                vc.selectDescription = "Take care of yourself the right way and increase your energy The next important component in the program is for the health coach to guide you in taking care of yourself the right way. Taking care of yourself is more than just micromanaging your nutrition and fitness, it’s a full spectrum of wellness you need to nurture. Understanding how your body is affected by your genetics, hormones, environment, state of your emotional and mental well-being is the 1st step to understanding why you feel the way you do."
                vc.selectImage = "hormone"

            }
            
            
            return vc
        } else  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMainPagerVC5" ) as! HCMainPagerVC5
            vc.isComeFromWhichScreen = isComeFromSignUpOrMain
            vc.index = 4
            if  appDelegate.selectGoal == "1" {
            vc.selectTitle = "Fat loss"
            vc.selectDescription = "Next will be to understand and be mindful how your relationships have an influence on your emotional well being. This has impact on your bio environment and your body composition which will affect how your body store fats. The ultimate goal Our goal is for you to live mindfully, have fun, eat well developing a good relationship with food and ultimately feel amazing. We adopt the full spectrum of wellness that will help you live healthy and happy"
                
                vc.selectImage = "fatloss"

            }  else if appDelegate.selectGoal == "2" {
                vc.selectTitle = "Sleep disorder"
                vc.selectDescription = "Next will be to understand and be mindful how your relationships have an influence on your emotional well being. \nThis has impact on your bio environment and your body composition which affects how your sleep hormones are being regulated. \nThe ultimate goal Our goal is for you to live mindfully, have fun, eat well developing a good relationship with food and ultimately feel amazing. We adopt the full spectrum of wellness that will help you live healthy and happy."
                vc.selectImage = "sleep"

            } else if appDelegate.selectGoal == "3" {
                vc.selectTitle = "Stress managnment"
                vc.selectDescription = "Next will be to understand and be mindful how your relationships have an influence on your emotional well being. \nThis has impact on your bio environment and your body composition which indirectly translates to how the stress hormones in your body are being regulated. \nThe ultimate goal Our goal is for you to live mindfully, have fun, eat well developing a good relationship with food and ultimately feel amazing. Improving stress levels is only one aspect of your health. Your health has to be addressed holistically so you not only reduce your stress levels but address the full spectrum of wellness so you can live healthy and happy."
                vc.selectImage = "stress"

                
            } else if appDelegate.selectGoal == "4" {
                vc.selectTitle = "Increase Energy"
                vc.selectDescription = "Next will be to understand and be mindful how your relationships have an influence on your emotional well being. \nThis has impact on your bio environment and your body composition which indirectly translates to how the energy levels in your body are being regulated. \nThe ultimate goal Our goal is for you to live mindfully, have fun, eat well developing a good relationship with food and ultimately feel amazing. \nImproving energy levels is only one aspect of your health. Your health has to be addressed holistically so you not only increase your energy levels but address the full spectrum of wellness so you can live healthy and happy\n"
                vc.selectImage = "energy"

            } else if appDelegate.selectGoal == "5" {
                vc.selectTitle = "Harmone Balance"
                vc.selectDescription = "Next will be to understand and be mindful how your relationships have an influence on your emotional well being. \nThis has impact on your bio environment and your body composition which indirectly translates to how the energy levels in your body are being regulated. \nThe ultimate goal Our goal is for you to live mindfully, have fun, eat well developing a good relationship with food and ultimately feel amazing. \nImproving energy levels is only one aspect of your health. Your health has to be addressed holistically so you not only increase your energy levels but address the full spectrum of wellness so you can live healthy and happy\n"
                vc.selectImage = "hormone"

            }
            
            return vc
            
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
@available(iOS 13.0, *)

extension HCGoalMainVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currIndex: Int = 0
        if viewController is HCMainPagerVC1 {
            currIndex = 0
            self.pageControl.currentPage = 0
            
        }  else if  viewController is HCMainPagerVC2 {
            currIndex = 1
            self.pageControl.currentPage = 1
        } else if  viewController is HCMainPagerVC3 {
            currIndex = 2
            self.pageControl.currentPage = 2
            
            
        }else if  viewController is HCMainPagerVC4 {
            currIndex = 3
            self.pageControl.currentPage = 3
            
            
        } else if  viewController is HCMainPagerVC5 {
            currIndex = 4
            self.pageControl.currentPage = 4
        }
        if currIndex == NSNotFound {
            return nil
        }
        currIndex = currIndex + 1
        if currIndex == 5 {
            return nil
        }
        
        let vc = viewControllerAtIndex(tempIndex: currIndex)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var currIndex: Int = 0
         if viewController is HCMainPagerVC5 {
            currIndex = 4
            self.pageControl.currentPage = 4
            
        }else if viewController is HCMainPagerVC4 {
            currIndex = 3
            self.pageControl.currentPage = 3
            
        } else if viewController is HCMainPagerVC3 {
            currIndex = 2
            self.pageControl.currentPage = 2
        }else if viewController is HCMainPagerVC2 {
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

