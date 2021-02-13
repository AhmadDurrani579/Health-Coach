//
//  HCMainDashboardVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import DatePickerDialog

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HCMainDashboardVC: UIViewController {
    @IBOutlet weak var postCollectionView: UICollectionView!
    var responseObj: UserResponse?
    var isFoodDiaryClick : Bool?
    var isKitchenItemClick : Bool?
    var isFoodItenOrKitcheSelect : Bool?
    var isExerciseOpen : Bool?
    var isHydration : Bool?
    var isIncrementDateSelect : Bool?
    @IBOutlet weak var imgOfFoodItem: UIImageView!
    @IBOutlet weak var txtFoodType: UITextField!
    
    @IBOutlet weak var viewOfPop: UIView!
    @IBOutlet weak var viewOfExercise: UIView!
    
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?

    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var txtDistance: UITextField!
//    @IBOutlet weak var txtCalories: UITextField!
 //   @IBOutlet weak var txtNotes: UITextField!
    @IBOutlet weak var lblSelectFeeling: UILabel!
    
    @IBOutlet weak var viewOfMood: UIView!
    var selectMode : Int?
    var dateFormatted : String?
    var dateExecise : String?
    var dateKitchen : String?
    var dOHydration : String?
    var dateOFCurrent : String?
    

    var currentDate = Date()
    var dateOfFood = Calendar.current.startOfDay(for: Date())
    var dateOfKitchen = Calendar.current.startOfDay(for: Date())
    var dateOfExercise = Calendar.current.startOfDay(for: Date())
    var dateOfHydration = Calendar.current.startOfDay(for: Date())

    
    var glass1 : String?
    var glass2 : String?
    var glass3 : String?
    var glass4 : String?
    var glass5 : String?
    var glass6 : String?
    
    var isValueIncrementOrDecrement  = 0
    
    var isAnimated : Bool?
    var isImageSelect : Bool?
    @IBOutlet weak var btnSelectActivity : UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnBreakFast: UIButton!
    @IBOutlet weak var btnLaunch: UIButton!
    @IBOutlet weak var btnDinner: UIButton!
    @IBOutlet weak var btnSnack: UIButton!
    var isExerciseSelect = false
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDuration.setLeftPaddingPoints(10.0)
        
//        selectMode = 0

        
        isIncrementDateSelect = false
//        isValueIncrementOrDecrement = 0
        isAnimated = false
        isImageSelect = false
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        dateFormatted = format.string(from: dateOfFood)
        dateExecise = format.string(from: dateOfKitchen)
        dateKitchen = format.string(from: dateOfExercise)
        dOHydration = format.string(from: dateOfHydration)
        dateOFCurrent = format.string(from: currentDate)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            postCollectionView.refreshControl = refreshControl
        } else {
            postCollectionView.addSubview(refreshControl)
        }

        let ncs = NotificationCenter.default
        ncs.addObserver(self, selector: #selector(HCMainDashboardVC.updateFeed), name: Notification.Name("IsImageUpload"), object: nil)
        isFoodDiaryClick = false
        isKitchenItemClick = false
        isFoodItenOrKitcheSelect = false
        postCollectionView.register(UINib(nibName: "DashboardHeaderCell", bundle: nil), forCellWithReuseIdentifier: "DashboardHeaderCell")
        postCollectionView.register(UINib(nibName: "FoodDiaryCell", bundle: nil), forCellWithReuseIdentifier: "FoodDiaryCell")
        postCollectionView.register(UINib(nibName: "HydrationCell", bundle: nil), forCellWithReuseIdentifier: "HydrationCell")
        postCollectionView.register(UINib(nibName: "ExerciseCell", bundle: nil), forCellWithReuseIdentifier: "ExerciseCell")
        postCollectionView.register(UINib(nibName: "MyKitchenCell", bundle: nil), forCellWithReuseIdentifier: "MyKitchenCell")
        postCollectionView.register(UINib(nibName: "MyKitchenCell", bundle: nil), forCellWithReuseIdentifier: "MyKitchenCell")
        postCollectionView.register(UINib(nibName: "SleepingCell", bundle: nil), forCellWithReuseIdentifier: "SleepingCell")
        postCollectionView.register(UINib(nibName: "FoodDiaryItemCell", bundle: nil), forCellWithReuseIdentifier: "FoodDiaryItemCell")
        postCollectionView.register(UINib(nibName: "ExerciseItemCell", bundle: nil), forCellWithReuseIdentifier: "ExerciseItemCell")
        postCollectionView.register(UINib(nibName: "HydrationSelectCell", bundle: nil), forCellWithReuseIdentifier: "HydrationSelectCell")
        postCollectionView.register(UINib(nibName: "HeaderSectionCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSectionCell")
        postCollectionView.register(UINib(nibName: "FooterSectionCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterSectionCell")
        
        postCollectionView.register(UINib(nibName: "ExerciseFooterCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ExerciseFooterCell")

        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(HCMainDashboardVC.imageTappedForDp(img:)))
        imgOfFoodItem.isUserInteractionEnabled = true
        imgOfFoodItem.addGestureRecognizer(tapGestureRecognizerforDp)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(HCMainDashboardVC.getAllUserDetail), name: Notification.Name("updateProfilePic"), object: nil)
        getAllUserDetail(isLoaderShow: true)
    }
    
    @objc func refreshData() {
        getAllUserDetail(isLoaderShow: true)
    }

    
     @objc func updateFeed() {
        getAllUserDetail(isLoaderShow: true)
    }

    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            self.imgOfFoodItem.image = orignal
            let cgFloat: CGFloat = self.imgOfFoodItem.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.imgOfFoodItem , radius: CGFloat(someFloat))
            self.cover_image = orignal
            self.isImageSelect = true
        }
        
    }

    @objc func getAllUserDetail(isLoaderShow : Bool) {
        let userId = UserDefaults.standard.string(forKey: "id")
//        204
        let loginParam =      [ "userid"             : userId!
                              ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLUSERDETAIL , isLoaderShow: isLoaderShow , serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            
            guard let this = self else {
                return
            }
            this.responseObj = (response as! UserResponse)
            this.appDelegate.responseObj = (response as! UserResponse)
            if this.responseObj!.success == true {
                
             if this.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
                 if this.responseObj?.getUserDetail?.subscription?.trial == true {
                     UserDefaults.standard.set(true, forKey: "subscribe")
                 } else {
                      UserDefaults.standard.set(false, forKey: "subscribe")
                  }
              } else {
                  UserDefaults.standard.set(true, forKey: "subscribe")
              }
                
                self?.glass1 = self?.responseObj?.getUserDetail?.waterToday?.glass ?? "0"
                self?.glass2 = self?.responseObj?.getUserDetail?.waterToday?.glass2 ?? "0"
                self?.glass3 = self?.responseObj?.getUserDetail?.waterToday?.glass3 ?? "0"
                self?.glass4 = self?.responseObj?.getUserDetail?.waterToday?.glass4 ?? "0"
                self?.glass5 = self?.responseObj?.getUserDetail?.waterToday?.glass5 ?? "0"
                self?.glass6 = self?.responseObj?.getUserDetail?.waterToday?.glass6 ?? "0"
                this.postCollectionView.delegate = self
                this.postCollectionView.dataSource = self
                this.refreshControl.endRefreshing()

                this.postCollectionView.reloadData()

            }
            else {
                self!.showAlert(title: KMessageTitle , message: this.responseObj!.message ?? this.responseObj!.msg! , controller: self)
                this.postCollectionView.delegate = self
                this.postCollectionView.dataSource = self
                this.postCollectionView.reloadData()
            }
            }, fail: { (error) in
        }, showHUD: true)
    }
    
    func addKitchenOrFoodItem( params: [String : Any] , isFoodOrKitchen : Bool , serviceType : String) {
        WebServiceManager.multiPartImage(params: params as Dictionary<String, AnyObject> , serviceName: serviceType , imageParam:"image" , imgFileName: "image", serviceType: "Share", profileImage: imgOfFoodItem.image, cover_image_param: "", cover_image: nil , modelType: Food.self, success: { (response) in
            let responseObjss = response as? Food
            if responseObjss != nil {
                if responseObjss?.success == true  {
                    self.showToast(responseObjss!.message ?? responseObjss!.msg!)
                        self.viewOfPop.isHidden = true
                        self.txtFoodType.text = ""
                        self.txtFoodType.placeholder = "Enter Food Type"
                        self.imgOfFoodItem.image = UIImage(named: "upload image")
                        self.isImageSelect = false
                        if self.isFoodItenOrKitcheSelect == true {
                            self.txtFoodType.placeholder = "Enter Food Type"
                            self.isAnimated = true
                            self.responseObj?.getUserDetail?.foodToday?.append(responseObjss!.addFoodItem!)
                            self.postCollectionView.reloadData()
//                            self.postCollectionView?.performBatchUpdates({
//                                let indexPath = IndexPath(row: (self.responseObj?.getUserDetail?.foodToday?.count ?? 0)!, section: 1)
//                                self.responseObj?.getUserDetail?.foodToday?.append(responseObj!.addFoodItem!)
//
//                                self.postCollectionView?.insertItems(at: [indexPath])
//                            }, completion: nil)
                        } else {
                            self.txtFoodType.placeholder = "Enter Kitchen Type"
                            self.isAnimated = true
//                            self.responseObj?.getUserDetail?.kitchenObject = []
                            self.responseObj?.getUserDetail?.kitchenObject?.append(responseObjss!.kitchenItem!)
                            self.postCollectionView.reloadData()

//                            self.postCollectionView?.performBatchUpdates({
//                                let indexPath = IndexPath(row: (self.responseObj?.getUserDetail?.kitchenObject?.count ?? 0)!, section: 4)
//                                self.responseObj?.getUserDetail?.kitchenObject?.append(responseObj!.kitchenItem!)
//                                self.postCollectionView?.insertItems(at: [indexPath])
//                            }, completion: nil)

                        }
//                    })
                    
                }  else
                {
                    
                    self.showToast(responseObjss!.message ?? responseObjss!.msg!)

//                    self.showAlertViewWithTitle(title: KMessageTitle, message: responseObj!.message ?? responseObj!.msg!, dismissCompletion: {
                        self.viewOfPop.isHidden = true
                        self.txtFoodType.text = ""
                        
                        self.txtFoodType.placeholder = "Enter Food Type"
                        self.imgOfFoodItem.image = UIImage(named: "upload image")

//                    })

                }
            } else {
                self.showAlert(title: KMessageTitle, message: "Server Error" , controller: self)
                
            }
        }) { (error) in
        }
    }
    
    @IBAction private func btnAddActivity_Pressed(_ sender : UIButton) {
        ActionSheetStringPicker.show(withTitle: "", rows: ["Swimming" , "Cycling" , "Skiing" , "Yoga/Pilates" , "Dance-based fitness" , "Weight lifting" , "Crossfit" , "Tennis" , "Surfing" , "Boxing" , "Jumping/Skipping" , "Others"] , initialSelection: 0 , doneBlock: { [weak self] (picker, index, value)  in
            self!.btnSelectActivity.setTitle(value as? String , for: .normal)
            self!.isExerciseSelect = true
            return
            }, cancel: { (actionStrin ) in
                
        }, origin: sender)
    }
    
    @IBAction private func btnAddFood(_ sender : UIButton) {
        
        if txtFoodType.text!.isEmpty   {
             self.showToast("Please enter Title")
        } else if self.isImageSelect == false  {
             self.showToast("Please Select image")
        } else {
        let userId = UserDefaults.standard.string(forKey: "id")
        if isFoodItenOrKitcheSelect == true {
            let params =  [
                "user_id"                           :  userId! ,
                "food_type"                         :  txtFoodType.text! ,
                "date"                              :  dateFormatted!
                ] as [String : Any]
            self.addKitchenOrFoodItem(params: params, isFoodOrKitchen: true, serviceType: ADDFOODTODAY)
        } else if isFoodItenOrKitcheSelect == false {
            let params =  [
                "user_id"                        :  userId! ,
                "title"                          :  txtFoodType.text! ,
                "date"                              :  dateKitchen!

                ] as [String : Any]
            self.addKitchenOrFoodItem(params: params, isFoodOrKitchen: false, serviceType: ADDKITCHEN)
        }
      }
    }
    
    @IBAction func btnAddExercise_Pressed(_ sender: UIButton) {
        
        if txtDuration.text?.count == 0 {
            self.showAlert(title: KMessageTitle , message: "Enter Duration", controller: self)
            return
        }
        if self.isExerciseSelect == false {
            self.showAlert(title: KMessageTitle , message: "Please select exercise type", controller: self)
            return
        }

        let typeOfExercise = self.btnSelectActivity.titleLabel?.text!
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             :  userId! ,
                                "duration"           :  txtDuration.text ?? "1" ,
//                                "distance"           :  typeOfExercise!  ?? "1" ,
                                "calories"           :   " " ,
                                "notes"              :   " " ,
                                "type"               :  typeOfExercise ?? " " ,
                                "date"               :  self.dateExecise!

            ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: ADDEXERCISE , isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
//            self!.getAllUserDetail(isLoaderShow: false)
//            getAllUserDetail(isLoaderShow: true)
            this.isExerciseSelect = false
            if responseObj!.success == true {
                
                this.txtDuration.text = ""
//                this.txtDistance.text = ""
                self?.btnSelectActivity.setTitle("Select Activity", for: .normal)
//                this.txtCalories.text = ""
//                this.txtNotes.text = ""

                self!.isAnimated = true
                this.responseObj?.getUserDetail?.exerciseObjectss?.append(responseObj!.exerciseObject![0])
                this.responseObj?.getUserDetail?.exerciseReport =  responseObj?.chartData
//                self.responseObj?.getUserDetail?.foodToday?.append(responseObj!.addFoodItem!)
                self!.postCollectionView.reloadData()
//                this.postCollectionView?.performBatchUpdates({
//                    let indexPath = IndexPath(row: (this.responseObj?.getUserDetail?.exerciseObjectss?.count)!, section: 3)
//                    this.responseObj?.getUserDetail?.exerciseObjectss?.append(responseObj!.exerciseObject!)
//                    this.postCollectionView?.insertItems(at: [indexPath])
//                }, completion: nil)
                this.viewOfExercise.isHidden = true
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)

    }
    @IBAction func btnRemindMeLater_Pressed(_ sender: UIButton) {
        self.viewOfMood.isHidden = true

        
    }
    @IBAction func btnCross(_ sender: UIButton) {
        self.viewOfMood.isHidden = true
    }
    
    @IBAction func btnCrossKitchen(_ sender: UIButton) {
        self.viewOfPop.isHidden = true
    }
    
    @IBAction func btnCrossExercise(_ sender: UIButton) {
        self.viewOfExercise.isHidden = true
    }

    @IBAction func btnSendMood_Pressed(_ sender: UIButton) {
        let userId = UserDefaults.standard.string(forKey: "id")
        if selectMode  != nil {
            let loginParam =      [ "userid"             :  userId! ,
                                    "emoji_no"           :  "\(selectMode!)"
                ] as [String : Any]
            WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: FEELINGTODAY , isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
                guard let this = self else {
                    return
                }
                let  responseObj = (response as! UserResponse)
                if responseObj.success == true {
                    UserDefaults.standard.set("1" , forKey: "moodSelect")

                    this.viewOfMood.isHidden = true
                }
                else {
                    this.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
                    this.viewOfMood.isHidden = true

                }
                }, fail: { (error) in
            }, showHUD: true)
        } else {
            self.showToast("Select Mood")
        }
        
