//
//  HCHealthGoalVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class HCHealthGoalVC: UIViewController {
    @IBOutlet weak var btnFirstBtn: UIButton!
    @IBOutlet weak var btnSecondBtn: UIButton!
    @IBOutlet weak var btnThirdBtn: UIButton!
    @IBOutlet weak var btnFourthBtn: UIButton!
    @IBOutlet weak var btnFifthBtn: UIButton!
    @IBOutlet weak var btnSixthBtn: UIButton!
    
    private var selectedInterestGoal : [String] = []
//    var selectHealthCoacheStyle : String?
    
    var selectInterest : String?
    var txtInterest : String?
    
    var choseHealth : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btnChearLeader(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if selectedInterestGoal.count < 3 {
            //             choseHealth = "Cheerleader"
            
//            let origImage = UIImage(named: "cheerleaderS")
//            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//            btnFirstBtn.setImage(tintedImage, for: .normal)
//            btnFirstBtn.tintColor = .white

            if sender.isSelected == true {
                selectedInterestGoal.append("Cheerleader")
                btnFirstBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
                btnFirstBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                selectedInterestGoal.removeAll { $0 == "Cheerleader" }
                btnFirstBtn.backgroundColor = UIColor.white
                btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            }
            
        } else {
            selectedInterestGoal.removeAll { $0 == "Cheerleader" }
            btnFirstBtn.backgroundColor = UIColor.white
            btnFirstBtn.isSelected = false
            btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
        }
        
    }
    @IBAction func btnChallenger(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        
        
        if selectedInterestGoal.count < 3 {
            
//            let origImage = UIImage(named: "challengerS")
//            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//            btnSecondBtn.setImage(tintedImage, for: .normal)
//            btnSecondBtn.tintColor = .white

            //             choseHealth = "Cheerleader"
            if sender.isSelected == true {
                selectedInterestGoal.append("Challenger")
                btnSecondBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
                btnSecondBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                selectedInterestGoal.removeAll { $0 == "Challenger" }
                btnSecondBtn.backgroundColor = UIColor.white
                btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            }
            
        }   else {
            selectedInterestGoal.removeAll { $0 == "Challenger" }
            btnSecondBtn.backgroundColor = UIColor.white
            btnSecondBtn.isSelected = false
            btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            
        }

        
//        else {
//            selectedInterestGoal.removeAll { $0 == "Challenger" }
//            btnSecondBtn.backgroundColor = UIColor.white
//            btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//        }


    }
    
    @IBAction func btnAnalyst_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if selectedInterestGoal.count < 3 {
            //             choseHealth = "Cheerleader"
          //  let origImage = UIImage(named: "analystS")
          //  let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
          //  btnThirdBtn.setImage(tintedImage, for: .normal)
          //  btnThirdBtn.tintColor = .white

            if sender.isSelected == true {
                selectedInterestGoal.append("Analyst")
                btnThirdBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
                btnThirdBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                selectedInterestGoal.removeAll { $0 == "Analyst" }
                btnThirdBtn.backgroundColor = UIColor.white
                btnThirdBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            }
            
        }
        else {
            selectedInterestGoal.removeAll { $0 == "Analyst" }
            btnThirdBtn.backgroundColor = UIColor.white
            btnThirdBtn.isSelected = false
            btnThirdBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)

        }

    }
    
    
    @IBAction func btnInnovator(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if selectedInterestGoal.count < 3 {
            //             choseHealth = "Cheerleader"
            if sender.isSelected == true {
                selectedInterestGoal.append("Innovator")
                btnFourthBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
                btnFourthBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                selectedInterestGoal.removeAll { $0 == "Innovator" }
                btnFourthBtn.backgroundColor = UIColor.white
                btnFourthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            }
            
        } else {
            selectedInterestGoal.removeAll { $0 == "Innovator" }
                        btnFourthBtn.backgroundColor = UIColor.white
            btnFourthBtn.isSelected = false
            btnFourthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            
        }
//        else {
//            selectedInterestGoal.removeAll { $0 == "Innovator" }
//            btnFourthBtn.backgroundColor = UIColor.white
//            btnFourthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//        }
    }
    
    
    
    @IBAction func btnListner_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if selectedInterestGoal.count < 3 {
            if sender.isSelected == true {
                selectedInterestGoal.append("Listener")
                btnFifthBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
                btnFifthBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                selectedInterestGoal.removeAll { $0 == "Listener" }
                btnFifthBtn.backgroundColor = UIColor.white
                btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            }
            
        } else {
            selectedInterestGoal.removeAll { $0 == "Listener" }
                        btnFifthBtn.backgroundColor = UIColor.white
            btnFifthBtn.isSelected = false
            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            
        }
