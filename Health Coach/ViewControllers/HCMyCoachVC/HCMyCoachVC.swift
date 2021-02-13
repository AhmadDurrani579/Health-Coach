//
//  HCMyCoachVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCMyCoachVC: UIViewController {
    @IBOutlet weak var tblViewss: UITableView!
    var responseObj: UserResponse?
    var coach      :  Coach?
    
    @IBOutlet weak var lblName: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var firstName : String?
    var lastName  : String?
    var prfilePic: String = ""
//    @IBOutlet weak var tblViewss: UITableView!
    var appointment : AppointmentList?
    let formatter = DateFormatter()
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // initially set the format based on your datepicker date / server String

    @IBOutlet weak var viewOfAppointment: UIView!
    @IBOutlet weak var lblCurrentAppointmentDate: UILabel!
    @IBOutlet weak var lblCurrentAppointMentTime: UILabel!
    @IBOutlet weak var lblCoachName: UILabel!
    @IBOutlet weak var viewOfPrgramGuide: UIView!
    @IBOutlet weak var imgOfCoach: UIImageView!

    

    var selectDate : String?
    var today : String?
    var startTime : String?
    var endTime : String?
    var isComingFromSignUpOrMain : String?
           
    var responseObjs : Coach?
    var selectCoachTime : CoachSlot?
    var selectItem : Int?

    @IBOutlet weak var lbltxtOfBooking: UILabel!
    @IBOutlet weak var viewOfBookingAPpointment: UIView!
    @IBOutlet weak var viewOfBookTrial: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if
