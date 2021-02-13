//
//  HCAppointmentSelectionVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 29/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import DatePickerDialog

@available(iOS 13.0, *)
class HCAppointmentSelectionVC: UIViewController {
    @IBOutlet weak var tblViewss: UITableView!
    var appointment : AppointmentList?
    let formatter = DateFormatter()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedAppointment: Appointment?
    // initially set the format based on your datepicker date / server String

    @IBOutlet weak var viewOfAppointment: UIView!
    @IBOutlet weak var lblCurrentAppointmentDate: UILabel!
    @IBOutlet weak var lblCurrentAppointMentTime: UILabel!

    var selectDate : String?
    var today : String?
    var startTime : String?
    var endTime : String?
    var isComingFromSignUpOrMain : String?
           
    var responseObj: Coach?
    var selectCoachTime : CoachSlot?
    var selectItem : Int?
    
    @IBOutlet weak var viewOfBookTrial: UIView!
    @IBOutlet weak var lbltxtOfBooking: UILabel!
    @IBOutlet weak var viewOfBookingAPpointment: UIView!
    @IBOutlet weak var viewOfPrgramGuide: UIView!

    @IBOutlet weak var lblCoachName: UILabel!
    @IBOutlet weak var imgOfCoach: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy-MM-dd"

        tblViewss.register(UINib(nibName: "AppointMentCell", bundle: nil), forCellReuseIdentifier: "AppointMentCell")
        tblViewss.register(UINib(nibName: "ScheduleCreateCell", bundle: nil), forCellReuseIdentifier: "ScheduleCreateCell")
        tblViewss.register(UINib(nibName: "HCDateSelectCell", bundle: nil), forCellReuseIdentifier: "HCDateSelectCell")

        let currenDate = Date()
        selectDate = formatter.string(from: currenDate)
        getCoachListSlot()
        
        lbltxtOfBooking.text = "Experience\n our Holistic Health Program\n with Your Private Health Coach \n through a One to One Video Session"
        viewOfAppointment.isHidden = false
        viewOfBookTrial.isHidden = false
        viewOfBookingAPpointment.isHidden = true
        viewOfPrgramGuide.isHidden = true
    }
    
    @IBAction func btnPrgramGuide_Pressed(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HCSelectedProgramVC") as? HCSelectedProgramVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }

    @IBAction func btnBooking_Pressed(_ sender: UIButton) {
        self.viewOfAppointment.isHidden = true
        self.viewOfBookTrial.isHidden = true
        self.viewOfBookingAPpointment.isHidden = false
        viewOfPrgramGuide.isHidden = true

    }
    
    func getCoachListSlot() {
            let coachId = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id
                
                let loginParam =      [ "date"             : selectDate! ,
                                        "coachid"          : coachId
                                      ] as [String : Any]
                WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: COACHSLOT , isLoaderShow: true, serviceType: "Coach Slot", modelType: Coach.self, success: { [weak self] (response) in
                    guard let this = self else {
                        return
                    }
                     this.responseObj = (response as! Coach)
                    if this.responseObj!.success == true {
                        this.tblViewss.delegate = self
                        this.tblViewss.dataSource = self
                        this.tblViewss.reloadData()
                    }
                    else {
                        self?.showToast(this.responseObj!.message ?? this.responseObj!.msg!)
                        this.tblViewss.delegate = self
                        this.tblViewss.dataSource = self
                        this.tblViewss.reloadData()
                     }
                    }, fail: { (error) in
                }, showHUD: true)
        
    }
    
    @IBAction func btnCreateAppointment(_ sender: UIButton) {
        
        if selectedAppointment != nil {
            if selectCoachTime != nil {
                let appointmentId = selectedAppointment?.id
                let loginParam =        [ "from"            : selectCoachTime?.time_from ?? " " ,
                                           "to"             : selectCoachTime?.time_to ?? " " ,
                                           "date"           : selectDate! ,
                                           "appointment_id"     : "\(appointmentId ?? "51405")"
                                        ] as [String : Any]
                WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: UPDATEAPPOINTMENT , isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
                            let responseObj = response as! UserResponse
                            if responseObj.success == true {
                                if self?.isComingFromSignUpOrMain == "signUp" {
                                    
                                    UserDefaults.standard.set(true, forKey: "subscribe")
                                    self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true

                                    self!.viewOfAppointment.isHidden = false
                                    self!.viewOfBookTrial.isHidden = true
                                    self!.viewOfBookingAPpointment.isHidden = true
                                    self!.viewOfPrgramGuide.isHidden = false

                                } else {
                                    UserDefaults.standard.set(true, forKey: "subscribe")
                                    self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true
                                    let nc = NotificationCenter.default
                                    nc.post(name: Notification.Name("IsImageUpload"), object: nil)
                                    self?.navigationController?.popToRootViewController(animated: true)
                                }

                            }
                            else {
                                self!.showAlert(title: KMessageTitle , message: responseObj.message ?? responseObj.msg ?? "Appointment Failed"  , controller: self)
                            }
                            }, fail: { (error) in
                        }, showHUD: true)
            } else {
                self.showToast("Select Time First")
            }
        } else {
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
                                if self?.isComingFromSignUpOrMain == "signUp" {
                                    
                                    UserDefaults.standard.set(true, forKey: "subscribe")
                                    self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true

                                    self!.viewOfAppointment.isHidden = false
                                    self!.viewOfBookTrial.isHidden = true
                                    self!.viewOfBookingAPpointment.isHidden = true
                                    self!.viewOfPrgramGuide.isHidden = false

                                } else {
                                    UserDefaults.standard.set(true, forKey: "subscribe")
                                    self!.appDelegate.responseObj?.getUserDetail?.subscription?.trial = true
                                    let nc = NotificationCenter.default
                                    nc.post(name: Notification.Name("IsImageUpload"), object: nil)
                                    self?.navigationController?.popToRootViewController(animated: true)
                                }

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


}
@available(iOS 13.0, *)

