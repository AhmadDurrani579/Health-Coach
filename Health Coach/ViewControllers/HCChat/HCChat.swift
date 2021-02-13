//
//  HCChat.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 15/11/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
import GrowingTextView
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
class HCChat: UIViewController {
    var messgeObj       : MOMessage?
    var messageListItem : NSMutableArray?
    @IBOutlet weak var tblViewss: UITableView!
    @IBOutlet weak var viewOfMessage: CardView!

    var mesgItem : NSDictionary?
    private  var messgeItemList: [MessageList]  = []
    
    @IBOutlet weak var txtEnter: GrowingTextView!
    @IBOutlet weak var chatViewBottomConstraint : NSLayoutConstraint!
    let commentDateForm = DateFormatter()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var btnBack: UIButton!
    var isComeFromCoachView : Bool?
    @IBOutlet weak var imgOfProfile: UIImageView!

    @IBOutlet weak var lblMessageTyping: UILabel!
    let photoPicker = PhotoPicker()
    @IBOutlet weak var lblNameOfUser: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageListItem = []
//        WAShareHelper.setBorderAndCornerRadius(layer: viewOfMessage.layer, width: 1.0, radius: 30.0, color: UIColor.lightGray)
        txtEnter.delegate = self
        
        commentDateForm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        commentDateForm.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        tblViewss.register(UINib(nibName : "SenderCell", bundle: nil), forCellReuseIdentifier: "SenderCell")
        tblViewss.register(UINib(nibName : "ReceiverCell", bundle: nil), forCellReuseIdentifier: "ReceiverCell")
        tblViewss.register(UINib(nibName : "SenderImageCell", bundle: nil), forCellReuseIdentifier: "SenderImageCell")
        tblViewss.register(UINib(nibName : "ReceiverImageCell", bundle: nil), forCellReuseIdentifier: "ReceiverImageCell")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        let firstName = appDelegate.responseObj?.getUserDetail?.userDetailObject?.first_name
        let coachName = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_firstname
        

        
//        let cgFloat: CGFloat = self.imgOfFoodItem.frame.size.width/2.0
//        let someFloat = Float(cgFloat)
//        WAShareHelper.setViewCornerRadius(self.imgOfFoodItem , radius: CGFloat(someFloat))

        
        lblNameOfUser.text = coachName
        if appDelegate.badgeCount != 0 {
//            self.tabBarItem.badgeValue
        }
//        self.tabBar.items![3].badgeValue = "\(appDelegate.badgeCount)"
//        if isComeFromCoachView == true {
//            btnBack.isHidden = false
//        } else {
//            btnBack.isHidden = true
//        }
        
        let userId = UserDefaults.standard.string(forKey: "id")
        let coachId = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id
        let param =          [     "userid"      : coachId ?? "1"  ,
                                   "fromid" : userId!
                                  
                                ] as [String : Any]
        IQKeyboardManager.shared.disabledToolbarClasses.append(HCChat.self)
        IQKeyboardManager.shared.enable = false
        SKSocketConnection.socketSharedConnection.chatHistory(obj : param)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didMessageDisplay(_:)), name: NSNotification.Name(rawValue: "messageReciver"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appendNewMessage), name: NSNotification.Name(rawValue: "new Message"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.typing), name: NSNotification.Name(rawValue: "typingMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        guard  let image = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coachPic  else   {
            return
        }
        WAShareHelper.loadImage(urlstring:image , imageView: imgOfProfile, placeHolder: "profile")
        let cgFloat: CGFloat = imgOfProfile.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imgOfProfile, radius: CGFloat(someFloat))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        UserDefaults.standard.set(0, forKey: "Notification")

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeNotification"), object : nil, userInfo : nil)

        NotificationCenter.default.removeObserver(self)