//        getAllUserDetail()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addNotification(_:)), name: NSNotification.Name(rawValue: "notificationReceive"), object: nil)

        tblViewss.register(UINib(nibName: "MyCoachHeaderCell", bundle: nil), forCellReuseIdentifier: "MyCoachHeaderCell")
        tblViewss.register(UINib(nibName: "MessageOrAppointMentCell", bundle: nil), forCellReuseIdentifier: "MessageOrAppointMentCell")
        tblViewss.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: "UserInfoCell")
        tblViewss.register(UINib(nibName: "SelectServiceHeaderCell", bundle: nil), forCellReuseIdentifier: "SelectServiceHeaderCell")
        tblViewss.register(UINib(nibName: "ServiceHeaderCell", bundle: nil), forCellReuseIdentifier: "ServiceHeaderCell")
        
        
        firstName = UserDefaults.standard.string(forKey: "firstName")
        lastName = UserDefaults.standard.string(forKey: "lastName")
        prfilePic = UserDefaults.standard.string(forKey: "profile") ?? ""
        if appDelegate.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
            if appDelegate.responseObj?.getUserDetail?.subscription?.trial == false {
//                getService()
                lbltxtOfBooking.text = "Experience\n our Holistic Health Program\n with Your Private Health Coach \n through a One to One Video Session"
                self.viewOfAppointment.isHidden = false
                self.viewOfBookTrial.isHidden = false
                self.viewOfBookingAPpointment.isHidden = true

                
                formatter.dateFormat = "yyyy-MM-dd"

                tblViewss.register(UINib(nibName: "AppointMentCell", bundle: nil), forCellReuseIdentifier: "AppointMentCell")
                tblViewss.register(UINib(nibName: "ScheduleCreateCell", bundle: nil), forCellReuseIdentifier: "ScheduleCreateCell")
                tblViewss.register(UINib(nibName: "HCDateSelectCell", bundle: nil), forCellReuseIdentifier: "HCDateSelectCell")

                let currenDate = Date()
                selectDate = formatter.string(from: currenDate)
                getCoachListSlot()

        } else {
            getCoachInfo()
          }
        } else {
            getCoachInfo()
        }
    }
    
    @objc func addNotification(_ notification: NSNotification) {
          if appDelegate.badgeCount != 0 {
            tblViewss.reloadData()
           
          } else {
        //            self.tabBar.items![3].badgeValue = "\(appDelegate.badgeCount)"
                }
                
    }

    func getCoachListSlot() {
            let coachId = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id
                
            print(appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id)
                let loginParam =      [ "date"             : selectDate! ,
                                        "coachid"          : appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id ?? "1"
                                      ] as [String : Any]
                WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: COACHSLOT , isLoaderShow: true, serviceType: "Coach Slot", modelType: Coach.self, success: { [weak self] (response) in
                    guard let this = self else {
                        return
                    }
                     this.responseObjs = (response as! Coach)
                    if this.responseObjs!.success == true {
                        this.tblViewss.delegate = self
                        this.tblViewss.dataSource = self
                        this.tblViewss.reloadData()
                    }
                    else {
                        self?.showToast(this.responseObjs!.message ?? this.responseObj!.msg!)
                        this.tblViewss.delegate = self
                        this.tblViewss.dataSource = self
                        this.tblViewss.reloadData()
                     }
                    }, fail: { (error) in
                }, showHUD: true)
        
    }
    
    @IBAction func btnBooking_Pressed(_ sender: UIButton) {
        self.viewOfAppointment.isHidden = true
        self.viewOfBookTrial.isHidden = true
        self.viewOfBookingAPpointment.isHidden = false

    }
    @IBAction func btnCreateAppointment(_ sender: UIButton) {
        if selectCoachTime != nil {
            let userId = UserDefaults.standard.string(forKey: "id")
            let serviceName = appointment?.service_name
            let serviceId = appointment?.id
            
            let loginParam =        [  "coachid"         : "2",
                                       "userid"         : userId! ,
                                       "from"           : selectCoachTime?.time_from ?? " " ,
                                       "to"             : selectCoachTime?.time_to ?? " " ,
                                       "day"            : today ?? " " ,
                                       "date"           : selectDate! ,
                                       "service_name"   : serviceName ?? "45 minutes Meeting" ,
                                       "service_id"      : "\(serviceId ?? 51405)"
                                    ] as [String : Any]
            WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: DO_APPOINTMENT , isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
                        let responseObj = response as! UserResponse
                        if responseObj.success == true {
                            
                                UserDefaults.standard.set(true, forKey: "subscribe")
                                self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("IsImageUpload"), object: nil)
                                self?.viewOfBookTrial.isHidden = true
                                self?.viewOfAppointment.isHidden = true
                                self?.tabBarController?.selectedIndex = 0

//                            if self?.isComingFromSignUpOrMain == "signUp" {
//                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//                                let vc = storyboard.instantiateViewController(withIdentifier: "HCDashboardVC") as? HCDashboardVC
//                                UserDefaults.standard.set(true, forKey: "subscribe")
//                                self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true
//                                self?.navigationController?.pushViewController(vc!, animated: true)
//
//                            } else {
//                                UserDefaults.standard.set(true, forKey: "subscribe")
//                                self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true
//                                let nc = NotificationCenter.default
//                                nc.post(name: Notification.Name("IsImageUpload"), object: nil)
//                                self?.navigationController?.popToRootViewController(animated: true)
//
//                            }

                        }
                        else {
                            self!.showAlert(title: KMessageTitle , message: responseObj.message ?? responseObj.msg ?? "Appointment Failed"  , controller: self)
                        }
                        }, fail: { (error) in
                    }, showHUD: true)
        } else {
            self.showToast("Select Time First")
        }

    }
    
        @IBAction func btnCrossPop(_ sender: UIButton) {
            self.viewOfAppointment.isHidden = true
        }
        //    func minimumDate(for calendar: FSCalendar) -> Date {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //        let myString = formatter.string(from: Date())
    //        let yourDate = formatter.date(from: myString)
    //        formatter.dateFormat = "yyyy-MM-dd"
    //        let strCurrentDate = formatter.string(from: yourDate!)
    //        return self.formatter.date(from: strCurrentDate)!
    //    }
        
        func getFormattedDate(string: String) -> String{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
            
            let dateFormatterDay = DateFormatter()
            dateFormatterDay.dateFormat = "EEEE"

            let date: Date? = dateFormatterGet.date(from: string)
            let selectedDay: Date? = dateFormatterGet.date(from: string)
            
            print("Today Day",dateFormatterDay.string(from: selectedDay!)) // Feb 01,2018
            today = dateFormatterDay.string(from: selectedDay!)
            print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
            return dateFormatterPrint.string(from: date!);
        }

    