//
    }
    @IBAction func btnSelectMode(_ sender: UIButton) {
        if sender.tag == 0 {
            lblSelectFeeling.text = "Angry"
            selectMode = 0
        }  else if sender.tag == 1 {
            lblSelectFeeling.text = "Shocked"
            selectMode = 1

        } else if sender.tag == 2 {
            lblSelectFeeling.text = "Confused"
            selectMode = 2

        } else if sender.tag == 3 {
            lblSelectFeeling.text = "Warm"
            selectMode = 3

        } else if sender.tag == 4 {
            lblSelectFeeling.text = "Love"
            selectMode = 4

        }
    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
    
    func getDate(dayDifference: Int , selectDate : Date) -> Date {
        var components = DateComponents()
        components.day = dayDifference
        return Calendar.current.date(byAdding: components, to: selectDate)!
    }
    
    func getExercise(params: [String : Any] , serviceName : String) {
        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: serviceName , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
                self!.postCollectionView?.performBatchUpdates({
                    this.responseObj?.getUserDetail?.exerciseObjectss = responseObj?.execiseObj ?? []
                    this.responseObj?.getUserDetail?.exerciseReport = responseObj?.chartData
                    let indexSet = IndexSet(integer: 3)
                    self!.postCollectionView.reloadSections(indexSet)
                }, completion: nil)
            }
            else {
                self!.postCollectionView?.performBatchUpdates({
                    this.responseObj?.getUserDetail?.exerciseObjectss = responseObj?.execiseObj ?? []
//                    this.responseObj?.getUserDetail?.exerciseReport = responseObj?.chartData
                    let indexSet = IndexSet(integer: 3)
                    self!.postCollectionView.reloadSections(indexSet)
                    
                }, completion: nil)

            }
            }, fail: { (error) in
        }, showHUD: true)
        
    }
    
    func getWater(params: [String : Any] , serviceName : String) {
        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: serviceName , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
                
                responseObj?.getUserDetail?.waterToday = responseObj?.waterObject
                self?.glass1 = responseObj?.getUserDetail?.waterToday?.glass ?? "0"
                self?.glass2 = responseObj?.getUserDetail?.waterToday?.glass2 ?? "0"
                self?.glass3 = responseObj?.getUserDetail?.waterToday?.glass3 ?? "0"
                self?.glass4 = responseObj?.getUserDetail?.waterToday?.glass4 ?? "0"
                self?.glass5 = responseObj?.getUserDetail?.waterToday?.glass5 ?? "0"
                self?.glass6 = responseObj?.getUserDetail?.waterToday?.glass6 ?? "0"
                self!.isAnimated = true
                self!.postCollectionView.reloadData()
            }
            else {
                
                self!.isAnimated = true
                this.responseObj?.getUserDetail?.waterToday = responseObj?.waterObject
                self?.glass1 = responseObj?.getUserDetail?.waterToday?.glass ?? "0"
                self?.glass2 = responseObj?.getUserDetail?.waterToday?.glass2 ?? "0"
                self?.glass3 = responseObj?.getUserDetail?.waterToday?.glass3 ?? "0"
                self?.glass4 = responseObj?.getUserDetail?.waterToday?.glass4 ?? "0"
                self?.glass5 = responseObj?.getUserDetail?.waterToday?.glass5 ?? "0"
                self?.glass6 = responseObj?.getUserDetail?.waterToday?.glass6 ?? "0"
                self!.postCollectionView.reloadData()

//                self!.postCollectionView?.performBatchUpdates({

//                    let indexSet = IndexSet(integer: 2)
//                    self!.postCollectionView.reloadSections(indexSet)
                
//                }, completion: nil)
                
            }
            }, fail: { (error) in
        }, showHUD: true)
        
    }

    
    func getKitchOrFoodItem(params: [String : Any] , serviceName : String , isFoodItemSelect : Bool) {
        
        WebServiceManager.post(params:params as Dictionary<String, AnyObject> , serviceName: serviceName , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
                
                if isFoodItemSelect == false {
                    self!.postCollectionView?.performBatchUpdates({
                        
                        this.responseObj?.getUserDetail?.foodToday = responseObj?.foodItemList ?? []
                        let indexSet = IndexSet(integer: 1)
                        self!.postCollectionView.reloadSections(indexSet)
                        
                    }, completion: nil)
                } else {
                    self!.postCollectionView?.performBatchUpdates({
                        this.responseObj?.getUserDetail?.kitchenObject = responseObj?.kitechenItemList
                        let indexSet = IndexSet(integer: 5)
                        self!.postCollectionView.reloadSections(indexSet)
                        
                    }, completion: nil)

                }
//                this.postCollectionView.reloadData()
            }
            else {
//                 this.postCollectionView.reloadData()
//                self!.showAlert(title: KMessageTitle , message: responseObj!.message ?? responseObj!.msg! , controller: self)
                self!.showToast(responseObj!.message ?? responseObj!.msg!)
//                self!.showAlertViewWithTitle(title: KMessageTitle, message: responseObj!.message ?? responseObj!.msg!, dismissCompletion: {
                    if isFoodItemSelect == false {
                       
                        self!.postCollectionView?.performBatchUpdates({
                            this.responseObj?.getUserDetail?.foodToday = responseObj?.foodItemList ?? []
                            let indexSet = IndexSet(integer: 1)
                            self!.postCollectionView.reloadSections(indexSet)
                            
                        }, completion: nil)
                        
                    } else {
                        self!.postCollectionView?.performBatchUpdates({
                            this.responseObj?.getUserDetail?.kitchenObject = responseObj?.kitechenItemList ?? []
                            let indexSet = IndexSet(integer: 5)
                            self!.postCollectionView.reloadSections(indexSet)
                            
                        }, completion: nil)
                    }
//                    this.postCollectionView.reloadData()

//                })
            }
            }, fail: { (error) in
        }, showHUD: true)

    }
    
    func deleteItem(idOfItem : String , word : String) {
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "id"             :  idOfItem ,
                                "word"           :  word
                                ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: DELTEITEM  , isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            
            if this.responseObj!.success == true {
            }
            else {
                self!.showToast(responseObj!.message ?? responseObj!.msg!)

//                self!.showAlert(title: KMessageTitle , message: responseObj!.message!, controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
    }
    
    func getItemOnTheBasisOfDate(titleOfSelectItem : String , serviceName : String , isFoodItemSelect : Bool) {

    }
    
    @IBAction func btnBreakFast_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtFoodType.text = "BREAKFAST"
        btnBreakFast.backgroundColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
        btnLaunch.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnDinner.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnSnack.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
      
        btnBreakFast.isSelected = true
        btnLaunch.isSelected = false
        btnDinner.isSelected = false
        btnSnack.isSelected = false
////        btnBreakFast.titleLabel?.textColor = UIColor.white
//        btnLaunch.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnDinner.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnSnack.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)


    }
    
    
    @IBAction func btnLaunch(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtFoodType.text = "LUNCH"
        btnLaunch.backgroundColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
        btnBreakFast.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnDinner.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnSnack.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
//
////        btnLaunch.titleLabel?.textColor = UIColor.white
//        btnBreakFast.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnDinner.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnSnack.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)

        btnBreakFast.isSelected = false
        btnLaunch.isSelected = true
        btnDinner.isSelected = false
        btnSnack.isSelected = false



    }
    
    @IBAction func btnDinner_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtFoodType.text = "DINNER"
        
        btnDinner.backgroundColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
        btnBreakFast.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnLaunch.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnSnack.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
   
        btnBreakFast.isSelected = false
        btnLaunch.isSelected = false
        btnDinner.isSelected = true
        btnSnack.isSelected = false

