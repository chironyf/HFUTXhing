//
//  CommentTableViewCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 16/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commenterHead: UIImageView!
    
    @IBOutlet weak var commenterName: UILabel!
    
    @IBOutlet weak var commentTime: UILabel!
    
    @IBOutlet weak var commentContent: UILabel!
    
    @IBOutlet weak var userBottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.userBottomLine.backgroundColor = CELL_TOP_LINE_COLOR
        self.commenterName.textColor = BLACK_COLOR
        self.commentTime.textColor = TIME_COLOR
        self.commentContent.textColor = BLACK_COLOR
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