//    func getService() {
//         WebServiceManager.get(params: nil, serviceName: GET_APPOINTMENT , serviceType: "Service List", modelType: UserResponse.self, success: {[weak self] (response) in
//          self!.responseObj = (response as! UserResponse)
//          if  self!.responseObj?.success == true {
//            self?.tblViewss.delegate = self
//            self?.tblViewss.dataSource = self
//            self?.tblViewss.reloadData()
//        }
//        else {
//            self?.showToast((self!.responseObj?.message)!)
//         }
//         }) { (error) in
//
//        }
//    }
    
    func getCoachInfo() {
        let userId = UserDefaults.standard.string(forKey: "id")
        let loginParam =      [ "userid"             : userId!
                              ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: COACH_PROFILE , isLoaderShow: true, serviceType: "Coach", modelType: Coach.self, success: { [weak self] (response) in
            
            guard let this = self else {
                return
            }
            this.coach = (response as! Coach)
            
            if this.coach!.success == true {
                this.tblViewss.delegate = self
                this.tblViewss.dataSource = self
                this.tblViewss.reloadData()
                
            }
            else {
                self!.showAlert(title: KMessageTitle , message: "Error", controller: self)
            }
            }, fail: { (error) in
        }, showHUD: true)
    }


}
@available(iOS 13.0, *)
extension HCMyCoachVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      if appDelegate.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
         if appDelegate.responseObj?.getUserDetail?.subscription?.trial == false {
               return 3
         } else {
            return 3
        }
      } else {
          return 3
      }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if appDelegate.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
           if appDelegate.responseObj?.getUserDetail?.subscription?.trial == false {
            if section == 0 {
                return 1
            } else if section == 1 {
                return responseObjs?.coachSlot?.count ?? 0
            } else {
                return 1
            }

//            if section == 0 {
//                return 1
//            } else {
//                return self.responseObj?.appointMentList?.count ?? 0
//            }
           } else {
              if section == 0 {
                        return 1
                    } else if section == 1 {
                        return 1
                    } else {
                        return 1
                    }
            }
        }
        else {
           if section == 0 {
                     return 1
                 } else if section == 1 {
                     return 1
                 } else {
                     return 1
                 }
        }

        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if appDelegate.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
           if appDelegate.responseObj?.getUserDetail?.subscription?.trial == false {
            
                    if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AppointMentCell", for: indexPath) as? AppointMentCell
                     cell?.viewOfCalender.delegate = self
            //         cell?.viewOfCalender.today = nil
            //            fsCalendar.locale = NSLocale(localeIdentifier: "fa_IR") as Locale
            //            fsCalendar.select(Date())
            //            fsCalendar.identifier = NSCalendar.Identifier.persian.rawValue
            //            cell?.viewOfCalender.select(Data())
                        
                        
                        cell?.viewOfCalender.allowsMultipleSelection = false
                        return cell!

                    } else if indexPath.section == 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HCDateSelectCell", for: indexPath) as? HCDateSelectCell
                        let timeFrom = responseObjs?.coachSlot![indexPath.row].time_from
                        if indexPath.row == selectItem {
                            cell!.viewOfBG.backgroundColor = UIColor(red: 44/255.0, green: 212/255.0, blue: 233/255.0, alpha: 1.0)
                            cell?.lblCurrentDate.textColor = UIColor.white
                        } else {
                            cell!.viewOfBG.backgroundColor = UIColor.white
                            cell?.lblCurrentDate.textColor = UIColor(red: 44/255.0, green: 212/255.0, blue: 233/255.0, alpha: 1.0)

                        }
                        
                        cell?.delegate = self
                        cell?.indexSelect = indexPath
                        let timeTo = responseObjs?.coachSlot![indexPath.row].time_to
                        cell?.lblCurrentDate.text = "From \(timeFrom!) To  \(timeTo!)"
                        return cell!
                    }
                    else {
                      let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCreateCell", for: indexPath) as? ScheduleCreateCell
                        cell?.delegate = self
                      return cell!
                    }

