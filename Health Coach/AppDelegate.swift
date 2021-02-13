//
//  AppDelegate.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 13/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import Firebase
import Crashlytics
import Fabric
import GrowingTextView
import UserNotifications

@available(iOS 13.0, *)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var indexSelect : Int?
    var previousIndex : Int?
    var selectGoal : String?
    var responseObj: UserResponse?
    var token = UserDefaults.standard
    var badgeCount  = 0
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UITextViewWorkaround.executeWorkaround()

         if #available(iOS 13.0, *) {
             window?.overrideUserInterfaceStyle = .light
             
         } else {
             // or use some work around
         }
//
        application.applicationIconBadgeNumber = 0
        SKSocketConnection.socketSharedConnection.connectSocket()
        IQKeyboardManager.shared.enable = true
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setForegroundColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0))
        SVProgressHUD.setBackgroundColor(UIColor.white)
                
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        registerForPushNotifications(application: application)
        
        application.registerForRemoteNotifications()


        // Override point for customization after application launch.
        return true
    }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            self.badgeCount += 1
            UserDefaults.standard.set(self.badgeCount, forKey: "Notification")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationReceive"), object : nil, userInfo : nil)
            print("GOT A NOTIFICATION")

            completionHandler([.alert, .badge, .sound])

            
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
            
            print("GOT A New  NOTIFICATION")
        }

        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            application.applicationIconBadgeNumber += 1
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationTap"), object : nil, userInfo : nil)

    //        notificationType

        }

        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            //        let device_token = String(format: "%@", deviceToken as CVarArg) as String
            print(tokenString(deviceToken))
            DEVICE_TOKEN = tokenString(deviceToken)
            print ("device token is",UserDefaults.standard.string(forKey: "deviceToken")!)
            UserDefaults.standard.set(DEVICE_TOKEN, forKey: "device_token")
        }
        
        
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            //        SharedHelper.showAlertView(title: "Error", message: error.localizedDescription)
            print("Failed to register:", error)
            DEVICE_TOKEN = "e34ac7eb71a895f24ce2139ffb1c70d9364702cc6afc7bfa9a4a31b45b474e3e"
            UserDefaults.standard.set(DEVICE_TOKEN, forKey: "device_token")
        }
        
        func tokenString(_ deviceToken:Data) -> String{
            //code to make a token string
            let bytes = [UInt8](deviceToken)
            var token = ""
            for byte in bytes{
                token += String(format: "%02x",byte)
            }
            self.token.set(token, forKey: "deviceToken")
            //        UserDefaults.set(token, forKey: "deviceToken")
            return token
        }
        
        //for remote notifcations
        func registerForPushNotifications(application: UIApplication) {
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                center.delegate = self
                center.requestAuthorization(options: [.badge, .alert , .sound]) {[unowned self] (greanted, error) in
                    if greanted {
                        DispatchQueue.main.async {
                            application.registerForRemoteNotifications()
                        }
                        UIApplication.shared.registerForRemoteNotifications();
                    }
                }
            } else {
                let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound];
                let setting = UIUserNotificationSettings(types: type, categories: nil);
                UIApplication.shared.registerUserNotificationSettings(setting);
                //            Defaults.set("-1", forKey: "deviceToken")
                UIApplication.shared.registerForRemoteNotifications();
            }
        }
}


@objc
class UITextViewWorkaround : NSObject {

    static func executeWorkaround() {
        if #available(iOS 13.2, *) {
        } else {
            let className = "_UITextLayoutView"
            let theClass = objc_getClass(className)
            if theClass == nil {
                let classPair: AnyClass? = objc_allocateClassPair(UIView.self, className, 0)
                objc_registerClassPair(classPair!)
            }
        }
    }

}
