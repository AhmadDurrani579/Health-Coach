//
//  UtilityHelper.swift
//  SampleProject
//
//  Created by Zeeshan Haider on 01/03/2016.
//  Copyright © 2016 DevBatch. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import SystemConfiguration

/**
 A wrapper around GCD queues. This shouldn't be accessed directly, but rather through
 the helper functions supplied by the APSwiftHelpers package.
 */

// Swift 3.0 Help from https://swiftable.io/2016/06/dispatch-queues-swift-3/
public enum QueueType {
    case Main
    case Background
    case LowPriority
    case HighPriority
    
    var queue: DispatchQueue {
        switch self {
        case .Main:
            return DispatchQueue.main
        case .Background:
            return DispatchQueue(label: "com.app.queue",
                                 qos: .background,
                                 target: nil)
        case .LowPriority:
            return DispatchQueue.global(qos: .userInitiated)
        case .HighPriority:
            return DispatchQueue.global(qos: .userInitiated)
        }
    }
}

class UtilityHelper
{
    // MARK: - UIAlertViewController (called from UIViewController)
    
    /**
     * Usage: Helpers.showOKAlert("Alert", message: "Something happened", target: self)
     */
    static func showOKAlert(_ title: String, message: String, target: UIViewController)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Usage: Helpers.showOKHelpAlert("Notice", message: "Something happened.", target: self, handler: { (UIAlertAction) -> Void in
     *          // perform help option code here
     *     })
     */
    static func showOKHelpAlert(_ title: String, message: String, target: UIViewController, handler: ((UIAlertAction) -> Void)?)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let helpAction: UIAlertAction = UIAlertAction(title: "Help", style: .default, handler: handler)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(helpAction)
        alertController.addAction(okAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Usage: Helpers.showContinueAlert("Log Out", message: "Are you sure you want to log out?", target: self, handler: { (UIAlertAction) -> Void in
     *          // perform log out code here
     *     })
     */
    static func showContinueAlert(_ title: String, message: String, target: UIViewController, handler: ((UIAlertAction) -> Void)?)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let continueAction: UIAlertAction = UIAlertAction(title: "Continue", style: .default, handler: handler)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UIActionSheet (TODO)
    
    // MARK: - Localization
    
    static func getFormattedStringFromNumber(_ number: Double) -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value : number))!
    }
    
    static func getFormattedStringFromDate(_ aDate: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: aDate)
    }
    
    // MARK: - Set Up Application UI Appearance
    class func setupApplicationUIAppearance() {
//        UILabel.appearance().setSubstituteFontName(UIConfiguration.UIFONTAPP)
//        let titleTextAttributeTabBarItem:[String:AnyObject] = [
//            NSForegroundColorAttributeName : UIColor.white,
//            NSFontAttributeName : UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 17)
//        ]
//        UITabBarItem.appearance().setTitleTextAttributes(titleTextAttributeTabBarItem, for: UIControlState())
//        UINavigationBar.appearance().barStyle = .black
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIConfiguration.getUIFONTBOLD(sizeFont: 17)]
//        
//        
//        
//        let titleTextAttributeBarButtonItem:[String:AnyObject] = [
//            NSForegroundColorAttributeName : UIColor.white,
//            NSFontAttributeName : UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 16)
//        ]
//        if #available(iOS 9.0, *) {
//            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes(titleTextAttributeBarButtonItem, for: UIControlState())
//        } else {
//            // Fallback on earlier versions
//        }
//        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSTextEffectAttributeName: UIColor.white, NSFontAttributeName: UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 16)], for: .normal)
//        
//        let rect:CGRect! = CGRect(x: 0 ,y: 0, width: Constants.getApplicationDelegate().window!.frame.size.width, height: 64)
//        UIGraphicsBeginImageContext(rect.size)
//        let context: CGContext = UIGraphicsGetCurrentContext()!
//        context.setFillColor(UIConfiguration.MainNavBackColor.cgColor)
//        context.fill(rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        UINavigationBar.appearance().setBackgroundImage(image, for: UIBarMetrics.default)
        
    }
    // MARK: - Validations
    
    class func isValidEmailAddress(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
//    class func isValidateNumber(_ checkString: NSString) -> Bool {
//        let numcharacters: CharacterSet = CharacterSet(charactersIn: Constants.getValidate_Numeric())
//        var characterCount: Int32 = 0
//        //        var i: Int
//        for i in 0 ..< checkString.length {
//            let character: unichar = checkString.character(at: i)
//            if !numcharacters.contains(UnicodeScalar(character)!) {
//                characterCount += 1
//            }
//        }
//        if characterCount == 0 {
//            return true
//        } else {
//            return false
//            
//        }
//    }
    
    class func isValidateSaudiaNumber(_ checkString: NSString) -> Bool {
        //+966126123100
        //http://regexlib.com/Search.aspx?k=saudi&c=-1&m=-1&ps=20
        //https://gist.github.com/homaily/8672499
        //https://regex101.com
        let numcharacters: CharacterSet = CharacterSet(charactersIn: "^(009665|9665|+9665|05|+966)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})")
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
   
    
    
    class func isValidateAlphabet(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidateAlphabetWithWhiteSpace(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        var characterCount: Int32 = 0
        //        var i: Int
        
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidStringNumericPlus(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: "0123456789+")
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    // MARK: - Get Preferred Language
    
    class func getPrefferedLanguage() -> String {
        for languageItem in Locale.preferredLanguages {
            if languageItem == "en" || languageItem == "ru" || languageItem == "uk" || languageItem == "de" || languageItem == "fr" || languageItem == "it" || languageItem == "es" || languageItem == "ar" {
                return languageItem
            }
        }
        return "en"
    }
    // MARK: - Dynamic Heights
    
    class func getTextDymanicHeightOfStringWithText(_ text: NSString, andFont font: UIFont, andFrame frame: CGRect) -> CGFloat {
        let maxSize: CGSize = CGSize(width: frame.size.width, height: 999999.0)
        var height: CGFloat = 0
        
        let frame1: CGRect = text.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        height = frame1.size.height
        return height+5
    }
    
    class func getLabelDymanicHeight(_ label: UILabel) -> CGFloat {
        let maxSize: CGSize = CGSize(width: label.frame.size.width, height: 999999.0)
        var height: CGFloat = 0
        let font: UIFont = label.font
        
        let frame: CGRect = label.text!.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        height = frame.size.height
        label.numberOfLines = 0
        return height+5
    }
    
    class func getStringHeightWithConstrainedWidth(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    class func getAttributedStringHeightWithConstrainedWidth(_ attributedText: NSAttributedString, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = attributedText.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    class func getAttributedStringWidthWithConstrainedHeight(_ attributedText: NSAttributedString, height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = attributedText.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
    // MARK: - Date Conversions
    
    class func convertStringDate(_ date: String, formatFrom: String, formatTo: String) -> String {
        let dateString: String = date
        let dateFormatter: DateFormatter = DateFormatter()
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        dateFormatter.dateFormat = formatFrom
        var dateFromString: Date
        dateFromString = dateFormatter.date(from: dateString)!
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = formatTo
        //Optionally for time zone converstions
        formatter.timeZone = TimeZone(identifier: "...")
        let birthday: String = formatter.string(from: dateFromString)
        return birthday
    }
    
    class func convertDateToString(_ date: Date, withFormat Format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = Format
        let stringFromDate: String = formatter.string(from: date)
        return stringFromDate
    }
    
    class func convertStringToDate(_ date: String, formatFrom: String) -> Date {
        let myFormatter: DateFormatter = DateFormatter()
        myFormatter.timeZone = TimeZone.current
        //    [myFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:@"Gregorion"]];
        myFormatter.dateFormat = formatFrom
        let myDate: Date = myFormatter.date(from: date)!
        return myDate
    }
    
    // MARK: - UIView Related
    
    class func setViewBorder(_ yourView: UIView, withWidth borderWidth: CGFloat, andColor borderColor: UIColor, cornerRadius radius: CGFloat, andShadowColor shadowColor: UIColor, shadowRadius: CGFloat) {
        // border radius
        yourView.layer.cornerRadius = radius
        // border
        yourView.layer.borderColor = borderColor.cgColor
        yourView.layer.borderWidth = borderWidth
        // drop shadow
        yourView.layer.shadowColor = shadowColor.cgColor
        yourView.layer.shadowOpacity = 0.8
        yourView.layer.shadowRadius = shadowRadius
        yourView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    class func setViewBorder(_ view: UIView, withWidth width: CGFloat, andColor color: UIColor) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
    }
    
   
    
    

    class func setViewCornerRadius(_ view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    class func setViewBorderBottom(_ view: UIView, withWidth width: CGFloat, andColor color: UIColor) {
        view.layoutIfNeeded()
        let bottomBorder: CALayer = CALayer.init()
        bottomBorder.frame = CGRect(x: 0.0, y: view.frame.size.height-0.5, width: view.frame.size.width, height: 0.5)
        bottomBorder.backgroundColor = color.cgColor
        view.layer.addSublayer(bottomBorder)
        view.clipsToBounds = true
    }
    
    class func setViewBorderBottom(_ view: UIView, withWidth width: CGFloat, atDistanceFromBottom bottonY: CGFloat, andColor color: UIColor, clipToBounds: Bool) {
        view.layoutIfNeeded()
        let bottomBorder: CALayer = CALayer.init()
        /*
         UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, view.frame.size.height-bottonY, view.frame.size.width, width)];
         bottomBorder.backgroundColor = color;
         [view addSubview:bottomBorder];
         */
        bottomBorder.frame = CGRect(x: 0.0, y: view.frame.size.height-bottonY, width: view.frame.size.width, height: width)
        bottomBorder.backgroundColor = color.cgColor
        view.layer.addSublayer(bottomBorder)
        view.clipsToBounds = clipToBounds
    }
    
    class func setDropShadowOnView(_ view: UIView, shadowOffset: CGSize) {
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.7
        let shadowPath: CGPath = UIBezierPath(rect: view.layer.bounds).cgPath
        view.layer.shadowPath = shadowPath
    }
    
    class func setDropShadowOnTextField(_ view: UITextField, shadowOffset: CGSize) {
        view.borderStyle = UITextField.BorderStyle.none
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 4
        let shadowPath: UIBezierPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 3)
        view.layer.shadowPath = shadowPath.cgPath
    }
    // MARK: - Application Badge
    
    class func setApplicationBadgeNumber(_ number: Int) {
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    
    class func increaseApplicationBadgeNumberByOne() {
        let count: Int = UIApplication.shared.applicationIconBadgeNumber
        UIApplication.shared.applicationIconBadgeNumber = count+1
    }
    
    // MARK: -
    // MARK: Session Save
    // MARK: -
    
    class func saveSessionToDisk(_ Session: NSDictionary) {
        let dictionary: NSMutableDictionary = NSMutableDictionary(dictionary: Session)
        let archiveData: Data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [AnyObject]
        let documentsDir: NSString = paths[0] as! String as NSString
        let fullPath: NSString = documentsDir.appendingPathComponent("SavedSession.plist") as NSString
        try? archiveData.write(to: URL(fileURLWithPath: fullPath as String), options: [.atomic])
    }
    
    class func loadSessionFromDisk() -> NSDictionary? {
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [AnyObject]
        let documentsDir: NSString = paths[0] as! NSString
        let fullPath: String = documentsDir.appendingPathComponent("SavedSession.plist")
        print("\(fullPath)")
        let fileManager: FileManager = FileManager.default
        if fileManager.fileExists(atPath: fullPath) {
            var dict: NSDictionary? = nil
            let archiveData: Data = try! Data(contentsOf: URL(fileURLWithPath: fullPath))
            dict = (NSKeyedUnarchiver.unarchiveObject(with: archiveData) as? NSMutableDictionary)
            return dict
        }
        return nil
    }
    
    // MARK: - Key Window
    class func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
//    class func getAppWindow() -> UIWindow? {
//        let ad  = UIApplication.shared.delegate as! AppDelegate
//        return ad.window
//    }
    
  
    
    
    // MARK: - Array Form / Dictionary Form
    
    /*
     class MyClass {
     var property1 = 1
     var property2 = "Hi"
     }
     ArrayForm((0, 1, 2, 3))                 // [0, 1, 2, 3]
     ArrayForm(MyClass())                    // [1, "Hi"]
     */
    
    class func ArrayForm(_ value: Any) -> [Any] {
        var mirror: Mirror? = Mirror(reflecting: value)
        var propertyValues = [Any]()
        
        while let currentMirror = mirror {
            propertyValues += currentMirror.children.map { $0.value }
            
            // Get superclass if it exists
            mirror = currentMirror.superclassMirror
        }
        
        return propertyValues
    }
    
    
    /*
     class MyClass {
     var property1 = 1
     var property2 = "Hi"
     }
     DictionaryForm(MyClass())               // ["property1" : 1, "property2" : "Hi"]
     */
    
    class func DictionaryForm(_ value: Any) -> [String : Any] {
        var mirror: Mirror? = Mirror(reflecting: value)
        var objectDictionary = [String : Any]()
        
        while let currentMirror = mirror {
            for (propertyName, value) in currentMirror.children {
                if let key = propertyName { objectDictionary[key] = value }
            }
            
            // Get superclass if it exists
            mirror = currentMirror.superclassMirror
        }
        
        return objectDictionary
    }
    
    // MARK: - Measure height/width from String
    class func measureWidthForText(_ text:NSString?,font:UIFont)->CGFloat{
        if text != nil{
            let tmpLabel = UILabel(frame: CGRect.zero)
            tmpLabel.font = font
            tmpLabel.text = text as String?
            let size = tmpLabel.intrinsicContentSize.width
            return size
        }
        return 0
    }
    
    class func measureHeightForText(_ text:String,font:UIFont)->CGFloat{
        let tmpLabel = UILabel(frame: CGRect.zero)
        tmpLabel.font = font
        tmpLabel.text = text as String
        let size = tmpLabel.intrinsicContentSize.height
        return size
    }
    
    class func requiredHeightForLabelWith(_ width:CGFloat, font:UIFont, text:String) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    //    class func maxFontSizeForLabel(text:String,labelWidth:CGFloat,labelHeight:CGFloat, font:UIFont)->CGFloat{
    //        var fontSize = font.pointSize
    //        var currentHeight = requiredHeightForLabelWith(labelWidth, font: font, text: text)
    //        while currentHeight >= labelHeight{
    //            fontSize = fontSize - 1
    //            font = font.fontWithSize(fontSize)
    //            currentHeight = requiredHeightForLabelWith(labelWidth, font: font, text: text)
    //        }
    //        return fontSize
    //    }
    
    // MARK: - GCD
    /**
     Perform a block on the specified queue. This is just a nicer wrapper around the dispatch_async()
     Grand Central Dispatch function.
     - Parameter queueType:  The queue to execute the block on
     - Parameter closure:    The block to execute
     *Example usage:*
     ```
     performOn(.Main) { self.tableView.reloadData() }
     ```
     */
    class func performOn(_ queueType: QueueType, closure: @escaping () -> Void) {
        queueType.queue.async(execute: closure)
    }
    
    /**
     Perform a block on a queue after waiting the specified time.
     - Parameter delay:     Time to wait in seconds before performing the block
     - Parameter queueType: Queue to execute the block on (default is the main queue)
     - Parameter closure:   Block to execute after the time specified in delay has passed
     *Example usage:*
     ```
     // Wait for 200ms then run the block on the main queue
     delay(0.2) { alert.hide() }
     // Wait for 1s then run the block on a background queue
     delay(1.0, queueType: .Background) { alert.hide() }
     ```
     */
    class func delay(_ delay: TimeInterval, queueType: QueueType = .Main, closure: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queueType.queue.asyncAfter(deadline: time, execute: closure)
    }
    
    
    // MARK: - Mail
    /**
     Open Mail app Compose view
     
     - parameter email:   an email address
     - parameter subject: a subject
     - parameter body:    a body
     */
    class func openMailApp(_ email:String, subject:String, body:String) {
        let toEmail = email
        let toSubject = subject
        let toBody = body
        
        if let
            urlString = ("mailto:\(toEmail)?subject=\(toSubject)&body=\(toBody)").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string:urlString) {
            UIApplication.shared.openURL(url)
        }
    }
 
    class func postImageHeight(serverSideHeight: Double , serverSidewidth:Double, width: CGFloat) -> CGFloat{
        var rHeight = Double(0)
        let rWidth = Double(width)
        if(serverSideHeight == 0 ){
            rHeight = Double((width) * 0.37)
        }else{
            rHeight = (serverSideHeight/serverSidewidth) * rWidth
        }
        return CGFloat(rHeight)
    }
    
    
}