//            if indexPath.section  == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceHeaderCell", for: indexPath) as? ServiceHeaderCell
////                let firstName = appDelegate.responseObj?.getUserDetail?.userDetailObject?.first_name
////                let lastName = appDelegate.responseObj?.getUserDetail?.userDetailObject?.last_name
//                cell?.lblName.text = "\(self.firstName!) \(self.lastName!)"
//                //= self.responseObj?.getUserDetail?.userDetailObject?.first_name
////                cell?.lblService.text = "Please select service"
////                cell?.viewOfInfo.isHidden = true
////                cell?.lblAddress.text = "Arbab Road peshawer"
//                return cell!
//
//
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "SelectServiceHeaderCell", for: indexPath) as? SelectServiceHeaderCell
//                cell?.lblServiceName.text = self.responseObj?.appointMentList![indexPath.row].service_name
//
//                let duration =  self.responseObj?.appointMentList![indexPath.row].duration
//                cell?.lblDuration.text = "Duration    \(duration!) "
//                return cell!
//
//            }
           } else {
                      if indexPath.section == 0 {
                          let cell = tableView.dequeueReusableCell(withIdentifier: "MyCoachHeaderCell", for: indexPath) as? MyCoachHeaderCell
//                                      let firstName = self.responseObj?.getUserDetail?.userDetailObject?.first_name
//                                      let lastName = self.responseObj?.getUserDetail?.userDetailObject?.last_name
                                      cell?.lblUserName.text = "\(self.firstName!) \(self.lastName!)"
                          //            cell?.viewOfInfo.isHidden = false
                                      cell?.lblCoachName.text = self.coach?.coachProfile?.name
                                      cell?.lblAddress.text = self.coach?.coachProfile?.country
                                     cell?.delegate = self
                        
                        
                        
                                    WAShareHelper.loadImage(urlstring:prfilePic , imageView: ((cell?.imgOfUser!)!), placeHolder: "profile")

                                      guard  let image = self.coach?.coachProfile?.profile_pic  else   {
                                          return cell!
                                      }
                                      WAShareHelper.loadImage(urlstring:image , imageView: ((cell?.imgOfCoach!)!), placeHolder: "profile")
                                      let cgFloat: CGFloat = (cell?.imgOfCoach.frame.size.width)!/2.0
                                      let someFloat = Float(cgFloat)
                                      WAShareHelper.setViewCornerRadius(cell!.imgOfCoach, radius: CGFloat(someFloat))


                          return cell!
                      } else if indexPath.section == 1 {
                          let cell = tableView.dequeueReusableCell(withIdentifier: "MessageOrAppointMentCell", for: indexPath) as? MessageOrAppointMentCell
                        let badgeCount = UserDefaults.standard.integer(forKey: "Notification")

                        if badgeCount != 0 {
                            cell?.btnBadge.badgeString = "\(badgeCount)"
                        } else {
                            cell?.btnBadge.badgeString = nil
                        }

//                        cell?.btnBadge.badgeString = "\(appDelegate.badgeCount)"
                          cell?.delegate = self
                          cell?.selectIndex = indexPath
                        
                        if appDelegate.responseObj?.getUserDetail?.nextAppointMent?.count == 0 {
                             cell?.lblAppointmentDate.text = "No Schedule yet"
                        } else {
                            cell?.lblAppointmentDate.text = "Next \(appDelegate.responseObj?.getUserDetail?.nextAppointMent![0].date ?? " ")"
                        }

//                        guard let appointment = appDelegate.responseObj?.getUserDetail?.nextAppointMent  else {
//                            cell?.lblAppointmentDate.text = "No Schedule yet"
//                            return cell!
//                        }
//                          cell?.lblAppointmentDate.text = "Next \(appDelegate.responseObj?.getUserDetail?.nextAppointMent![0].date ?? " ")"
                          return cell!
                          
                      } else {
                          let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell
                          
                        cell?.lblGender.text = self.coach?.coachProfile?.gender
                        cell?.lblAge.text = self.coach?.coachProfile?.speciality
                        cell?.lblHobby.text = self.coach?.coachProfile?.hobby
                        cell?.txtOfAbout.text = self.coach?.coachProfile?.occupation

                          return cell!
                      }

          }
        } else {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCoachHeaderCell", for: indexPath) as? MyCoachHeaderCell
            cell?.btnSubsCription.isHidden = true
            cell?.lblUserName.text = "\(self.firstName!) \(self.lastName!)"
            cell?.lblCoachName.text = self.coach?.coachProfile?.name
            cell?.lblAddress.text = self.coach?.coachProfile?.country
            guard  let image = self.coach?.coachProfile?.profile_pic  else   {
                return cell!
            }
            WAShareHelper.loadImage(urlstring:image , imageView: ((cell?.imgOfCoach!)!), placeHolder: "profile")
            let cgFloat: CGFloat = (cell?.imgOfCoach.frame.size.width)!/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(cell!.imgOfCoach, radius: CGFloat(someFloat))
//             = self.responseObj?.getUserDetail?.userDetailObject?.first_name
            
            return cell!
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageOrAppointMentCell", for: indexPath) as? MessageOrAppointMentCell
            cell?.delegate = self
            cell?.selectIndex = indexPath
//            cell?.btnBadge.badgeString = "2"
            let badgeCount = UserDefaults.standard.integer(forKey: "Notification")

            if badgeCount != 0 {
                cell?.btnBadge.badgeString = "\(badgeCount)"
            } else {
                cell?.btnBadge.badgeString = nil
            }
             
            if appDelegate.responseObj?.getUserDetail?.nextAppointMent?.count == 0 {
                 cell?.lblAppointmentDate.text = "No Schedule yet"
            } else {
                cell?.lblAppointmentDate.text = "Next \(appDelegate.responseObj?.getUserDetail?.nextAppointMent![0].date ?? " ")"

            }
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell
            cell?.lblGender.text = self.coach?.coachProfile?.gender
            cell?.lblAge.text = self.coach?.coachProfile?.speciality
            cell?.lblHobby.text = self.coach?.coachProfile?.hobby
            cell?.txtOfAbout.text = self.coach?.coachProfile?.occupation
            return cell!
        }
            
     }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if appDelegate.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
           if appDelegate.responseObj?.getUserDetail?.subscription?.trial == false {
//            if indexPath.section == 0 {
//                return 190.0
//            } else {
//                return 120.0
//            }
            
            if indexPath.section == 0 {
                return 408.0
            } else if indexPath.section == 1 {
                return 62.0
            }
            else {
                return 65.0
            }

           }   else {
            if indexPath.section == 0 {
                return 253.0
            } else if indexPath.section == 1 {
                   return 213.0
               } else {
                   return 291.0
               }
           }

            
        }
        else {
           if indexPath.section == 0 {
              return 253.0

           } else if indexPath.section == 1 {
            return 213.0
           } else {
               return 291.0
           }
            
        }
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if appDelegate.responseObj?.getUserDetail?.subscription?.is_subscribed == false {
           if appDelegate.responseObj?.getUserDetail?.subscription?.trial == false {
            if indexPath.section == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier : "HCAppointmentSelectionVC") as? HCAppointmentSelectionVC
                vc?.appointment = self.responseObj?.appointMentList![indexPath.row]
                self.navigationController?.pushViewController(vc!, animated: true)
            }
         }
    }
}
}