//         appDelegate.badgeCount = 0
        
        
        
    }

    @IBAction private func btnBack_Pressedssss(_ sender: UIButton) {
//        tabBarController.selectedIndex = 0
        
        if isComeFromCoachView == true {
//            btnBack.isHidden = false
            self.navigationController?.popViewController(animated: true)
        } else {
            self.tabBarController?.selectedIndex = 0

//            btnBack.isHidden = true
        }

        
    }
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        txtEnter.resignFirstResponder()
    }
    
    @objc func appendNewMessage(_ notification: NSNotification) {
        let messagess = notification.object as? NSDictionary
        let stringObj = messagess!
        let jsonData = try? JSONSerialization.data(withJSONObject: stringObj, options: [])
        let decoder = JSONDecoder()
        let userId = UserDefaults.standard.string(forKey: "id")
        do {
            let mesgItem = try decoder.decode(MessageList.self, from: jsonData!)
            if mesgItem.fromed ==  Int(userId!) || mesgItem.to ==  Int(userId!) {
                messgeItemList.append(mesgItem)
                tblViewss.scrollToBottom()
                tblViewss.reloadData()

            }
        } catch {
          print(error.localizedDescription)
        }

    }
    
    @objc func typing(_ notification: NSNotification) {
        let messagess = notification.object as? NSDictionary
        let stringObj = messagess!
        let jsonData = try? JSONSerialization.data(withJSONObject: stringObj, options: [])
        let decoder = JSONDecoder()
        let userId = UserDefaults.standard.string(forKey: "id")
        do {
            let firstName = UserDefaults.standard.string(forKey: "firstName")
            let lastNAme = UserDefaults.standard.string(forKey: "lastName")
            let userName = "\(firstName!) \(lastNAme!)"
            let mesgItem = try decoder.decode(MessageList.self, from: jsonData!)
            if userName == mesgItem.username {
                
            } else {
                if mesgItem.username == "" {
                    lblMessageTyping.isHidden = true
                } else {
                    lblMessageTyping.isHidden = false

                    let typingPErson = "\(mesgItem.username ?? " ") \(mesgItem.message!)"
                    print(typingPErson)
                    lblMessageTyping.text = typingPErson

                }
            }

        } catch {
          print(error.localizedDescription)
        }

    }


    @objc func keyboardWillShow(notification:NSNotification) {
           
       if Connectivity.isConnectedToInternet() {
           let userInfo:NSDictionary = notification.userInfo! as NSDictionary
           let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
           let keyboardRectangle = keyboardFrame.cgRectValue
           let keyboardHeight = keyboardRectangle.height - 60
           self.chatViewBottomConstraint.constant = keyboardHeight
            if ((self.messgeItemList.count)) > 0 {
                self.tblViewss.scrollToBottom()
           }
//           self.bottomViewBottomSpaceConstant.constant = 0
        }
       }
       
       @objc func keyboardWillHide(notification:NSNotification)  {
//           self.bottomViewBottomSpaceConstant.constant = 0.0
           self.chatViewBottomConstraint.constant = 10.0
       }


    @objc func didMessageDisplay(_ notification: NSNotification) {
        
        let messagess = notification.object as? NSMutableArray
                
        let stringObj = messagess
        //        let stringObj = messagess!["data"] as? NSDictionary
        let jsonData = try? JSONSerialization.data(withJSONObject: stringObj!, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
        let decoder = JSONDecoder()
        do {
            messgeItemList = try decoder.decode([MessageList].self, from: jsonData!)
        } catch {
            print(error.localizedDescription)
        }
        tblViewss.delegate = self
        tblViewss.dataSource = self
        tblViewss.estimatedRowHeight = 50.0
        tblViewss.rowHeight = UITableView.automaticDimension
        tblViewss.reloadData()
         if ((self.messgeItemList.count)) > 0 {
             self.tblViewss.scrollToBottom()
        }

        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnGetHistory_Pressed(_ sender: UIButton) {
        if txtEnter.text.count > 0 {
            let userId = UserDefaults.standard.string(forKey: "id")
            let coachId = appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id
            let param =             [ "message"         : txtEnter.text! ,
                                      "userid"          : coachId ?? "1" ,
                                      "fromid"          : userId! ,
                                      "type"            : "0"
                                    ] as [String : Any]
            SKSocketConnection.socketSharedConnection.sendMessage(obj: param)
            self.txtEnter.text = ""

        } else {
            self.showToast("Enter Message")
        }
    }
    
    @IBAction private func btnSendImage_Pressed(_ sender : UIButton) {
        
      var param = [:] as Dictionary<String, AnyObject>
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
          WebServiceManager.multiPartImage(params: param as Dictionary<String, AnyObject> , serviceName: UPLOADPICTURE , imageParam:"image" , imgFileName: "image", serviceType: "Share", profileImage: orignal, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
              let responseObj = response as? UserResponse
                if responseObj != nil {
                  if responseObj?.success == true  {
                   let userId = UserDefaults.standard.string(forKey: "id")
                    let coachId = self.appDelegate.responseObj?.getUserDetail?.userDetailObject?.coach_id
                    let imgPAth = responseObj?.uploadPicture?.imagepath
                    let param =             [  "message"         : imgPAth! ,
                                               "userid"          : coachId ?? "1" ,
                                               "fromid"          : userId! ,
                                               "type"            : "1"
                                             ] as [String : Any]
                    SKSocketConnection.socketSharedConnection.sendMessage(obj: param)

                    }
                    else
                    {
                                    
                    }
                } else {
                    
                    self.showToast("Server Error")
                            
                  }
               }) { (error) in
            }
        }
    }
}

