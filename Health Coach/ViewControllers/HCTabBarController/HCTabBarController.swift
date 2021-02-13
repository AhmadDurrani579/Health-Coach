//
//  HCTabBarController.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)

class HCTabBarController: UITabBarController  , UITabBarControllerDelegate{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selected_index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.addNotification(_:)), name: NSNotification.Name(rawValue: "notificationReceive"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.removeNotification), name: NSNotification.Name(rawValue: "removeNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tapNotification), name: NSNotification.Name(rawValue: "notificationTap"), object: nil)
        
        let subscribe = UserDefaults.standard.bool(forKey: "subscribe")
        if subscribe == true {
             showCoachIcon()
         } else {
            showBookingIcon()
        }

        let badgeCount = UserDefaults.standard.integer(forKey: "Notification")
        if badgeCount != 0 {
            self.tabBar.items![3].badgeValue = "\(badgeCount)"
        } else {
            self.tabBar.items![3].badgeValue = nil
        }
   
  }
    
    @objc func addNotification(_ notification: NSNotification) {
        let badgeCount = UserDefaults.standard.integer(forKey: "Notification")
          if badgeCount != 0 {
                self.tabBar.items![3].badgeValue = "\(badgeCount)"
          } else {
                self.tabBar.items![3].badgeValue = nil
        }

    }
    
    @objc func removeNotification(_ notification: NSNotification) {
//        let badgeCount = UserDefaults.standard.integer(forKey: "Notification")
        self.tabBar.items![3].badgeValue = nil
    }
    
    @objc func tapNotification(_ notification: NSNotification) {
    //        let badgeCount = UserDefaults.standard.integer(forKey: "Notification")
        //            self.tabBar.items![3].badgeValue = nil
//        tabBarController?.tabBar.selectedItem[]
//        self.selected_index = 3
//        self.tabBarController?.selectedIndex = 3
//        self.tabBarController.tabBar(self, didSelect: self.tabBarItem)
//        self.tabBar(self.tabBar, didSelect: self.tabBarItem)
    }


    func showBookingIcon() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Montserrat", size: 13)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        let selectedColor   = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
        let unselectedColor = UIColor.lightGray
        
        self.tabBar.items![3].selectedImage = UIImage(named:"mailS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![3] ).image = UIImage(named:"mailUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![2].selectedImage = UIImage(named:"notificationS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![2] ).image = UIImage(named:"notificationUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![0].selectedImage = UIImage(named:"chronometerS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![0] ).image = UIImage(named:"chronometerUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![1].selectedImage = UIImage(named:"booking")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![1] ).image = UIImage(named:"calenderUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![1].title = "Booking"
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
    
    func showCoachIcon() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Montserrat", size: 13)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        let selectedColor   = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
        let unselectedColor = UIColor.lightGray
        //        booking
                
        self.tabBar.items![3].selectedImage = UIImage(named:"mailS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![3] ).image = UIImage(named:"mailUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![2].selectedImage = UIImage(named:"notificationS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![2] ).image = UIImage(named:"notificationUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![0].selectedImage = UIImage(named:"chronometerS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![0] ).image = UIImage(named:"chronometerUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![1].selectedImage = UIImage(named:"analystS")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![1] ).image = UIImage(named:"analystTabUn")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![1].title = "My Coach"

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)

    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Ahmad")
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        selected_index = 3
    }

}
