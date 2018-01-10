//
//  LostAndFoundTableViewCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/21.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit

class LostAndFoundTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var userHeadImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postTime: UILabel!
    
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var foundTime: UILabel!
    
    @IBOutlet weak var res: UILabel!
    
    @IBOutlet weak var resLabel: UILabel!
    
    @IBOutlet weak var resDescription: UICollectionView!
   
    
    @IBOutlet weak var resImages: UICollectionView!
    
    
    @IBOutlet weak var userFunctionArea: UIView!
    
    @IBOutlet weak var userLikeArea: UIView!
    
    @IBOutlet weak var userLikeImage: UIImageView!
    
    @IBOutlet weak var userLikeAmount: UILabel!
    
    @IBOutlet weak var userCommentArea: UIView!
    
    @IBOutlet weak var userCommentImage: UIImageView!
    
    @IBOutlet weak var userCommentAmount: UILabel!
    
    @IBOutlet weak var lostIn: UILabel!

    @IBOutlet weak var lostTime: UILabel!
    
    @IBOutlet weak var lostThing: UILabel!
    
    @IBOutlet weak var userTopLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
        // Initialization code
        self.userNameLabel.textColor = BLACK_COLOR
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.postTime.textColor = TIME_COLOR
        
        self.userLikeAmount.textColor = SEC_BLACK_COLOR
        self.userCommentAmount.textColor = SEC_BLACK_COLOR
        
        
        self.userTopLine.backgroundColor = CELL_TOP_LINE_COLOR
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