extension HCAppointmentSelectionVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return responseObj?.coachSlot?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            let timeFrom = responseObj?.coachSlot![indexPath.row].time_from
            if indexPath.row == selectItem {
                cell!.viewOfBG.backgroundColor = UIColor(red: 44/255.0, green: 212/255.0, blue: 233/255.0, alpha: 1.0)
                cell?.lblCurrentDate.textColor = UIColor.white
            } else {
                cell!.viewOfBG.backgroundColor = UIColor.white
                cell?.lblCurrentDate.textColor = UIColor(red: 44/255.0, green: 212/255.0, blue: 233/255.0, alpha: 1.0)

            }
            
            cell?.delegate = self
            cell?.indexSelect = indexPath
            let timeTo = responseObj?.coachSlot![indexPath.row].time_to
            cell?.lblCurrentDate.text = "From \(timeFrom!) To  \(timeTo!)"
            return cell!
        }
        else {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCreateCell", for: indexPath) as? ScheduleCreateCell
            cell?.delegate = self
          return cell!
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        if indexPath.section == 1 {
//////            selectCoachTime
////        }
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 408.0
        } else if indexPath.section == 1 {
            return 62.0
        }
        else {
            return 65.0
        }
    }
}

@available(iOS 13.0, *)
//
extension HCAppointmentSelectionVC : SelectDateAndTimeDelegate  {
    func selectTime(cell: HCDateSelectCell, index: IndexPath) {
        if cell.btnTime.isSelected == true {
            selectItem = index.row
            self.selectCoachTime = responseObj?.coachSlot![index.row]
            cell.viewOfBG.backgroundColor = UIColor(red: 44/255.0, green: 212/255.0, blue: 233/255.0, alpha: 1.0)
        } else {
            selectItem = nil
            self.selectCoachTime = nil
            cell.viewOfBG.backgroundColor = UIColor.white
        }
        tblViewss.reloadData()

    }
//    func selectStartTime(cell : HCDateSelectCell) {
//            let currentDate = Date()
//            var dateComponents = DateComponents()
//            dateComponents.month = 1970
//            let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
//
//            let datePicker = DatePickerDialog(textColor: .black,
//                                              buttonColor: .black,
//                                              font: UIFont.boldSystemFont(ofSize: 17),
//                                              showCancelButton: true)
//            datePicker.show("DatePickerDialog",
//                            doneButtonTitle: "Done",
//                            cancelButtonTitle: "Cancel",
//                            minimumDate: threeMonthAgo,
//                            maximumDate: currentDate,
//                            datePickerMode: .time) { (date) in
//                                if let dt = date {
//                                    let formatter = DateFormatter()
//                                    formatter.dateFormat = "h:mm:ss a"
//                                    formatter.timeZone = TimeZone(abbreviation: "UTC")
//
//                                    let endDates = dt.addingTimeInterval(45.0 * 60.0)
//
//                                    self.endTime =  formatter.string(from: endDates)
//                                    let dateValue = formatter.string(from: dt)
//                                    cell.btnEndDateE.setTitle(self.endTime, for: .normal)
//                                    cell.btnStartDate.setTitle(dateValue, for: .normal)
//                                    self.startTime = dateValue
//
//                                }
//            }
//
//    }
//    func endTimeSelect(cell : HCDateSelectCell) {
////            let currentDate = Date()
////            var dateComponents = DateComponents()
////            dateComponents.month = 1970
////            let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
////
////            let datePicker = DatePickerDialog(textColor: .black,
////                                              buttonColor: .black,
////                                              font: UIFont.boldSystemFont(ofSize: 17),
////                                              showCancelButton: true)
////            datePicker.show("DatePickerDialog",
////                            doneButtonTitle: "Done",
////                            cancelButtonTitle: "Cancel",
////                            minimumDate: threeMonthAgo,
////                            maximumDate: currentDate,
////                            datePickerMode: .time) { (date) in
////                                if let dt = date {
////                                    let formatter = DateFormatter()
////                                    formatter.dateFormat = "h:mm:ss a"
////                                    let dateValue = formatter.string(from: dt)
////                                    cell.btnEndDateE.setTitle(dateValue, for: .normal)
////                                    self.endTime = dateValue
////
////                                }
////            }
//
//    }
//
}
//extension HCMyCoachVC : ServiceListDelegate {
//
//    func appointmentList(cell : MessageOrAppointMentCell  , selectIndex : IndexPath) {
//
//    }
//
//}

