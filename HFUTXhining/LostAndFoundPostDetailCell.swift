//
//  LostAndFoundPostDetailCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 21/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit

class LostAndFoundPostDetailCell: UITableViewCell {

    
    @IBOutlet weak var userHeadImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userPostTime: UILabel!
    
    @IBOutlet weak var lostIn: UILabel!
    
    @IBOutlet weak var lostTime: UILabel!
    
    @IBOutlet weak var lostThing: UILabel!
    
    @IBOutlet weak var lostAndFound: UILabel!
    
    @IBOutlet weak var Images: UICollectionView!
    
    @IBOutlet weak var userLikeImage: UIImageView!
    
    @IBOutlet weak var userLikeAmount: UILabel!
    
    @IBOutlet weak var userCommentImage: UIImageView!
    
    @IBOutlet weak var userCommentAmount: UILabel!
    
    @IBOutlet weak var userTopLine: UIView!
    
    @IBOutlet weak var userBottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.userName.textColor = BLACK_COLOR
        self.userName.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        self.userPostTime.textColor = TIME_COLOR
        self.userLikeAmount.textColor = SEC_BLACK_COLOR
        self.userCommentAmount.textColor = SEC_BLACK_COLOR
        
        self.userTopLine.backgroundColor = CELL_TOP_LINE_COLOR
        self.userBottomLine.backgroundColor = CELL_TOP_LINE_COLOR
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
