//
//  HCProgramAgreementVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 27/09/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCProgramAgreementVC: UIViewController {
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    var dateOfCurrent = Calendar.current.startOfDay(for: Date())
//    lblUserName.text = "\(firstName!) \(lastNAme!)"
    var dateOFfCurrentUser : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("isBottomAndTopHide"), object: nil)
        
        let firstName = UserDefaults.standard.string(forKey: "firstName")
        let lastNAme = UserDefaults.standard.string(forKey: "lastName")
        txtUserName.text = "\(firstName!) \(lastNAme!)"
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"

        dateOFfCurrentUser = format.string(from: dateOfCurrent)
        txtDate.text =  getFormattedDate(string: dateOFfCurrentUser!)


        // Do any additional setup after loading the view.
    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }

    
    @available(iOS 13.0, *)

    @IBAction private func btnAgreeTerm(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier : "HCPayNowVC") as? HCPayNowVC
        self.navigationController?.pushViewController(vc! , animated: true)
    }
}