@available(iOS 13.0, *)
extension HCAppointmentSelectionVC : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
//        print(date)
        selectDate = formatter.string(from: date)
//        print(selectDate)
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

extension HCAppointmentSelectionVC : ScheduleDelegate {
    func createSchedule(cell: ScheduleCreateCell) {
        if selectCoachTime != nil {
        if selectDate != nil {
//            headerView.lblTodayDate.text =
            lblCurrentAppointmentDate.text =  getFormattedDate(string: selectDate!)
            lblCurrentAppointMentTime.text = "\(selectCoachTime?.time_from! ?? "") to \n \(selectCoachTime?.time_to! ?? "hi")"
//            lblCoachName.text = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_firstname
            lblCoachName.text = "Hi I am your coach \(appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_firstname ?? "")"
            let cgFloat: CGFloat = (imgOfCoach.frame.size.width)/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(imgOfCoach, radius: CGFloat(someFloat))
            guard  let image = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coachPic  else   {
                return imgOfCoach.image = UIImage(named: "profile")
            }
            WAShareHelper.loadImage(urlstring:image , imageView: ((imgOfCoach!)), placeHolder: "profile")
             viewOfAppointment.isHidden = false
             viewOfBookingAPpointment.isHidden = false
             self.viewOfBookTrial.isHidden = true
            self.viewOfPrgramGuide.isHidden = true


        }
        } else {
            self.showToast("Select Time First")
        }
    }
}
