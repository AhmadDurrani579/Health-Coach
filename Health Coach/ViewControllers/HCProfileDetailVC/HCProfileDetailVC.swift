//
//  HCProfileDetailVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 22/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import Crashlytics

@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HCProfileDetailVC : UIViewController {
    @IBOutlet weak var postCollectionView: UICollectionView!
    private var profileItem : [MenuProfile] = []
    var responseObj: UserResponse?
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(HCProfileDetailVC.updateFeed), name: Notification.Name("UpdateInfo"), object: nil)

        let items: [MenuProfile] = [
            MenuProfile(title: "Body Composition" , icon: "body"),
            MenuProfile(title: "Health Goal" , icon: "health_goal"),
            MenuProfile(title: "Social Info", icon: "social"),
            MenuProfile(title: "Health Info " , icon: "health_info"),
            MenuProfile(title: "Community and FAQ" , icon: "communityPro"),
            MenuProfile(title: "Account Statement" , icon: "account_statement"),
            MenuProfile(title: "Introduction" , icon: "introductionPro"),
            MenuProfile(title: "Program Guide" , icon: "program_guide"),

        ]
        
        profileItem = items

        postCollectionView.register(UINib(nibName: "DashboardHeaderCell", bundle: nil), forCellWithReuseIdentifier: "DashboardHeaderCell")
        postCollectionView.register(UINib(nibName: "ProfileInfoCell", bundle: nil), forCellWithReuseIdentifier: "ProfileInfoCell")
        postCollectionView.register(UINib(nibName: "FAQSCommunityCell", bundle: nil), forCellWithReuseIdentifier: "FAQSCommunityCell")

        
        
        
    }
    
    @objc func updateFeed() {
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             : userId!
            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLUSERDETAIL , isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            
            guard let this = self else {
                return
            }
            this.responseObj = (response as! UserResponse)
            if this.responseObj!.success == true {
                this.postCollectionView.reloadData()
            }
            else {
                self!.showAlert(title: KMessageTitle , message: this.responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
    }

    func getAllUserDetail() {

    }

    
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension HCProfileDetailVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
           return profileItem.count
        } else {
            return 1
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardHeaderCell", for: indexPath) as! DashboardHeaderCell
            if (self.responseObj?.getUserDetail?.userHealth!.count)! > 0 {
                cell.lblWeight.text = self.responseObj?.getUserDetail?.userHealth![0].weight
                cell.lblBMI.text = self.responseObj?.getUserDetail?.userHealth![0].bmi
                cell.lblMuscle.text = self.responseObj?.getUserDetail?.userHealth![0].muscle
                cell.delegate = self
                cell.indexSelect = indexPath
                
                let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
                let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
                cell.lblHeaderName.text = "\(firstName!) \(lastName!)"

                guard  let image = self.responseObj?.getUserDetail?.userDetailObject?.profile_pic  else   {
                    return cell
                }
                WAShareHelper.loadImage(urlstring:image , imageView: (cell.imgOfUser!), placeHolder: "profile")
//                let cgFloat: CGFloat = cell.imgOfUser.frame.size.width/2.0
//                let someFloat = Float(cgFloat)
//                WAShareHelper.setViewCornerRadius(cell.imgOfUser, radius: CGFloat(someFloat))
            } else {
                cell.delegate = self
                cell.indexSelect = indexPath
                let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
                let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
                
                cell.lblHeaderName.text = "\(firstName!) \(lastName!)"
                guard  let image = self.responseObj?.getUserDetail?.userDetailObject?.profile_pic  else   {
                    return cell
                }
                WAShareHelper.loadImage(urlstring:image , imageView: (cell.imgOfUser!), placeHolder: "profile")
//                let cgFloat: CGFloat = cell.imgOfUser.frame.size.width/2.0
//                let someFloat = Float(cgFloat)
//                WAShareHelper.setViewCornerRadius(cell.imgOfUser, radius: CGFloat(someFloat))
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell
            cell.lblNameOfExercise.text = profileItem[indexPath.row].title
            let nmaeOfImage = profileItem[indexPath.row].icon
            cell.imgOfProfile.image = UIImage(named: nmaeOfImage)
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FAQSCommunityCell", for: indexPath) as! FAQSCommunityCell
            cell.delegate = self
            return cell

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInfoCell", for: indexPath) as! ProfileInfoCell

        if indexPath.row == 1 {
            if responseObj?.getUserDetail?.subscription?.is_subscribed == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthGoalInfoVCAfterPayedVC") as? HealthGoalInfoVCAfterPayedVC
                vc?.responseObj = responseObj
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCSocialInfoVC") as? HCSocialInfoVC
                vc?.responseObj = responseObj
                self.navigationController?.pushViewController(vc!, animated: true)

            }
        } else  if indexPath.row == 2 {
            UtilityHelper.setViewBorder(cell.viewOfProfile!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthGaolInfoVC") as? HealthGaolInfoVC
            vc?.responseObj = responseObj
            self.navigationController?.pushViewController(vc!, animated: true)
        } else  if indexPath.row == 4 {
            UtilityHelper.setViewBorder(cell.viewOfProfile!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMedicalInfoVC") as? HCMedicalInfoVC
//            vc?.responseObj = responseObj
            self.navigationController?.pushViewController(vc!, animated: true)
        } else  if indexPath.row == 0 {
            UtilityHelper.setViewBorder(cell.viewOfProfile!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCBodyCompositionVC") as? HCBodyCompositionVC
            vc?.responseObj = responseObj
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if indexPath.row == 5 {
            UtilityHelper.setViewBorder(cell.viewOfProfile!, withWidth: 2.0, andColor: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileInfoVC") as? UserProfileInfoVC
            vc?.responseObj = responseObj
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if indexPath.row == 6 {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HCNextPagerVC") as? HCNextPagerVC
            vc!.isComeFromSignUpOrMain = "main"
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCHealthInfoVC") as? HCHealthInfoVC
            vc?.responseObj = responseObj
            self.navigationController?.pushViewController(vc!, animated: true)

        } else if indexPath.row == 7 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCProgramAgreementSliderVC") as? HCProgramAgreementSliderVC
            self.navigationController?.pushViewController(vc!, animated: true)

//            appDelegate.selectGoal = self.responseObj?.getUserDetail?.userDetailObject?.interests
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "HCGoalMainVC") as? HCGoalMainVC
//            vc?.isComeFromSignUpOrMain = "main"
//            self.navigationController?.pushViewController(vc!, animated: true)
//             self.pushToViewControllerWithStoryboardID(storyboardId: "HCGoalMainVC")
//            Program Guide
            
            
        }
        
        
        
        
        
//
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.9, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.postCollectionView.frame.size.width
        if indexPath.section == 0 {
            return CGSize(width: sizeOfCell, height: 289.0)
        } else  if indexPath.section == 1{
            let sizeOfCell = self.postCollectionView.frame.size.width/2 - 3
            return CGSize(width: sizeOfCell, height: 176.0)
        } else  {
            return CGSize(width: sizeOfCell, height: 53.0)
        }
    
    }

}
@available(iOS 13.0, *)

extension HCProfileDetailVC : ProfileInfoDelgate   {
    func clickOnProfile(cell : DashboardHeaderCell , index : IndexPath) {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            cell.imgOfUser.image = orignal
            self.cover_image = orignal
            let cgFloat: CGFloat = cell.imgOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(cell.imgOfUser, radius: CGFloat(someFloat))

            let userId = UserDefaults.standard.integer(forKey: "id")
            let params =    [
                                "userid"                        :  "\(userId)" ,
                            ] as [String : Any]
            
            WebServiceManager.multiPartImageForProfile(params: params as Dictionary<String, AnyObject> , serviceName: PROFILEUPDATE , imageParam:"image" , imgFileName: "image", serviceType: "Share", profileImage: cell.imgOfUser.image, cover_image_param: "", cover_image: nil , modelType: ProfilePicUpdate.self, success: { (response) in
                let responseObj = response as? ProfilePicUpdate
                if responseObj != nil {
                    if responseObj?.success == true  {
                        self.showAlertViewWithTitle(title: KMessageTitle, message: responseObj!.message ?? responseObj!.msg!, dismissCompletion: {
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("updateProfilePic"), object: nil)

                        })
                        
                    }  else
                    {
                        self.showAlert(title: KMessageTitle, message: responseObj!.message ?? "Server Error" , controller: self)
                    }
                } else {
                    self.showAlert(title: KMessageTitle, message: "Server Error" , controller: self)
                    
                }
            }) { (error) in
                
                
            }
            
        }
    }


}
@available(iOS 13.0, *)

extension HCProfileDetailVC : CommunityAndLogoutDelegate {
    func communitySelect(cell: FAQSCommunityCell) {
        
    }
    
    func logout(cell: FAQSCommunityCell) {
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "firstName")
        UserDefaults.standard.set(nil  , forKey : "profile")
        UserDefaults.standard.set(nil  , forKey : "moodSelect")
        UserDefaults.standard.set(nil  , forKey : "subscribe")

        
        //        UIApplication.shared.keyWindow?.rootViewController = vc
        self.pushToViewControllerWithStoryboardID(storyboardId: VCIdentifier.KINTOVC)

    }
    
    
 
}