@available(iOS 13.0, *)
extension HCChat  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messgeItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userId = UserDefaults.standard.string(forKey: "id")
        if messgeItemList[indexPath.row].fromed ==  Int(userId!) {
            if messgeItemList[indexPath.row].type == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell
                  cell?.lblMessage.text = messgeItemList[indexPath.row].name
                  let date = commentDateForm.date(from:(messgeItemList[indexPath.row].created_at)!)
                  if let timeAgo = WAShareHelper.timeAgoSinceDate(date!) {
                    cell!.lblTime.text = "\(timeAgo) ago"
                  } else {
                      print("recently")
                  }
                 return cell!

            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderImageCell", for: indexPath) as? SenderImageCell

                let date = commentDateForm.date(from:(messgeItemList[indexPath.row].created_at)!)
                  if let timeAgo = WAShareHelper.timeAgoSinceDate(date!) {
                    cell!.lblTime.text = "\(timeAgo) ago"
                  } else {
                      print("recently")
                  }
                
                guard let img = messgeItemList[indexPath.row].name else {
                    return cell!
                }
                
                WAShareHelper.loadImage(urlstring:img , imageView: ((cell?.imgOfSender!)!), placeHolder: "profile")
                
                 return cell!

            }
        } else {
            
            if messgeItemList[indexPath.row].type == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as? ReceiverCell
            cell?.lblReceiverMessage.text = messgeItemList[indexPath.row].name
              let date = commentDateForm.date(from:(messgeItemList[indexPath.row].created_at)!)
              if let timeAgo = WAShareHelper.timeAgoSinceDate(date!) {
                cell!.lblTime.text = "\(timeAgo) ago"
              } else {
                  print("recently")
              }
            guard  let image = messgeItemList[indexPath.row].fromuserpicture  else   {
                return cell!
            }
            WAShareHelper.loadImage(urlstring:image , imageView: ((cell?.imgOfReceiver!)!), placeHolder: "profile")
            let cgFloat: CGFloat = cell!.imgOfReceiver.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(cell!.imgOfReceiver, radius: CGFloat(someFloat))
             return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverImageCell", for: indexPath) as? ReceiverImageCell

                let date = commentDateForm.date(from:(messgeItemList[indexPath.row].created_at)!)
                  if let timeAgo = WAShareHelper.timeAgoSinceDate(date!) {
                    cell!.lblTime.text = "\(timeAgo) ago"
                  } else {
                      print("recently")
                  }
                
                guard  let image = messgeItemList[indexPath.row].fromuserpicture  else   {
                    return cell!
                }
                WAShareHelper.loadImage(urlstring:image , imageView: ((cell?.imgOfReceiver!)!), placeHolder: "profile")
                let cgFloat: CGFloat = cell!.imgOfReceiver.frame.size.width/2.0
                let someFloat = Float(cgFloat)
                WAShareHelper.setViewCornerRadius(cell!.imgOfReceiver, radius: CGFloat(someFloat))
                
                guard let img = messgeItemList[indexPath.row].name else {
                    return cell!
                }
                WAShareHelper.loadImage(urlstring:img , imageView: ((cell?.imgOfReceiver!)!), placeHolder: "profile")
                
                 return cell!

            }
        }
            
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messgeItemList[indexPath.row].type == 1 {
            return 196.0
        } else {
            return UITableView.automaticDimension

        }
        
    }
    
}

@available(iOS 13.0, *)
extension HCChat : GrowingTextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let firstName = UserDefaults.standard.string(forKey: "firstName")
        let lastNAme = UserDefaults.standard.string(forKey: "lastName")
        let userName = "\(firstName!) \(lastNAme!)"
        let param =     [  "username"      : userName
                        ] as [String : Any]
        SKSocketConnection.socketSharedConnection.userTyping(obj: param)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
