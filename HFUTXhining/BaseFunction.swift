//
//  BaseFunction.swift
//  HFUTXhining
//
//  Created by   chironyf on 17/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import Foundation
import ESPullToRefresh
import UIKit
import Alamofire
import SwiftyJSON

    // MARK: - 传入获取到的json, 返回tableView对应数组
func dailyAndConfessionJsonAssignArray(_ array: inout Array<PostReceivedModel>, _ json: JSON) {
    for subJson in json["value"]["article"][0].arrayValue {
        let newPostItem = PostReceivedModel()
        newPostItem.id = subJson["id"].stringValue
        newPostItem.comment_count = subJson["comment_count"].numberValue.intValue
        newPostItem.pround_count = subJson["pround_count"].numberValue.intValue
        newPostItem.isAnonymous = subJson["niming"].numberValue.intValue
        newPostItem.latest_time = subJson["latest_time"].stringValue
        newPostItem.face_url = subJson["face_url"].stringValue
        newPostItem.user_id = subJson["user_id"].stringValue
        newPostItem.title = subJson["title"].numberValue.intValue
        newPostItem.user_name = subJson["user_name"].stringValue
        newPostItem.module = subJson["module"].numberValue.intValue
        newPostItem.create_time = subJson["create_time"].stringValue
        newPostItem.content = subJson["content"].stringValue
        newPostItem.isLiked = json["value"]["pround"][newPostItem.id].numberValue.intValue
        
        for subJson in json["value"]["img"][newPostItem.id].arrayValue {
            newPostItem.imageURL.append(subJson["image_url"].stringValue)
        }
        array.append(newPostItem)
    }
}

func lostAndFoundJsonAssignArray(_ array: inout Array<LostAndFoundPostReceivedModel>, _ json: JSON) {
    for subJson in json["value"]["article"][0].arrayValue {
        let newPostItem = LostAndFoundPostReceivedModel()
        newPostItem.id = subJson["id"].stringValue
        newPostItem.comment_count = subJson["comment_count"].numberValue.intValue
        newPostItem.pround_count = subJson["pround_count"].numberValue.intValue
        newPostItem.isAnonymous = subJson["niming"].numberValue.intValue
        newPostItem.latest_time = subJson["latest_time"].stringValue
        newPostItem.face_url = subJson["face_url"].stringValue
        newPostItem.user_id = subJson["user_id"].stringValue
        newPostItem.title = subJson["title"].numberValue.intValue
        newPostItem.user_name = subJson["user_name"].stringValue
        newPostItem.module = subJson["module"].numberValue.intValue
        newPostItem.create_time = subJson["create_time"].stringValue
        newPostItem.content = subJson["content"].stringValue
        
        let contentJson = JSON(data: newPostItem.content.data(using: String.Encoding.utf8)!)
        newPostItem.xDescription = contentJson["xDescription"].stringValue
        newPostItem.lostIn = contentJson["lostIn"].stringValue
        newPostItem.lostTime = contentJson["lostTime"].stringValue
        newPostItem.lostThing = contentJson["lostThing"].stringValue
        newPostItem.isLiked = json["value"]["pround"][newPostItem.id].numberValue.intValue
        
        for subJson in json["value"]["img"][newPostItem.id].arrayValue {
            newPostItem.imageURL.append(subJson["image_url"].stringValue)
        }
        array.append(newPostItem)
    }
}

    // MARK: - 点赞网络请求
func likeTapPost(_ url: String, _ articleID: String) {
    let parameters: Parameters = [
        "id": id,
        "student_id": student_id,
        "token": _token,
        "article_id": articleID
    ]
    Alamofire.request(url, method: .post, parameters: parameters).responseJSON {
        response in
        guard let dataStream = response.data else {
            print("点赞请求失败")
            return
        }
        let json = JSON(data: dataStream)
        print(json)
    }
}



