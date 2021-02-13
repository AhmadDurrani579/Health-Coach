//
//  HCMedicalInfoVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 24/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCMedicalInfoVC: UIViewController {
    
    @IBOutlet weak var tblViewss: UITableView!
    var responseObj: FAQObject?
    var firstName : String?
    var lastName  : String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName = UserDefaults.standard.string(forKey: "firstName")
        lastName = UserDefaults.standard.string(forKey: "lastName")
        tblViewss.estimatedRowHeight = 84.0
        tblViewss.rowHeight = UITableView.automaticDimension

        tblViewss.register(UINib(nibName: "FAQCommunityCell", bundle: nil), forCellReuseIdentifier: "FAQCommunityCell")
        getFAQ()
    }
    
    func getFAQ() {
         WebServiceManager.get(params: nil, serviceName: FAQ , serviceType: "Package List", modelType: FAQObject.self, success: {[weak self] (response) in

          self!.responseObj = (response as! FAQObject)
          if  self!.responseObj?.success == true {
            self!.tblViewss.delegate = self
            self!.tblViewss.dataSource = self
            self!.tblViewss.reloadData()
          }
          else {
                self?.showToast((self!.responseObj?.message)!)
         }
         }) { (error) in

        }
    }

    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = " h:mm , MMM d"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }

}

@available(iOS 13.0, *)
extension HCMedicalInfoVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return responseObj?.faqlist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCommunityCell", for: indexPath) as? FAQCommunityCell
        cell?.lblTitleOfQuestion.text = responseObj?.faqlist![indexPath.row].title
//        cell?.lblUserName.text = "\(self.firstName!)"
        cell?.lblDescription.text = responseObj?.faqlist![indexPath.row].answer
        return cell!

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}
