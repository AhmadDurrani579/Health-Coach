//
//  HCPayNowVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 27/09/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit


class HCPayNowVC: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtCreditCardNum: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    
    @IBOutlet weak var txtTotalAmount: UITextField!
    @IBOutlet weak var viewOfInstallment: CardView!
    @IBOutlet weak var viewOfPaypal: CardView!

    @IBOutlet weak var btn4thMonth: UIButton!
//    @IBOutlet weak var btnOneTimethMonth: UIButton!
    @IBOutlet weak var btnPackages : UIButton!
    @IBOutlet weak var btnPromotion : UIButton!

    @IBOutlet weak var heightOFPromotion: NSLayoutConstraint!
    var price : String?
    var duration : String?
    var responseObj: UserResponse?
    var month = ""
    var year = ""

    @IBOutlet weak var lblFourMonth: UILabel!
    @IBOutlet weak var lblOneTimePackage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let firstName = UserDefaults.standard.string(forKey: "firstName")
        let lastNAme = UserDefaults.standard.string(forKey: "lastName")

        lblUserName.text = "\(firstName!) \(lastNAme!)"
        
//        txtCreditCardNum.text = "5555555555554444"
        btn4thMonth.isSelected = false
//        btnOneTimethMonth.isSelected = false
        heightOFPromotion.constant = 70.0
        btn4thMonth.isHidden = true
        lblFourMonth.isHidden = true

//        txtTotalAmount.text = "4000"
//        price = "4000"
//        duration = "4 Month"
        WAShareHelper.setBorderAndCornerRadius(layer: viewOfInstallment.layer, width: 2.0 , radius: 15.0, color: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))
        btnPackages.backgroundColor = UIColor(red: 73/255.0, green: 221/255.0, blue: 238/255.0, alpha: 1.0)
        btnPackages.setTitleColor(.darkGray, for: .normal)
        btnPromotion.backgroundColor = .groupTableViewBackground
        btnPackages.setTitleColor(.darkGray, for: .normal)

        WAShareHelper.setBorderAndCornerRadius(layer: viewOfPaypal.layer, width: 2.0 , radius: 15.0, color: UIColor(red: 64/255.0, green: 214/255.0, blue: 233/255.0, alpha: 1.0))
        getPackages()
        // Do any additional setup after loading the view.
    }
    
    
    func getPackages() {
         WebServiceManager.get(params: nil, serviceName: PACKAGES , serviceType: "Package List", modelType: UserResponse.self, success: {[weak self] (response) in

          self!.responseObj = (response as! UserResponse)
          if  self!.responseObj?.success == true {
            let fourMonthPackage = self?.responseObj?.packageList?.package?.duration ?? "0"
            let priceOfItem = self?.responseObj?.packageList?.package?.price ?? "0"
            self?.lblFourMonth.text = "\(fourMonthPackage) payment at \(priceOfItem)"

          }
          else {
                self?.showToast((self!.responseObj?.message)!)
         }
         }) { (error) in

        }
    }
    @IBAction func btnPay_Pressed(_ sender: UIButton) {
        if self.isViewDataValid(cardNumber: (self.txtCreditCardNum.text!), date: (self.month), csv: (self.txtCVV.text!)) == true {
            let userId = UserDefaults.standard.string(forKey: "id")
            let years = "20\(year )"
            let loginParam =             [ "price"         : txtTotalAmount.text ?? "" ,
                                        "duration"         : self.responseObj?.packageList?.package?.duration ?? "1" ,
                                        "user_id"          : userId! ,
                                        "card_number"      : self.txtCreditCardNum.text!.replacingOccurrences(of: " ", with: "") ,
                                        "card_month"       : month  ,
                                        "card_year"        : years ,
                                        "card_cvv"        :  txtCVV.text ?? " " ,
                                        "package_id"      :  self.responseObj?.packageList?.package?.id ?? ""
                                            ] as [String : Any]
                    
            WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SUBSCRIBE, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { [weak self] (response) in
                        let responseObj = response as! UserResponse
                        if responseObj.success == true {
                            UserDefaults.standard.set(true, forKey: "subscribe")
                            
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "HCConfirmationVC") as? HCConfirmationVC
                            self?.navigationController?.pushViewController(vc!, animated: true)
                        }
                        else {
                            self!.showAlert(title: KMessageTitle , message: responseObj.message!, controller: self)
                        }
                        }, fail: { (error) in
                            
                    }, showHUD: true)

        }
    }
    
    @IBAction func btn4thMont_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btn4thMonth.isSelected = true
