//
//  TableViewCell.swift
//  BeaconList
//
//  Created by hsin0202 on 2016/11/3.
//  Copyright © 2016年 hsin0202. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Major: UILabel!
    @IBOutlet weak var minor: UILabel!
    @IBOutlet weak var RSSI: UILabel!
    @IBOutlet weak var Distance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
