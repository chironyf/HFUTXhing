//
//  BaseTableViewCellModel.swift
//  HFUTXhining
//
//  Created by   chironyf on 21/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import Foundation

class BaseTableViewCellModel {
    //用户ID，学号
    var userId: String = ""
    
    //用户名（昵称）
    var userName: String = ""
    
    //用户头像链接
    var userHeadImageURL: String = ""
    
    //用户发帖时间
    var userPostTime: String = ""
    
    //用户类型
    var userType: UserType = UserType.normalUser
    
    //发帖ID
    var userPostId: String = ""
    
    //帖子内容链接
    var userPostContentURL: String = ""
    
    //用户获赞数
    var userLikeAmount: Int = -1
    
    //用户获评数
    var userCommentAmount: Int = -1
    
    //用户获评论内容
    var userCommentContentURL: String = ""
}
