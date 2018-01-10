//
//  DaliyTableViewCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit

class DaliyTableViewCell: UITableViewCell {

    //用户头像
    @IBOutlet weak var userHeadImage: UIImageView!
    //用户昵称
    @IBOutlet weak var userNameLabel: UILabel!
    //用户发帖时间
    @IBOutlet weak var userPostTime: UILabel!
    //用户发帖内容
    @IBOutlet weak var userPostContent: UILabel!
    //用户上传的图片
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    //功能区，包括点赞、评论、转发和分享
    @IBOutlet weak var userFunctionArea: UIView!
    
    //点赞
    @IBOutlet weak var userLikeArea: UIView!
    
    @IBOutlet weak var userLikeImage: UIImageView!
    
    @IBOutlet weak var userLikeAmount: UILabel!
    
    //评论
    @IBOutlet weak var userCommentArea: UIView!
    
    @IBOutlet weak var userCommentImage: UIImageView!
    
    @IBOutlet weak var userCommentAmount: UILabel!
    
    //转发
    @IBOutlet weak var userForwardArea: UIView!

    @IBOutlet weak var userForwardImage: UIImageView!
    
    @IBOutlet weak var userForwardAmount: UILabel!
    
    //分享
    @IBOutlet weak var userShareArea: UIView!

    @IBOutlet weak var userShareImage: UIImageView!
    
    @IBOutlet weak var userShareAmount: UILabel!
    

    @IBOutlet weak var userTopLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        userFunctionArea.backgroundColor = UIColor.clear
        userTopLine.backgroundColor = CELL_TOP_LINE_COLOR
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
