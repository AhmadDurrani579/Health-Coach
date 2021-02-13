//
//  MessageOrAppointMentCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 20/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol ServiceListDelegate : class {
    func appointmentList(cell : MessageOrAppointMentCell  , selectIndex : IndexPath)
    func chatMessage(cell : MessageOrAppointMentCell  , selectIndex : IndexPath)
    func checkNotificationList(cell : MessageOrAppointMentCell  , selectIndex : IndexPath)

}
class MessageOrAppointMentCell: UITableViewCell {
    @IBOutlet weak var lblAppointmentDate: UILabel!
    weak var delegate : ServiceListDelegate?
    var selectIndex : IndexPath?
    @IBOutlet weak var btnBadge: MIBadgeButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAppointment_Pressed(_ sender: UIButton) {
        delegate?.appointmentList(cell: self , selectIndex: selectIndex!)
    }
    
    @IBAction private func  btnMessageList(_ sender : UIButton) {
        delegate?.chatMessage(cell: self , selectIndex: selectIndex!)
    }
    
    @IBAction func btnSelectNotification(_ sender: UIButton) {
        delegate?.checkNotificationList(cell: self, selectIndex: selectIndex!)
    }
}
