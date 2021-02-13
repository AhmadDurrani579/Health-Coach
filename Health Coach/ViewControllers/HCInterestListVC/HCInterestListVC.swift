//
//  HCInterestListVC.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HCInterestListVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnFat: UIButton!
    @IBOutlet weak var btnSleep: UIButton!
    @IBOutlet weak var btnStres: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnHarmone: UIButton!

    var selectInterest : String?
    var selectGoal : String?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnSelectInterest(_ sender: UIButton) {
        if sender.tag == 0 {
            btnFat.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
            
//            lose_weight , sleepdd  , women_stressed , increase_energy , hormone_free
            let iconImage1 :UIImage? = UIImage(named: "choosethree")
            let iconImage2 :UIImage? = UIImage(named: "sleepdd")
            let iconImage3 :UIImage? = UIImage(named: "women_stressed")
            let iconImage4 :UIImage? = UIImage(named: "increase_energy")
            let iconImage5 :UIImage? = UIImage(named: "hormone_free")
            
            let origImage = UIImage(named: "lose_weight")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            btnFat.setImage(tintedImage, for: .normal)
            btnFat.tintColor = .white

//            btnFat.setImage(iconImage1, for: .normal)
            btnSleep.setImage(iconImage2, for: .normal)
            btnStres.setImage(iconImage3, for: .normal)
            btnIncrease.setImage(iconImage4, for: .normal)
            btnHarmone.setImage(iconImage5, for: .normal)

            btnSleep.backgroundColor = UIColor.white
            btnStres.backgroundColor = UIColor.white
            btnIncrease.backgroundColor = UIColor.white
            btnHarmone.backgroundColor = UIColor.white
            
            btnFat.setTitleColor(UIColor.white, for: .normal)
            btnSleep.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnStres.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnIncrease.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnHarmone.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            selectInterest = "1"
            selectGoal = "1"
//            vc!.selectInterest = "Fat loss"
//            appDelegate.selectGoal = "Fat loss"
            
        } else if sender.tag == 1 {
//            vc!.selectInterest = "Sleep disorder"
//            appDelegate.selectGoal = "Sleep disorder"
            
            
            let iconImage1 :UIImage? = UIImage(named: "lose_weight")
            let iconImage2 :UIImage? = UIImage(named: "choosethree")
            let iconImage3 :UIImage? = UIImage(named: "women_stressed")
            let iconImage4 :UIImage? = UIImage(named: "increase_energy")
            let iconImage5 :UIImage? = UIImage(named: "hormone_free")
            
            let origImage = UIImage(named: "sleepdd")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            btnSleep.setImage(tintedImage, for: .normal)
            btnSleep.tintColor = .white

            
            btnFat.setImage(iconImage1, for: .normal)
//            btnSleep.setImage(iconImage2, for: .normal)
            btnStres.setImage(iconImage3, for: .normal)
            btnIncrease.setImage(iconImage4, for: .normal)
            btnHarmone.setImage(iconImage5, for: .normal)

            selectInterest = "2"
            selectGoal = "2"

            btnFat.backgroundColor = UIColor.white
            btnSleep.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
            btnStres.backgroundColor = UIColor.white
            btnIncrease.backgroundColor = UIColor.white
            btnHarmone.backgroundColor = UIColor.white
            
            btnSleep.setTitleColor(UIColor.white, for: .normal)
            btnFat.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnStres.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnIncrease.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnHarmone.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)


        }else if sender.tag == 2 {
            selectInterest = "3"
            selectGoal = "3"
            
            let iconImage1 :UIImage? = UIImage(named: "lose_weight")
            let iconImage2 :UIImage? = UIImage(named: "sleepdd")
            let iconImage3 :UIImage? = UIImage(named: "choosethree")
            let iconImage4 :UIImage? = UIImage(named: "increase_energy")
            let iconImage5 :UIImage? = UIImage(named: "hormone_free")
            
            let origImage = UIImage(named: "women_stressed")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            btnStres.setImage(tintedImage, for: .normal)
            btnStres.tintColor = .white

            btnFat.setImage(iconImage1, for: .normal)
            btnSleep.setImage(iconImage2, for: .normal)
//            btnStres.setImage(iconImage3, for: .normal)
            btnIncrease.setImage(iconImage4, for: .normal)
            btnHarmone.setImage(iconImage5, for: .normal)

            btnFat.backgroundColor = UIColor.white
            btnSleep.backgroundColor = UIColor.white
            btnStres.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
            btnIncrease.backgroundColor = UIColor.white
            btnHarmone.backgroundColor = UIColor.white
            
            btnSleep.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnFat.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnStres.setTitleColor(UIColor.white , for: .normal)
            btnIncrease.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnHarmone.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)


            
        }else if sender.tag == 3 {
            
            selectInterest = "4"
            selectGoal = "4"
            
            let iconImage1 :UIImage? = UIImage(named: "lose_weight")
            let iconImage2 :UIImage? = UIImage(named: "sleepdd")
            let iconImage3 :UIImage? = UIImage(named: "women_stressed")
            let iconImage4 :UIImage? = UIImage(named: "choosethree")
            let iconImage5 :UIImage? = UIImage(named: "hormone_free")
            
            let origImage = UIImage(named: "increase_energy")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            btnIncrease.setImage(tintedImage, for: .normal)
            btnIncrease.tintColor = .white

            btnFat.setImage(iconImage1, for: .normal)
            btnSleep.setImage(iconImage2, for: .normal)
            btnStres.setImage(iconImage3, for: .normal)
//            btnIncrease.setImage(iconImage4, for: .normal)
            btnHarmone.setImage(iconImage5, for: .normal)

//            vc!.selectInterest = "Increase Energy"
//            appDelegate.selectGoal = "Increase Energy"
            
            btnFat.backgroundColor = UIColor.white
            btnSleep.backgroundColor = UIColor.white
            btnStres.backgroundColor = UIColor.white
            btnIncrease.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
            btnHarmone.backgroundColor = UIColor.white
            
            btnSleep.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnFat.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnStres.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0) , for: .normal)
            btnIncrease.setTitleColor(UIColor.white, for: .normal)
            btnHarmone.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)


            
        }else if sender.tag == 4 {
            
            selectInterest = "5"
            selectGoal = "5"
            
            let iconImage1 :UIImage? = UIImage(named: "lose_weight")
            let iconImage2 :UIImage? = UIImage(named: "sleepdd")
            let iconImage3 :UIImage? = UIImage(named: "women_stressed")
            let iconImage4 :UIImage? = UIImage(named: "increase_energy")
            let iconImage5 :UIImage? = UIImage(named: "choosethree")
            
            
            let origImage = UIImage(named: "hormone_free")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            btnHarmone.setImage(tintedImage, for: .normal)
            btnHarmone.tintColor = .white

            
            btnFat.setImage(iconImage1, for: .normal)
            btnSleep.setImage(iconImage2, for: .normal)
            btnStres.setImage(iconImage3, for: .normal)
            btnIncrease.setImage(iconImage4, for: .normal)
//            btnHarmone.setImage(iconImage5, for: .normal)

//            vc!.selectInterest = "Harmone Balance"
//            appDelegate.selectGoal = "Harmone Balance"
            
            
            btnFat.backgroundColor = UIColor.white
            btnSleep.backgroundColor = UIColor.white
            btnStres.backgroundColor = UIColor.white
            btnIncrease.backgroundColor = UIColor.white
            btnHarmone.backgroundColor = UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0)
            
            btnSleep.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnFat.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0), for: .normal)
            btnStres.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0) , for: .normal)
            btnIncrease.setTitleColor(UIColor(red: 10/255.0, green: 194/255.0, blue: 216/255.0, alpha: 1.0) , for: .normal)
            btnHarmone.setTitleColor(UIColor.white, for: .normal)

        }
        
    }
    
    @IBAction private func btnNExt_Pressed(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HCSelectGoalVC") as? HCSelectGoalVC
        vc!.selectInterest = selectInterest
        appDelegate.selectGoal = selectGoal
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}