//        btnDinner.titleLabel?.textColor = UIColor.white
//        btnBreakFast.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnLaunch.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnSnack.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)



    }
    
    @IBAction func btnSnack_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        txtFoodType.text = "SNACK"
        
        btnSnack.backgroundColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
        btnBreakFast.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnLaunch.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        btnDinner.backgroundColor  = UIColor(red: 230/255.0, green: 245/255.0, blue: 248/255.0, alpha: 1.0)
        
        btnBreakFast.isSelected = false
        btnLaunch.isSelected = false
        btnDinner.isSelected = false
        btnSnack.isSelected = true

////        btnSnack.titleLabel?.textColor = UIColor.white
//        btnBreakFast.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnLaunch.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)
//        btnDinner.titleLabel?.textColor = UIColor(red: 3/255.0, green: 160/255.0, blue: 185/255.0, alpha: 1.0)


    }


}
@available(iOS 13.0, *)

extension HCMainDashboardVC: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if isFoodDiaryClick == true {
                return self.responseObj?.getUserDetail?.foodToday?.count ?? 0
            } else {
                return 1
            }
        }  else if section == 5 {
            if isKitchenItemClick == true {
                return self.responseObj?.getUserDetail?.kitchenObject?.count ?? 0
            } else {
                return 1
            }

        }   else if section == 3 {
            if isExerciseOpen == true {
                return self.responseObj?.getUserDetail?.exerciseObjectss?.count ?? 0
            } else {
                return 1
            }
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardHeaderCell", for: indexPath) as! DashboardHeaderCell
            if self.responseObj?.getUserDetail != nil {
                            if (self.responseObj?.getUserDetail?.userHealth!.count)! > 0 {
                                cell.lblWeight.text = self.responseObj?.getUserDetail?.userHealth![0].weight
                                cell.lblBMI.text = self.responseObj?.getUserDetail?.userHealth![0].bmi
                                cell.lblMuscle.text = self.responseObj?.getUserDetail?.userHealth![0].muscle
                                cell.delegate = self
                                cell.indexSelect = indexPath
                                
                                let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
//                                let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
                                cell.lblHeaderName.text = "\(firstName!)"

                                guard  let image = self.responseObj?.getUserDetail?.userDetailObject?.profile_pic  else   {
                                    return cell
                                }
                                WAShareHelper.loadImage(urlstring:image , imageView: (cell.imgOfUser!), placeHolder: "profile")
//                                let cgFloat: CGFloat = cell.imgOfUser.frame.size.width/2.0
//                                let someFloat = Float(cgFloat)
//                                WAShareHelper.setViewCornerRadius(cell.imgOfUser, radius: CGFloat(someFloat))
                //                imgOfUser
                            } else {
                                
                                cell.delegate = self
                                cell.indexSelect = indexPath
                                cell.lblWeight.text = "0"
                                cell.lblBMI.text = "0"
                                cell.lblMuscle.text = "0"

                                let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
//                                let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
                                cell.lblHeaderName.text = "\(firstName!)"

                                guard  let image = self.responseObj?.getUserDetail?.userDetailObject?.profile_pic  else   {
                                    return cell
                                }
                                WAShareHelper.loadImage(urlstring:image , imageView: (cell.imgOfUser!), placeHolder: "profile")
//                                let cgFloat: CGFloat = cell.imgOfUser.frame.size.width/2.0
//                                let someFloat = Float(cgFloat)
//                                WAShareHelper.setViewCornerRadius(cell.imgOfUser, radius: CGFloat(someFloat))

                            }

            }
           
            return cell
        }
        else if indexPath.section == 1 {
            if isFoodDiaryClick == true {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDiaryItemCell", for: indexPath) as! FoodDiaryItemCell
                cell.lblItemName.text = self.responseObj?.getUserDetail?.foodToday![indexPath.row].food_type ?? " "
                cell.delegate = self
                cell.indexSelect = indexPath
                cell.section = indexPath.section
                self.isIncrementDateSelect = false
                let imageUrl = self.responseObj?.getUserDetail?.foodToday![indexPath.row].image
                WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: cell.imgOfItem, placeHolder: "profile")
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDiaryCell", for: indexPath) as! FoodDiaryCell
                cell.delegate = self
                self.isIncrementDateSelect = false
                
                cell.sectionSelect = indexPath.section
                cell.indexSelect = indexPath
                  return cell
            }
        } else if indexPath.section == 2 {
            
            if isHydration == true {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HydrationSelectCell", for: indexPath) as! HydrationSelectCell
                let obj = self.responseObj?.getUserDetail?.waterToday
                
                if self.glass1 == "0"  {
                   cell.bottle1.image = UIImage(named: "empty")
                } else if  self.glass1 == "1" {
                    cell.bottle1.image = UIImage(named: "filledGlass")
                }
                
                if self.glass2 == "0"  {
                    cell.bottle2.image = UIImage(named: "empty")
                } else if self.glass2 == "1" {
                    cell.bottle2.image = UIImage(named: "filledGlass")
                }

                if self.glass3 == "0"  {
                    cell.bottle3.image = UIImage(named: "empty")
                } else if self.glass3 == "1" {
                    cell.bottle3.image = UIImage(named: "filledGlass")
                }

                if self.glass4 == "0"  {
                    cell.bottle4.image = UIImage(named: "empty")
                } else if self.glass4 == "1" {
                    cell.bottle4.image = UIImage(named: "filledGlass")
                }

                if self.glass5 == "0"  {
                    cell.bottle5.image = UIImage(named: "empty")
                } else  if self.glass5 == "1" {
                    cell.bottle5.image = UIImage(named: "filledGlass")
                }
                    
                if self.glass6 == "0"  {
                    cell.bottle6.image = UIImage(named: "empty")
                } else  if self.glass6 == "1" {
                    cell.bottle6.image = UIImage(named: "filledGlass")
                }
                cell.delegate = self
                cell.selectIndex = indexPath
                return cell

            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HydrationCell", for: indexPath) as! HydrationCell
                cell.delegate = self
                cell.selectIndx = indexPath
                return cell

            }
            
        } else if indexPath.section == 3 {
            if isExerciseOpen == true {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseItemCell", for: indexPath) as! ExerciseItemCell
                let duration = self.responseObj?.getUserDetail?.exerciseObjectss![indexPath.row].duration
                let caleroies = self.responseObj?.getUserDetail?.exerciseObjectss![indexPath.row].calories
                let type = self.responseObj?.getUserDetail?.exerciseObjectss![indexPath.row].type
                if duration != nil {
                    cell.lblTime.text = "\(duration!) min"
                } else {
                    cell.lblTime.text = "0 min"
                }
                
                cell.lblRunningTime.text = " "
                cell.lblRunning.text = type

                
//                if distance != nil {
//                    cell.lblRunningTime.text = "\(distance!)"
//
//                } else {
//                    cell.lblRunningTime.text = "0 "
//                }
//
//                cell.lblTime.text = "\(duration!) min"
//                cell.lblRunningTime.text = "\(distance!)"
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
                cell.delegate = self
                cell.index = indexPath
                cell.sectionSelect = indexPath.section
            
                return cell
            }
            
        } else if indexPath.section == 4 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SleepingCell", for: indexPath) as! SleepingCell
            cell.delegate = self
            cell.selectIndex = indexPath
            return cell

