//
//  HCMySessionVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 08/01/2020.
//  Copyright © 2020 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCMySessionVC: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var tblViewss: UITableView!
    
    fileprivate let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstName = appDelegate.responseObj?.getUserDetail?.userDetailObject?.first_name
        let lastName = appDelegate.responseObj?.getUserDetail?.userDetailObject?.last_name
        lblName.text = "\(firstName!) \(lastName!)"
        tblViewss.register(UINib(nibName : "SessionCell", bundle: nil), forCellReuseIdentifier: "SessionCell")
        tblViewss.delegate = self
        tblViewss.dataSource = self
        tblViewss.estimatedRowHeight = 50.0
        tblViewss.rowHeight = UITableView.automaticDimension

        tblViewss.reloadData()
    }
}

@available(iOS 13.0, *)
extension HCMySessionVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.responseObj?.getUserDetail?.appointments?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as? SessionCell
        let sessionNumber = indexPath.row + 1
        cell?.lblSessionNum.text = "Trial Session \(sessionNumber)"
        cell?.lblSessionName.text = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].service_name
        cell?.lblDateOfAppintment.text = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].date
        
        let fromTime = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].from
        let toTime = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].to
        cell?.lblTiming.text = "\(fromTime!) To \(toTime!)"
        if appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].note == "" {
            cell?.lblNote.isHidden = true
            cell?.lblNoteDescription.isHidden = true
        } else {
            cell?.lblNote.isHidden = false
            cell?.lblNoteDescription.isHidden = false

            cell?.lblNoteDescription.text = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].note

        }
        let stringDate = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].date
//        let dateFormatter = DateFormatter()
//        formatterss.date(from: stringDate)! // now it works!
        
        let date = formatter.date(from: stringDate!)
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let datess = dateFormatter.date(from:stringDate!)
//        print(datess)

//        print(formatter.timeZone!)
        
        cell?.lblCompleteOrNt.text = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].day
//        let currentDate = Date()
//        if date?.compare(currentDate) == .orderedSame {
//            cell?.lblCompleteOrNt.isHidden = false
//        }
//        if date?.compare(currentDate) == .orderedAscending {
//            cell?.lblCompleteOrNt.isHidden = false
//        }
//        if date?.compare(currentDate) == .orderedDescending {
//            cell?.lblCompleteOrNt.isHidden = true
//        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier : "HCAppointmentSelectionVC") as? HCAppointmentSelectionVC
        vc?.selectedAppointment = appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if appDelegate.responseObj?.getUserDetail?.appointments![indexPath.row].note == "" {
            return 120.0
        } else {
            return UITableView.automaticDimension
        }
    }
}
