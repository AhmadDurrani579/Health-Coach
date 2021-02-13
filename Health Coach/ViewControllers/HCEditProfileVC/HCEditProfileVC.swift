//
//  HCEditProfileVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 08/08/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCEditProfileVC: UIViewController {

    @IBOutlet weak var imgOfPRofile: UIImageView!
    @IBOutlet weak var txtEditName: UITextView!
    var selectFood : FoodToday?
    var selectKitchen : KitchenObject?
    var isFoodOrKitchenSelect : Bool?
    let photoPicker = PhotoPicker()
    
    @IBOutlet weak var btnBreakFast: UIButton!
    @IBOutlet weak var btnLaunch: UIButton!
    @IBOutlet weak var btnDinner: UIButton!
    @IBOutlet weak var btnSnack: UIButton!
    
    
    var cover_image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(HCEditProfileVC.imageTappedForDp(img:)))
        imgOfPRofile.isUserInteractionEnabled = true
        imgOfPRofile.addGestureRecognizer(tapGestureRecognizerforDp)
        
        UtilityHelper.setViewBorder(imgOfPRofile!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))
        
        UtilityHelper.setViewBorder(txtEditName!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))

        txtEditName.text = selectFood?.food_type
        guard  let image = selectFood?.image  else   {
            return
        }
        WAShareHelper.loadImage(urlstring:image , imageView: (imgOfPRofile!), placeHolder: "profile")
//        let cgFloat: CGFloat = imgOfPRofile.frame.size.width/2.0
//        let someFloat = Float(cgFloat)
//        WAShareHelper.setViewCornerRadius(imgOfPRofile , radius: CGFloat(someFloat))

        // Do any additional setup after loading the view.
    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            self.imgOfPRofile.image = orignal
//            let cgFloat: CGFloat = self.imgOfPRofile.frame.size.width/2.0
//            let someFloat = Float(cgFloat)
//            WAShareHelper.setViewCornerRadius(self.imgOfPRofile , radius: CGFloat(someFloat))
            self.cover_image = orignal
            UtilityHelper.setViewBorder(self.imgOfPRofile!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))

        }
        
    }
    
    @IBAction func btnBreakFast_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtEditName.text = "BREAKFAST"
        btnBreakFast.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnLaunch.backgroundColor  = UIColor.clear
        btnDinner.backgroundColor  = UIColor.clear
        btnSnack.backgroundColor  = UIColor.clear
      
        btnBreakFast.titleLabel?.textColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnLaunch.titleLabel?.textColor = UIColor.darkGray
        btnDinner.titleLabel?.textColor = UIColor.darkGray
        btnSnack.titleLabel?.textColor = UIColor.darkGray


    }
    
    
    @IBAction func btnLaunch(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtEditName.text = "LUNCH"
        btnLaunch.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnBreakFast.backgroundColor  = UIColor.clear
        btnDinner.backgroundColor  = UIColor.clear
        btnSnack.backgroundColor  = UIColor.clear
        
        btnLaunch.titleLabel?.textColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnBreakFast.titleLabel?.textColor = UIColor.darkGray
        btnDinner.titleLabel?.textColor = UIColor.darkGray
        btnSnack.titleLabel?.textColor = UIColor.darkGray




    }
    
    @IBAction func btnDinner_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtEditName.text = "DINNER"
        
        btnDinner.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnBreakFast.backgroundColor  = UIColor.clear
        btnLaunch.backgroundColor  = UIColor.clear
        btnSnack.backgroundColor  = UIColor.clear
        
        btnDinner.titleLabel?.textColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnBreakFast.titleLabel?.textColor = UIColor.darkGray
        btnLaunch.titleLabel?.textColor = UIColor.darkGray
        btnSnack.titleLabel?.textColor = UIColor.darkGray



    }
    
    @IBAction func btnSnack_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtEditName.text = "SNACK"
        
        btnSnack.backgroundColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnBreakFast.backgroundColor  = UIColor.clear
        btnLaunch.backgroundColor  = UIColor.clear
        btnDinner.backgroundColor  = UIColor.clear

        btnSnack.titleLabel?.textColor = UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0)
        btnBreakFast.titleLabel?.textColor = UIColor.darkGray
        btnLaunch.titleLabel?.textColor = UIColor.darkGray
        btnDinner.titleLabel?.textColor = UIColor.darkGray

    }

    
    @IBAction func btnEdit_Pressed(_ sender: UIButton) {
        
        let userId = UserDefaults.standard.string(forKey: "id")
        var serviceUrl : String?
        var selectedID : String?
        if isFoodOrKitchenSelect == true {
            serviceUrl = ADDFOODTODAY
            let selectFoodItemId = selectFood?.idOfItem
            selectedID = selectFood?.id ?? "\(selectFoodItemId!)"
        } else {
            serviceUrl = ADDKITCHEN
            let selectFoodItemId = selectFood?.idOfItem
            selectedID = selectKitchen?.id ?? "\(selectFoodItemId!)"
        }
            let params =  [
                "user_id"                                :  userId! ,
                "food_type"                              :  txtEditName.text! ,
                "id"                                     :  selectedID!
                ] as [String : Any]
            
        WebServiceManager.multiPartImageForProfile(params: params as Dictionary<String, AnyObject> , serviceName: serviceUrl! , imageParam:"image" , imgFileName: "image", serviceType: "Share", profileImage: imgOfPRofile.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
                let responseObj = response as? ProfilePicUpdate
                if responseObj != nil {
                    if responseObj?.success == true  {
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("IsImageUpload"), object: nil)
                        self.showAlertViewWithTitle(title: KMessageTitle, message: responseObj!.message ?? responseObj!.msg!, dismissCompletion: {
//                            let nc = NotificationCenter.default
//                            nc.post(name: Notification.Name("IsImageUpload"), object: nil)
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                    else
                    {
                        
                        self.showAlertViewWithTitle(title: KMessageTitle, message: responseObj!.message ?? responseObj!.msg!, dismissCompletion: {
                            
                        })
                        
                    }
                } else {
                    self.showAlert(title: KMessageTitle, message: "Server Error" , controller: self)
                    
                }
            }) { (error) in
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
