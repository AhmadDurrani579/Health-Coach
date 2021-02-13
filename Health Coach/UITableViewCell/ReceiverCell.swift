//
//  ReceiverCell.swift
//  UniBuzz
//
//  Created by Ahmed Durrani on 21/07/2019.
//  Copyright © 2019 unibuss. All rights reserved.
//

import UIKit
protocol ReciverReplyDelegate : class {
    func receiverReply(cell : ReceiverCell  , checkIndex : IndexPath)
}

class ReceiverCell: UITableViewCell {
    

    @IBOutlet weak var imgOfReceiver: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblReceiverMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