//            if isKitchenItemClick == true {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDiaryItemCell", for: indexPath) as! FoodDiaryItemCell
//                self.isIncrementDateSelect = true
//                cell.delegate = self
//                cell.indexSelect = indexPath
//                cell.section = indexPath.section
//
//                cell.lblItemName.text = self.responseObj?.getUserDetail?.kitchenObject![indexPath.row].title
//                let imageUrl = self.responseObj?.getUserDetail?.kitchenObject![indexPath.row].image
//                WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: cell.imgOfItem, placeHolder: "profile")
//
//                return cell
//            } else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyKitchenCell", for: indexPath) as! MyKitchenCell
//                cell.delegate = self
//                self.isIncrementDateSelect = true
//
//                cell.index = indexPath
//                return cell
//            }
            
        } else   {
             if isKitchenItemClick == true {
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDiaryItemCell", for: indexPath) as! FoodDiaryItemCell
                 self.isIncrementDateSelect = true
                 cell.delegate = self
                 cell.indexSelect = indexPath
                 cell.section = indexPath.section

                 cell.lblItemName.text = self.responseObj?.getUserDetail?.kitchenObject![indexPath.row].title
                 let imageUrl = self.responseObj?.getUserDetail?.kitchenObject![indexPath.row].image
                 WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: cell.imgOfItem, placeHolder: "profile")
                 
                 return cell
             } else {
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyKitchenCell", for: indexPath) as! MyKitchenCell
                 cell.delegate = self
                 self.isIncrementDateSelect = true

                 cell.index = indexPath
                 return cell
             }

            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if isFoodDiaryClick == true {
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCEditProfileVC") as? HCEditProfileVC
                vc?.selectFood = self.responseObj?.getUserDetail?.foodToday![indexPath.row]
                vc?.isFoodOrKitchenSelect = true 

                self.navigationController?.pushViewController(vc!, animated: true)
                
            }
        } else if indexPath.section == 5 {
            if isKitchenItemClick == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCEditProfileVC") as? HCEditProfileVC
                vc?.isFoodOrKitchenSelect = false
                vc?.selectKitchen = self.responseObj?.getUserDetail?.kitchenObject![indexPath.row]
                self.navigationController?.pushViewController(vc!, animated: true)

            }
        }
    }
 /*
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isAnimated == false {
            cell.alpha = 0
            cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
            UIView.animate(withDuration: 0.9, animations: { () -> Void in
                cell.alpha = 1
                cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
            })

        } else {
               self.isAnimated = true
        }
    }
 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.postCollectionView.frame.size.width
        if indexPath.section == 0 {
            return CGSize(width: sizeOfCell, height: 272.0)
        } else if indexPath.section == 1 {
            if isFoodDiaryClick == true {
                let sizeOfCell = self.postCollectionView.frame.size.width/2 - 3
                return CGSize(width: sizeOfCell, height: 194.0)
            } else {
                return CGSize(width: sizeOfCell, height: 240.0)
            }
        } else if indexPath.section == 2 {
            if isHydration == true {
                return CGSize(width: sizeOfCell, height: 70.0)
            } else {
                return CGSize(width: sizeOfCell, height: 240.0)

            }

//            if isHydration == true {
//                return CGSize(width: sizeOfCell, height: 121.0)
//            } else {
//                return CGSize(width: sizeOfCell, height: 60.0)
//            }
        }
        else if indexPath.section == 3 {
            if isExerciseOpen == true {
                let sizeOfCell = self.postCollectionView.frame.size.width
                return CGSize(width: sizeOfCell, height: 60.0)
            } else {
                return CGSize(width: sizeOfCell, height: 240.0)

            }
        }
         else if indexPath.section == 4 {
            return CGSize(width: sizeOfCell, height: 240.0)

//            if isKitchenItemClick == true  {
//                let sizeOfCell = self.postCollectionView.frame.size.width/2 - 3
//                return CGSize(width: sizeOfCell, height: 194.0)
//            } else {
//                return CGSize(width: sizeOfCell, height: 266.0)
//            }
        } else  {
            
            if isKitchenItemClick == true  {
                let sizeOfCell = self.postCollectionView.frame.size.width/2 - 3
                return CGSize(width: sizeOfCell, height: 194.0)
            } else {
                return CGSize(width: sizeOfCell, height: 240.0)
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 1 {
            if (kind == UICollectionView.elementKindSectionFooter) {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:"FooterSectionCell", for: indexPath) as! FooterSectionCell
//                footerView.delegate = self
//                footerView.index = indexPath
                return footerView
            } else if (kind == UICollectionView.elementKindSectionHeader) {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:"HeaderSectionCell", for: indexPath) as! HeaderSectionCell
                headerView.lblTodayDate.isHidden = false
                headerView.lblTitle.text = "Food Diary"
                headerView.imgOfFoodDiaryOrKitchn.image = UIImage(named: "bowl")
                headerView.btnAddImage.tintColor = UIColor(red: 157/255.0, green: 208/255.0, blue: 60/255.0, alpha: 1.0)
                headerView.btnAddImage.isHidden = false

                headerView.lblTodayDate.text = getFormattedDate(string: dateFormatted!)
                headerView.delegate = self
                headerView.sectionSlect = indexPath.section
                headerView.indexSelect = indexPath
                headerView.selctItem = false
                return headerView
            }
            return UICollectionReusableView()

        }
        else if indexPath.section == 5 {
            if (kind == UICollectionView.elementKindSectionFooter) {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:"FooterSectionCell", for: indexPath) as! FooterSectionCell
                    
////                footerView.delegate = self
//                footerView.index = indexPath
                return footerView
            } else if (kind == UICollectionView.elementKindSectionHeader) {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:"HeaderSectionCell", for: indexPath) as! HeaderSectionCell
                headerView.lblTodayDate.isHidden = false
                headerView.lblTitle.text = "My Kitchen"
                headerView.imgOfFoodDiaryOrKitchn.image = UIImage(named: "cooking_bowl")
                headerView.btnAddImage.tintColor = UIColor(red: 137/255.0, green: 72/255.0, blue: 159/255.0, alpha: 1.0)
                headerView.btnAddImage.isHidden = false
                headerView.lblTodayDate.text = getFormattedDate(string: dateKitchen!)
                headerView.selctItem = true
                headerView.delegate = self
                headerView.sectionSlect = indexPath.section
                headerView.indexSelect = indexPath

                return headerView
            }
            return UICollectionReusableView()
        }
        else if indexPath.section == 3 {
            if (kind == UICollectionView.elementKindSectionFooter) {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:"ExerciseFooterCell", for: indexPath) as! ExerciseFooterCell
                footerView.delegate = self
                footerView.indexSelect = indexPath
                footerView.btnAddButton.isHidden = false

                return footerView
            }
            else if (kind == UICollectionView.elementKindSectionHeader) {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:"HeaderSectionCell", for: indexPath) as! HeaderSectionCell
                headerView.lblTodayDate.isHidden = false
                headerView.lblTodayDate.text = getFormattedDate(string: dateExecise!)
                headerView.delegate = self
                headerView.sectionSlect = indexPath.section
                headerView.indexSelect = indexPath
                headerView.lblTitle.text = "Exercise"
                headerView.imgOfFoodDiaryOrKitchn.image = UIImage(named: "exercise_cartoon")
                headerView.btnAddImage.tintColor = UIColor(red: 251/255.0, green: 180/255.0, blue: 78/255.0, alpha: 1.0)
                
                headerView.selctItem = true

                return headerView
            }
            return UICollectionReusableView()
        }
        else if indexPath.section == 2 {
            if (kind == UICollectionView.elementKindSectionFooter) {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:"ExerciseFooterCell", for: indexPath) as! ExerciseFooterCell
                footerView.delegate = self
                footerView.indexSelect = indexPath
                footerView.btnAddButton.isHidden = true
                return footerView
            }

        else if (kind == UICollectionView.elementKindSectionHeader) {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier:"HeaderSectionCell", for: indexPath) as! HeaderSectionCell
                headerView.lblTodayDate.isHidden = false
                headerView.lblTodayDate.text = getFormattedDate(string: dOHydration!)
                headerView.delegate = self
                headerView.sectionSlect = indexPath.section
                headerView.indexSelect = indexPath
                headerView.lblTitle.text = "Hydration"
                headerView.imgOfFoodDiaryOrKitchn.image = UIImage(named: "straw_glass")
//                headerView.btnAddImage.isHidden = true
                headerView.selctItem = true
                
                return headerView
            }
            return UICollectionReusableView()
        }
    
        return UICollectionReusableView()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            if isFoodDiaryClick == true {
                return CGSize(width: collectionView.frame.width, height: 95)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
        } else if section == 5 {
            if isKitchenItemClick == true {
                return CGSize(width: collectionView.frame.width, height: 95)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
        }  else if section == 3 {
            if isExerciseOpen == true {
                return CGSize(width: collectionView.frame.width, height: 95)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
        } else if section == 2 {
            if isHydration == true {
                return CGSize(width: collectionView.frame.width, height: 95)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
        }
        else {
            return CGSize(width: 0.0, height: 0.0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            if isFoodDiaryClick == true {
                return CGSize(width: 0.0, height: 0.0)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
        } else if section == 5 {
            if isKitchenItemClick == true {
                return CGSize(width: collectionView.frame.width, height: 0.0)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
            
        }  else if section == 3 {
            if isExerciseOpen == true {
                return CGSize(width: collectionView.frame.width, height: 70)
            } else {
                return CGSize(width: 0.0, height: 0.0)
            }
            
        }
        else if section == 2 {
                if isHydration == true {
                    return CGSize(width: collectionView.frame.width, height: 70)
                } else {
                    return CGSize(width: 0.0, height: 0.0)
                }
                
            }
        else {
            return CGSize(width: 0.0, height: 0.0)

        }
       
    }
}
@available(iOS 13.0, *)

extension HCMainDashboardVC : FoodDiaryClickDelegate {
    func foodDiaryClck(cell: FoodDiaryCell, sect: Int, index: IndexPath) {
        
        let moodSelect = UserDefaults.standard.string(forKey: "moodSelect")
        
        if moodSelect == "2" || moodSelect == nil {
            self.viewOfMood.isHidden = false
        } else {
            self.viewOfMood.isHidden = true
        }

        self.isFoodDiaryClick = true
        isFoodItenOrKitcheSelect = true
         self.isAnimated = true
        self.postCollectionView.reloadData()
    }
}

@available(iOS 13.0, *)
//extension  HCMainDashboardVC : AddFoodItemDelegate {
////    func addItem(cell: FooterSectionCell, index: IndexPath) {
////        viewOfPop.isHidden = false
////        viewOfExercise.isHidden = true
////        if index.section == 1 {
////            self.isFoodItenOrKitcheSelect = true
////        } else if index.section == 5 {
////            self.isFoodItenOrKitcheSelect = false
////        }
////    }
//}
//
@available(iOS 13.0, *)
extension HCMainDashboardVC : AddKitchenItemDelegate {
    func addKitchen(cell: MyKitchenCell, index: IndexPath) {
        isKitchenItemClick = true
        isFoodItenOrKitcheSelect = false
         self.isAnimated = true
        self.postCollectionView.reloadData()

    }
}
@available(iOS 13.0, *)

extension HCMainDashboardVC : ExerciseClickDelegate {
    func exerciseDiaryClick(cell : ExerciseCell , sect : Int , index : IndexPath) {
        isExerciseOpen = true
        self.postCollectionView.reloadData()
        
    }
}
@available(iOS 13.0, *)

extension HCMainDashboardVC : ExerciseDaiaryDelegate {
    func viewMoreExercise(cell: ExerciseFooterCell, index: IndexPath) {
        if index.section == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCHydrationVC") as? HCHydrationVC
            vc?.userInfo = self.responseObj?.getUserDetail

            self.navigationController?.pushViewController(vc!, animated: true)

        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCExerciseVC") as? HCExerciseVC
            vc?.userInfo = self.responseObj?.getUserDetail

            self.navigationController?.pushViewController(vc!, animated: true)

        }
//        let vc = self.storyboard?.instantiateViewController(identifier: "HCExerciseVC") as? HCExerciseVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func exerciseAdd(cell: ExerciseFooterCell, index: IndexPath) {
        viewOfExercise.isHidden = false
        viewOfPop.isHidden = true
    }
}
@available(iOS 13.0, *)

extension HCMainDashboardVC: ProfileInfoDelgate {
    func clickOnProfile(cell : DashboardHeaderCell , index : IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCProfileDetailVC") as? HCProfileDetailVC
        vc?.responseObj = self.responseObj
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
@available(iOS 13.0, *)

extension HCMainDashboardVC : isHydrationClickDelegate {
    func isHydrateClick(cell : HydrationCell , index : IndexPath) {
        isHydration = true
        self.isAnimated = true
        self.postCollectionView.reloadData()

    }
    
}
@available(iOS 13.0, *)

extension HCMainDashboardVC : BottleSelectDelegate {
    func bottleSelect(cell : HydrationSelectCell , selectBottle : Int , index : IndexPath , isButtonSelect : Bool) {
        if selectBottle == 0 {
            if self.responseObj?.getUserDetail?.waterToday?.glass != nil {
                if self.responseObj?.getUserDetail?.waterToday?.glass == "1" {
                    self.glass1 = "0"
                } else {
                    self.glass1 = "1"
                }

            } else {
                
                self.glass1 = "1"

            }
        }
        else if selectBottle == 1 {
            if self.responseObj?.getUserDetail?.waterToday?.glass2 != nil {

            if self.responseObj?.getUserDetail?.waterToday?.glass2 == "1" {
                self.glass2 = "0"
            } else {
                self.glass2 = "1"

              }
            } else {
                self.glass2 = "1"

            }
        } else if selectBottle == 2 {
            if self.responseObj?.getUserDetail?.waterToday?.glass3 != nil {
            if self.responseObj?.getUserDetail?.waterToday?.glass3 == "1" {
                self.glass3 = "0"
            } else {
                self.glass3 = "1"
            }
                
            } else {
                self.glass3 = "1"

            }
        } else if selectBottle == 3 {
            
            if self.responseObj?.getUserDetail?.waterToday?.glass4 != nil {

            if self.responseObj?.getUserDetail?.waterToday?.glass4 == "1" {
                self.glass4 = "0"
            } else {
                self.glass4 = "1"
            }
                
            } else {
                self.glass4 = "1"

            }
        }else if selectBottle == 4 {
            if self.responseObj?.getUserDetail?.waterToday?.glass5 != nil {

            if self.responseObj?.getUserDetail?.waterToday?.glass5 == "1" {
                self.glass5 = "0"
            } else {
                self.glass5 = "1"
             }
            }
            else {
                self.glass5 = "1"

            }
        }
      else if selectBottle == 5 {
            if self.responseObj?.getUserDetail?.waterToday?.glass6 != nil {

            if self.responseObj?.getUserDetail?.waterToday?.glass6 == "1" {
                self.glass6 = "0"
            } else {
                self.glass6 = "1"
            }
            } else {
                self.glass6 = "1"
            }
        }
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             :   userId! ,
                                "glass"              :  self.glass1! ,
                                "glass2"             :  self.glass2!,
                                "glass3"             :  self.glass3!,
                                "glass4"             :  self.glass4!,
                                "glass5"             :  self.glass5!,
                                "glass6"             :  self.glass6!,
                                "date"               :  self.dOHydration!
                                 
                            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: WATERTODAY , isLoaderShow: true, serviceType: "Water Today", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            let responseObj = response as? UserResponse
            if responseObj!.success == true {
//                self!.getAllUserDetail(isLoaderShow: false)

                this.responseObj?.getUserDetail?.waterToday = responseObj?.waterObject
                self!.isAnimated = true
                
                this.postCollectionView.reloadData()
                
            }
            else {
                self!.showAlert(title: KMessageTitle , message: responseObj!.message ?? responseObj!.msg! , controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
        
     }
    
}
@available(iOS 13.0, *)

extension HCMainDashboardVC : AddSleepDelegate {

    func addSleepTime(cell : SleepingCell , selectIndex : IndexPath ) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCChartVC") as? HCChartVC
        vc?.userInfo = self.responseObj?.getUserDetail
        self.navigationController?.pushViewController(vc! , animated: true)
    }

}
@available(iOS 13.0, *)

extension HCMainDashboardVC : IncrementOrDecrementDelegate {
    func addItem(cell: HeaderSectionCell, index: IndexPath) {
        if index.section == 3 {
            viewOfExercise.isHidden = false
            viewOfPop.isHidden = true
        } else {
            viewOfPop.isHidden = false
            viewOfExercise.isHidden = true
            if index.section == 1 {
                self.isFoodItenOrKitcheSelect = true
            } else if index.section == 5 {
                self.isFoodItenOrKitcheSelect = false
            }

        }
    }
    
    func selectDate(cell: HeaderSectionCell, selectIndex: IndexPath, sec: Int, isFoodOrKitchen: Bool) {
        if sec == 1 {
                    let currentDate = Date()
                    var dateComponents = DateComponents()
                    dateComponents.month = 1970
                    
                    let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
                    let datePicker = DatePickerDialog(textColor: .black,
                                                      buttonColor: .black,
                                                      font: UIFont.boldSystemFont(ofSize: 17),
                                                      showCancelButton: true)
                    
                    datePicker.show("",
                                    doneButtonTitle: "Done",
                                    cancelButtonTitle: "Cancel",
                                    minimumDate: threeMonthAgo,
                                    maximumDate: currentDate,
                                    datePickerMode: .date) { (date) in
                                        if let dt = date {
                                            let dateFormatterGet = DateFormatter()
//                                            self.dateOfFood = getDate(dayDifference: 1, selectDate: self.dateOfFood)
                                            self.dateOfFood = dt
                                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                            self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
//                                            self.dateOFCurrent = dateFormatterGet.string(from: self.dateOfFood)
                                            let userId = UserDefaults.standard.string(forKey: "id")
                                            let params =  [
                                                "userid"                             :  userId! ,
                                                "date"                               :  self.dateFormatted! ,
                                                ] as [String : Any]
                                             if isFoodOrKitchen == false {
                                                self.getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen)
                                             } else if self.isKitchenItemClick == true  {
                                                self.getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen)
                                             }
                                        }
                    }
        } else if sec == 2 {
                            let currentDate = Date()
                            var dateComponents = DateComponents()
                            dateComponents.month = 1970
                            let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
                            let datePicker = DatePickerDialog(textColor: .black,
                                                              buttonColor: .black,
                                                              font: UIFont.boldSystemFont(ofSize: 17),
                                                              showCancelButton: true)
                            datePicker.show("",
                                            doneButtonTitle: "Done",
                                            cancelButtonTitle: "Cancel",
                                            minimumDate: threeMonthAgo,
                                            maximumDate: currentDate,
                                            datePickerMode: .date) { (date) in
                                                if let dt = date {
                                                    self.dateOfHydration = dt
                                                    let dateFormatterGet = DateFormatter()
                                                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                                    self.dOHydration = dateFormatterGet.string(from: self.dateOfHydration)
                                                    let userId = UserDefaults.standard.string(forKey: "id")
                                                    let params =  [
                                                        "userid"                             :  userId! ,
                                                        "date"                               :  self.dOHydration! ,
                                                        ] as [String : Any]
                                                    
                                                    self.getWater(params: params, serviceName: GETWATER)

                                                }
                            }
                } else if sec == 3 {
                            let currentDate = Date()
                            var dateComponents = DateComponents()
                            dateComponents.month = 1970
                            let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
                            let datePicker = DatePickerDialog(textColor: .black,
                                                              buttonColor: .black,
                                                              font: UIFont.boldSystemFont(ofSize: 17),
                                                              showCancelButton: true)
                            datePicker.show("",
                                            doneButtonTitle: "Done",
                                            cancelButtonTitle: "Cancel",
                                            minimumDate: threeMonthAgo,
                                            maximumDate: currentDate,
                                            datePickerMode: .date) { (date) in
                                                if let dt = date {
                                                    self.dateOfExercise = dt
                                                    let dateFormatterGet = DateFormatter()
                                                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                                    self.dateExecise = dateFormatterGet.string(from: self.dateOfExercise)
                                                    let userId = UserDefaults.standard.string(forKey: "id")
                                                    let params =  [
                                                        "userid"                             :  userId! ,
                                                        "date"                               :  self.dateExecise! ,
                                                        ] as [String : Any]
                                                    self.getExercise(params: params, serviceName: GETEXERCISE)

                                                }
                            }
                } else if sec == 5 {
                            let currentDate = Date()
                            var dateComponents = DateComponents()
                            dateComponents.month = 1970
                            let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
                            let datePicker = DatePickerDialog(textColor: .black,
                                                              buttonColor: .black,
                                                              font: UIFont.boldSystemFont(ofSize: 17),
                                                              showCancelButton: true)
                            datePicker.show("",
                                            doneButtonTitle: "Done",
                                            cancelButtonTitle: "Cancel",
                                            minimumDate: threeMonthAgo,
                                            maximumDate: currentDate,
                                            datePickerMode: .date) { (date) in
                                                if let dt = date {
                                                    self.dateOfKitchen = dt
                                                    let dateFormatterGet = DateFormatter()
                                                    dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                                    self.dateKitchen = dateFormatterGet.string(from: self.dateOfKitchen)
                                                    let userId = UserDefaults.standard.string(forKey: "id")
                                                    let params =  [
                                                        "userid"                             :  userId! ,
                                                        "date"                               :  self.dateKitchen! ,
                                                        ] as [String : Any]
                                                    if isFoodOrKitchen == false {
                                                        self.getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen )
                                                    } else if self.isKitchenItemClick == true  {
                                                        self.getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen )
                                                    }


                                                }
                            }
                }
    }
    
    func incrementDate(cell : HeaderSectionCell , selectIndex : IndexPath  , sec : Int  , isFoodOrKitchen : Bool) {
        
//        let dateOfCurrent = NSDate()
         let dateOfCurrent = Calendar.current.startOfDay(for: Date())
        if sec == 1 {
        if self.dateOfFood < dateOfCurrent as Date {
            let dateFormatterGet = DateFormatter()
            self.dateOfFood = getDate(dayDifference: 1, selectDate: self.dateOfFood)
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
            let userId = UserDefaults.standard.string(forKey: "id")
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  self.dateFormatted! ,
                ] as [String : Any]
            if isFoodOrKitchen == false {
                getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen)
            } else if isKitchenItemClick == true  {
                getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen )
            }
         }
        } else if sec == 5 {
            
        if self.dateOfKitchen < dateOfCurrent as Date {
            self.dateOfKitchen = getDate(dayDifference: 1, selectDate: self.dateOfKitchen)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateKitchen = dateFormatterGet.string(from: self.dateOfKitchen)
            let userId = UserDefaults.standard.string(forKey: "id")
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  dateKitchen! ,
                ] as [String : Any]
            if isFoodOrKitchen == false {
                getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen )
            } else if isKitchenItemClick == true  {
                getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen )
            }
         }
        } else if sec == 3 {
            
        if self.dateOfExercise < dateOfCurrent as Date {
            self.dateOfExercise = getDate(dayDifference: 1 , selectDate: self.dateOfExercise)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateExecise = dateFormatterGet.string(from: dateOfExercise)
            let userId = UserDefaults.standard.string(forKey: "id")
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  dateExecise! ,
                ] as [String : Any]
            
            getExercise(params: params, serviceName: GETEXERCISE)
            
        }
        }  else if sec == 2 {
            
            if self.dateOfHydration < dateOfCurrent as Date {
                self.dateOfHydration = getDate(dayDifference: 1 , selectDate: self.dateOfHydration)
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                self.dOHydration = dateFormatterGet.string(from: dateOfHydration)
                let userId = UserDefaults.standard.string(forKey: "id")
                let params =  [
                    "userid"                             :  userId! ,
                    "date"                               :  dOHydration! ,
                    ] as [String : Any]
                
                getWater(params: params, serviceName: GETWATER)
//                getExercise(params: params, serviceName: GETEXERCISE)
                
            }
        }

    }
    
    func decrement(cell : HeaderSectionCell , selectIndex : IndexPath  , sec : Int ,  isFoodOrKitchen : Bool ) {
//        isValueIncrementOrDecrement -= 1
        
        if sec == 1 {
            self.dateOfFood = getDate(dayDifference: -1 , selectDate: dateOfFood)
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateFormatted = dateFormatterGet.string(from: self.dateOfFood)
            let userId = UserDefaults.standard.string(forKey: "id")
            
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  self.dateFormatted! ,
                ] as [String : Any]
            if isFoodOrKitchen == false {
                getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen )
                
            } else if isKitchenItemClick == true  {
                getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen )
                
            }
        }
            
        else if sec == 5 {
            self.dateOfKitchen = getDate(dayDifference: -1 , selectDate: dateOfKitchen)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateKitchen = dateFormatterGet.string(from: dateOfKitchen)
            let userId = UserDefaults.standard.string(forKey: "id")
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  dateKitchen! ,
                ] as [String : Any]
            if isFoodOrKitchen == false {
                getKitchOrFoodItem(params: params, serviceName: GETFOOD, isFoodItemSelect: isFoodOrKitchen )
            } else if isKitchenItemClick == true  {
                getKitchOrFoodItem(params: params, serviceName: GETKITCHEN, isFoodItemSelect: isFoodOrKitchen )
            }
        } else if sec == 3 {
            
            self.dateOfExercise = getDate(dayDifference: -1 , selectDate: dateOfExercise)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dateExecise = dateFormatterGet.string(from: dateOfExercise)
            let userId = UserDefaults.standard.string(forKey: "id")
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  dateExecise! ,
                ] as [String : Any]
            getExercise(params: params, serviceName: GETEXERCISE)
            
        }  else if sec == 2 {
            
            self.dateOfHydration = getDate(dayDifference: -1 , selectDate: dateOfHydration)
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            self.dOHydration = dateFormatterGet.string(from: dateOfHydration)
            let userId = UserDefaults.standard.string(forKey: "id")
            let params =  [
                "userid"                             :  userId! ,
                "date"                               :  dOHydration! ,
                ] as [String : Any]
                getWater(params: params, serviceName: GETWATER)

//            getExercise(params: params, serviceName: GETEXERCISE)
            
        }
        
    }
}
@available(iOS 13.0, *)
@available(iOS 13.0, *)

extension HCMainDashboardVC : DeleteFootItemDelegate {
   
    func deleteFoodItem(cell: FoodDiaryItemCell, indexSeelect: IndexPath, section: Int) {
        if section == 1 {
            var idOfFooItem : String?
            if self.responseObj?.getUserDetail?.foodToday![indexSeelect.row].id != nil {
                idOfFooItem = self.responseObj?.getUserDetail?.foodToday![indexSeelect.row].id
                if let index = self.responseObj?.getUserDetail?.foodToday?.index(where: {$0.id == idOfFooItem}) {
                   
                    self.postCollectionView?.performBatchUpdates({
                        self.responseObj?.getUserDetail?.foodToday?.remove(at: index)
                        let indexSet = IndexSet(integer: 1)
                        self.postCollectionView.reloadSections(indexSet)

                    }, completion: nil)

//                    self.postCollectionView.reloadData()
                }

            } else {
                let idOfItem = self.responseObj?.getUserDetail?.foodToday![indexSeelect.row].idOfItem
                idOfFooItem = String(idOfItem!)
                if let index = self.responseObj?.getUserDetail?.foodToday?.index(where: {$0.idOfItem == idOfItem}) {
                    self.postCollectionView?.performBatchUpdates({
                         self.responseObj?.getUserDetail?.foodToday?.remove(at: index)
                        let indexSet = IndexSet(integer: 1)
                        self.postCollectionView.reloadSections(indexSet)
                    }, completion: nil)

                }

            }
            deleteItem(idOfItem: idOfFooItem!, word: "food")
        } else if section == 5 {
            var idOfKitchenItem : String?
            if self.responseObj?.getUserDetail?.kitchenObject![indexSeelect.row].id != nil {
                idOfKitchenItem = self.responseObj?.getUserDetail?.kitchenObject![indexSeelect.row].id
                if let index = self.responseObj?.getUserDetail?.kitchenObject?.index(where: {$0.id == idOfKitchenItem}) {
                    self.postCollectionView?.performBatchUpdates({
                         self.responseObj?.getUserDetail?.kitchenObject?.remove(at: index)
                        let indexSet = IndexSet(integer: 5)
                        self.postCollectionView.reloadSections(indexSet)
                        
                    }, completion: nil)
                }
                
                
            } else {
                let idOfItem = self.responseObj?.getUserDetail?.kitchenObject![indexSeelect.row].idOfItem
                idOfKitchenItem = String(idOfItem!)
                if let index = self.responseObj?.getUserDetail?.kitchenObject?.index(where: {$0.idOfItem == idOfItem}) {
                    self.postCollectionView?.performBatchUpdates({
                        self.responseObj?.getUserDetail?.kitchenObject?.remove(at: index)
                        let indexSet = IndexSet(integer: 4)
                        self.postCollectionView.reloadSections(indexSet)
                        
                    }, completion: nil)

                }
            }
              deleteItem(idOfItem: idOfKitchenItem!, word: "kitchen")

        }
    }
    
}

//extension Date
//{
//    var startOfDay: Date
//    {
//        return Calendar.current.startOfDay(for: self)
//    }
//
//    func getDate(dayDifference: Int) -> Date {
//        var components = DateComponents()
//        components.day = dayDifference
//        return Calendar.current.date(byAdding: components, to:startOfDay)!
//    }
//}
//