//        btnOneTimethMonth.isSelected = false
//        price = "4000"
//        duration = "4 Month"
        txtTotalAmount.text = self.responseObj?.packageList?.package?.price
    }
    
    @IBAction func btnPackage_Pressed(_ sender: UIButton) {
        heightOFPromotion.constant = 70.0
        btn4thMonth.isHidden = true
        lblFourMonth.isHidden = true
        
        btnPackages.backgroundColor = UIColor(red: 73/255.0, green: 221/255.0, blue: 238/255.0, alpha: 1.0)
        btnPackages.setTitleColor(.darkGray, for: .normal)
        btnPromotion.backgroundColor = .groupTableViewBackground
        btnPromotion.setTitleColor(.darkGray, for: .normal)

    }
    
    @IBAction func btnPromotion_Pressed(_ sender: UIButton) {
        heightOFPromotion.constant = 110
        btn4thMonth.isHidden = false
        lblFourMonth.isHidden = false
        
        btnPromotion.backgroundColor = UIColor(red: 73/255.0, green: 221/255.0, blue: 238/255.0, alpha: 1.0)
        btnPromotion.setTitleColor(.darkGray, for: .normal)
        btnPackages.backgroundColor = .groupTableViewBackground
        btnPackages.setTitleColor(.darkGray, for: .normal)

    }

    
    @IBAction func btnOneTime_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btn4thMonth.isSelected = false
//        btnOneTimethMonth.isSelected = true
        price = "6000"
        duration = "All Time"
        txtTotalAmount.text = "6000"


    }
    
    @IBAction func btnPayPayPAl(_ sender: UIButton) {
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func expDateValidation(dateStr:String) {
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonthsss = dateStr.prefix(2) // get first two digit from entered string as month
        print(enteredMonthsss)
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        month = String(enteredMonthsss)
        year = "\(enteredYear)"

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
            } else {
                self.showToast("Date must be greater then current date")
//                print("Entered Date Is Wrong")
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   print("Entered Date Is Right")
                } else {
                    self.showToast("Date must be greater then current date")

                   print("Entered Date Is Wrong")
                }
            } else {
                self.showToast("Date must be greater then current date")
                print("Entered Date Is Wrong")
            }
        } else {
//            self.showToast("Date must be greater then current date")

           print("Entered Date Is Wrong")
        }

    }
    
    func isViewDataValid(cardNumber : String , date : String , csv : String) -> Bool {
            if cardNumber.count <= 0 {
                
                self.showAlert(title: KMessageTitle , message: "Card Number is missing Please enter Card Number", controller: self)
                return false
            }
            if  date.count <= 0  {
                self.showAlert(title: KMessageTitle , message: "Date is missing Please enter Date", controller: self)
                return false
            }
            if  csv.count <= 0  {
                self.showAlert(title: KMessageTitle , message: "CVV number is missing Please enter CVV number", controller: self)
                return false
            }
          if btn4thMonth.isSelected == false {
               self.showAlert(title: KMessageTitle , message: "Please select the package", controller: self)
             return false
          }
            return true
        }


}


extension HCPayNowVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtCVV {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 4 // replace 4 for your max length value
        }
        
        if textField == self.txtCreditCardNum {
            if range.location == 19 {
                return false
            }
            guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }

            if textField == self.txtCreditCardNum {
                textField.text = currentText.grouping(every: 4, with: " ")
                return false
            }
            else { // Expiry Date Text Field
                textField.text = currentText.grouping(every: 2, with: "/")
                return false
            }
        }
        if textField == self.txtExpiryMonth {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }
            let updatedText = oldText.replacingCharacters(in: r, with: string)

            if string == "" {
                if updatedText.count == 2 {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
            } else if updatedText.count == 1 {
                if updatedText > "1" {
                    return false
                }
            } else if updatedText.count == 2 {
                if updatedText <= "12" { //Prevent user to not enter month more than 12
                    textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
                }
                return false
            } else if updatedText.count == 5 {
                self.expDateValidation(dateStr: updatedText)
            } else if updatedText.count > 5 {
                return false
            }
          }
            return true
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtCVV {
            let inte: Int = Int(CInt(textField.text!)!)
            if inte < 5 && inte > 2 {
                return false
            }
            else {
                return true
            }
        }
        return true
    }

}

extension String {
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
       let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
       return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
       }.joined().dropFirst())
    }
}
