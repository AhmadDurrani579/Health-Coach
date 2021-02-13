//
//  ProgramAgreementSlider1.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 22/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class ProgramAgreementSlider1: UIViewController {

    @IBOutlet weak var txtOfAgrement: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: Date())
        let nextMonth = Calendar.current.date(byAdding: .month, value: 5, to: Date())
        let nextFiveMonth = formatter.string(from: nextMonth!)
        txtOfAgrement.text = "Welcome. During the coming four months, you will learn ways to help yourself achieve a healthier diet and lifestyle. Please read the following. If anything is unclear, please ask. \n This Agreement is made today between Coogeki Health and the person named at the end of this document, [the Client].\n The Program in which you are about to enrol in will include all of the following:\n A. Two 45-minute appointments each month for four months, which will include a discussion of your progress, recommendations, and summary notes. \n B.  Special events like webinars, group seminars, and/or workshops related to health and wellness. \n C.  A variety of handouts, recipes, samples, and other materials as appropriate.\n D.  An invitation for guests to attend special events. \n \n SCHEDULING \n \n As your Coach, we understand that our clients have busy schedules and we take pride in not keeping them waiting or keeping them longer than planned. Each session will end 45 minutes after it was scheduled to begin. Please be on time. If the Client needs to cancel or reschedule the appointment, the Client must do so 24 hours in advance; otherwise, the Client will forfeit that appointment and will not have an opportunity to reschedule it.\n Program begins:\(myString)  \n and ends : \(nextFiveMonth) \n This program expires if all 8 sessions have not been completed within one month after the End Date specified above."
        // Do any additional setup after loading the view.
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