//        else {
//            selectedInterestGoal.removeAll { $0 == "Listener" }
//            btnFifthBtn.backgroundColor = UIColor.white
//            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//        }

    }
    
    @IBAction func btnDrillMiss_Pressed(_ sender: UIButton) {
            sender.isSelected = !sender.isSelected
        if selectedInterestGoal.count < 3 {
            //             choseHealth = "Cheerleader"
            if sender.isSelected == true {
                selectedInterestGoal.append("Drill Master")
                btnSixthBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
                btnSixthBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                selectedInterestGoal.removeAll { $0 == "Drill Master" }
                btnSixthBtn.backgroundColor = UIColor.white
                btnSixthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            }
            
        } else {
            selectedInterestGoal.removeAll { $0 == "Drill Master" }
            btnSixthBtn.isSelected = false
            btnSixthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            
        }
        
    }
//    @IBAction func btnChooseHealth_Pressed(_ sender: UIButton) {
//        if sender.tag == 0 {
//
//
//
//        } else if sender.tag == 1 {
//            choseHealth = "Challenger"
//            btnSecondBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
//            btnFirstBtn.backgroundColor = UIColor.white
//            btnThirdBtn.backgroundColor = UIColor.white
//            btnFourthBtn.backgroundColor = UIColor.white
//            btnFifthBtn.backgroundColor = UIColor.white
//            btnSixthBtn.backgroundColor = UIColor.white
//
//            btnSecondBtn.setTitleColor(UIColor.white, for: .normal)
//            btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnThirdBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFourthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSixthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//        }else if sender.tag == 2 {
//            choseHealth = "Analyst "
//            btnThirdBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
//            btnFirstBtn.backgroundColor = UIColor.white
//            btnSecondBtn.backgroundColor = UIColor.white
//            btnFourthBtn.backgroundColor = UIColor.white
//            btnFifthBtn.backgroundColor = UIColor.white
//            btnSixthBtn.backgroundColor = UIColor.white
//
//            btnThirdBtn.setTitleColor(UIColor.white, for: .normal)
//            btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFourthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSixthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//
//        }else if sender.tag == 3 {
//           choseHealth = "Innovator"
//            btnFourthBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
//            btnFirstBtn.backgroundColor = UIColor.white
//            btnSecondBtn.backgroundColor = UIColor.white
//            btnThirdBtn.backgroundColor = UIColor.white
//            btnFifthBtn.backgroundColor = UIColor.white
//            btnSixthBtn.backgroundColor = UIColor.white
//
//            btnFourthBtn.setTitleColor(UIColor.white, for: .normal)
//            btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnThirdBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSixthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//
//
//        }else if sender.tag == 4 {
//            choseHealth = "Listener"
//            btnFifthBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
//            btnFirstBtn.backgroundColor = UIColor.white
//            btnSecondBtn.backgroundColor = UIColor.white
//            btnThirdBtn.backgroundColor = UIColor.white
//            btnFourthBtn.backgroundColor = UIColor.white
//            btnSixthBtn.backgroundColor = UIColor.white
//
//            btnFifthBtn.setTitleColor(UIColor.white, for: .normal)
//            btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnThirdBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSixthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//
//        } else if sender.tag == 5 {
//            choseHealth = "Drill Master"
//            btnSixthBtn.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
//            btnFirstBtn.backgroundColor = UIColor.white
//            btnSecondBtn.backgroundColor = UIColor.white
//            btnThirdBtn.backgroundColor = UIColor.white
//            btnFourthBtn.backgroundColor = UIColor.white
//            btnFifthBtn.backgroundColor = UIColor.white
//
//            btnSixthBtn.setTitleColor(UIColor.white, for: .normal)
//            btnFirstBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnSecondBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnThirdBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFifthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//            btnFourthBtn.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
//
//
//        }
//
//
//    }
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        
        if self.selectedInterestGoal.count == 0  {
            self.showAlert(title: KMessageTitle, message: "You may choose up to 3 coaching styles", controller: self)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCSelectSignUpVC") as? HCSelectSignUpVC
            vc?.choseHealth = self.selectedInterestGoal.joined(separator: ",")
            vc?.selectInterest = selectInterest
            vc?.txtInterest = txtInterest
            self.navigationController?.pushViewController(vc!, animated: true)
        }

    }
    
   
}
