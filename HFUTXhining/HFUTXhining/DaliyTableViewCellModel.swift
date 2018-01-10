//
//  DaliyTableViewCellModel.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import Foundation
import UIKit

class DaliyTableViewCellModel: NSObject {
    
    var userId: String                  //用户ID，学号
    var userName: String                //用户名（昵称）
    var userHeadImageURL: String        //用户头像链接
    var userPostTime: String            //用户发帖时间
    var userType: UserType              //用户类型
    var userPostType: UserPostType      //待定
    var userPostId: String              //发帖ID
    var userPostContentURL: String      //帖子内容链接
    var userLikeAmount: Int             //用户获赞数
    var userCommentAmount: Int          //用户获评数
    var userCommentContentURL: String   //用户获评论内容
    var userShareAmount: Int            //用户获分享数
    var userForwardAmount: Int          //用户获转发数
    
    
    init(userIdNew: String, userNameNew: String, userHeadImageURLNew: String, userPostTimeNew: String, userTypeNew: UserType, userPostIdNew: String, userPostContentURLNew: String, userLikeAmountNew: Int, userCommentAmountNew: Int, userShareAmountNew: Int, userCommentContentURLNew: String, userPostTypeNew: UserPostType, userForwardAmountNew: Int) {
        self.userId = userIdNew
        self.userName = userNameNew
        self.userHeadImageURL = userHeadImageURLNew
        self.userPostTime = userPostTimeNew
        self.userType = userTypeNew
        self.userPostId = userPostIdNew
        self.userPostContentURL = userPostContentURLNew
        self.userLikeAmount = userLikeAmountNew
        self.userCommentAmount = userCommentAmountNew
        self.userShareAmount = userShareAmountNew
        self.userCommentContentURL = userCommentContentURLNew
        self.userPostType = userPostTypeNew
        self.userForwardAmount = userForwardAmountNew
        super.init()
    }
    
}

