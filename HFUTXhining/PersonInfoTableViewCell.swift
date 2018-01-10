//
//  PersonInfoTableViewCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/24.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var menuCellImage: UIImageView!
    
    @IBOutlet weak var menuCellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.menuCellTitle.textColor = SEC_BLACK_COLOR
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
