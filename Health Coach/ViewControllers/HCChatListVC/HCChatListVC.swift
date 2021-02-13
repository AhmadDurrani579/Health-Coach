//
//  HCChatListVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 15/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit


class HCChatListVC: UIViewController {
    
    @IBOutlet weak var tblViewss: UITableView!
    var responseObj: UserResponse?
    @IBOutlet weak var btnBack: UIButton!
    var isComeFromTabScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewss.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
//        tblViewss.delegate = self
//        tblViewss.dataSource = self
//        tblViewss.reloadData()
            getAllNotification()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isComeFromTabScreen == true {
            btnBack.isHidden = false
        } else {
            btnBack.isHidden = true
        }
    }
    
    func getAllNotification() {
        let userId = UserDefaults.standard.string(forKey: "id")

        let loginParam =      [ "userid"             : userId!
                              ] as [String : Any]
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: ALLNotification , isLoaderShow: false , serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
            guard let this = self else {
                return
            }
            this.responseObj = (response as! UserResponse)
            if this.responseObj!.success == true {
                
                this.tblViewss.delegate = self
                this.tblViewss.dataSource = self
                this.tblViewss.reloadData()

            }
            else {
                self!.showAlert(title: KMessageTitle , message: this.responseObj!.message ?? this.responseObj!.msg! , controller: self)
                this.tblViewss.delegate = self
                this.tblViewss.dataSource = self
                this.tblViewss.reloadData()
            }
            }, fail: { (error) in
        }, showHUD: true)
    }
}

extension HCChatListVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if  responseObj?.listOfNotification?.isEmpty == false {
            numOfSections = 1
            tblViewss.backgroundView = nil
        }  else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblViewss.bounds.size.width, height: tblViewss.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Notification ."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tblViewss.backgroundView = noDataLabel
            tblViewss.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return responseObj?.listOfNotification?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell
        cell?.lblNAme.text = self.responseObj?.listOfNotification![indexPath.row].from_fname
        cell?.lblMessage.text = self.responseObj?.listOfNotification![indexPath.row].message
        cell?.lblMinute.text = self.responseObj?.listOfNotification![indexPath.row].date

        
        guard  let imgUrl = responseObj?.listOfNotification![indexPath.row].from_profile_pic else {
            return cell!
        }
        WAShareHelper.loadImage(urlstring: (imgUrl) , imageView: cell!.imgOfProfile, placeHolder: "profile")
                let cgFloat: CGFloat = cell!.imgOfProfile.frame.size.width/2.0
                let someFloat = Float(cgFloat)
                WAShareHelper.setViewCornerRadius(cell!.imgOfProfile , radius: CGFloat(someFloat))

        return cell!

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    }

