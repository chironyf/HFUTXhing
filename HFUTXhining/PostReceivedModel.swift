//
//  PostReceivedModel.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/25.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import Foundation

class PostReceivedModel {
    
    var id: String  = "empty"                           //文章id
    var isAnonymous: Int = 0                            //是否匿名
    var pround_count: Int = 0                           //点赞数
    var comment_count: Int = 0                          //评论数
    var latest_time: String = "00:00:00"                //最近修改时间
    var face_url: String = "empty"                      //头像链接
    var user_id: String = "empty"                       //用户ID
    var title: Int = 0                                  //帖子主题
    var module: Int = UserPostModule.daliyPost.rawValue //帖子模块
    var create_time: String = "00:00:00"                //帖子创建时间
    var content: String = "empty"                       //帖子内容
    var user_name: String = "empty"                     //用户名称
    var imageURL: Array<String> = []                    //帖子图片链接
    var isLiked: Int = 0                                //标识是否被点赞, 默认没有点赞0, 点赞1, 未点赞0
    
}