@available(iOS 13.0, *)

extension HCMyCoachVC : SubscriptionDelegate {
    func subscription(cell : MyCoachHeaderCell) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCPayNowVC") as? HCPayNowVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}

@available(iOS 13.0, *)

extension HCMyCoachVC : ServiceListDelegate {
    func checkNotificationList(cell: MessageOrAppointMentCell, selectIndex: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCChatListVC") as? HCChatListVC
        vc?.isComeFromTabScreen = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func appointmentList(cell : MessageOrAppointMentCell  , selectIndex : IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCMySessionVC") as? HCMySessionVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func chatMessage(cell : MessageOrAppointMentCell  , selectIndex : IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCChat") as? HCChat
        vc?.isComeFromCoachView = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }


}


@available(iOS 13.0, *)
//
extension HCMyCoachVC : SelectDateAndTimeDelegate  {
    func selectTime(cell: HCDateSelectCell, index: IndexPath) {
        if cell.btnTime.isSelected == true {
            selectItem = index.row
            self.selectCoachTime = responseObjs?.coachSlot![index.row]
            cell.viewOfBG.backgroundColor = UIColor(red: 44/255.0, green: 212/255.0, blue: 233/255.0, alpha: 1.0)
        } else {
            selectItem = nil
            self.selectCoachTime = nil
            cell.viewOfBG.backgroundColor = UIColor.white
        }
        tblViewss.reloadData()

    }
//
}

@available(iOS 13.0, *)

extension HCMyCoachVC : FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
//        print(date)
        selectDate = formatter.string(from: date)
        print(selectDate)
        calendar.today = nil

    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDate = formatter.string(from: date)
        
        getCoachListSlot()
//        print(selectDate)
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let curDate = Date().addingTimeInterval(-24*60*60)
        if date < curDate {
            return false
        } else {
            calendar.today = nil

            return true
        }
    }
    
   func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//            calendar.select(date)
            calendar.today = nil
   }


}
@available(iOS 13.0, *)

extension HCMyCoachVC : ScheduleDelegate {
    func createSchedule(cell: ScheduleCreateCell) {
        
        if selectCoachTime != nil {
        if selectDate != nil {
//            headerView.lblTodayDate.text =
            lblCurrentAppointmentDate.text =  getFormattedDate(string: selectDate!)
            lblCurrentAppointMentTime.text = "\(selectCoachTime?.time_from! ?? "") to  \(selectCoachTime?.time_to! ?? "hi")"
            lblCoachName.text = "Hi I am your coach \(appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_firstname ?? "")"
            viewOfAppointment.isHidden = false
            self.viewOfBookTrial.isHidden = true
            self.viewOfBookingAPpointment.isHidden = false
            let cgFloat: CGFloat = (imgOfCoach.frame.size.width)/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(imgOfCoach, radius: CGFloat(someFloat))
            guard  let image = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coachPic  else   {
                return imgOfCoach.image = UIImage(named: "profile")
            }
            WAShareHelper.loadImage(urlstring:image , imageView: ((imgOfCoach!)), placeHolder: "profile")


        }
        } else {
            self.showToast("Select Time First")
        }
    }
}
