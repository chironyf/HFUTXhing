//
//  DaliyTableView.swift
//  HFUTXhining
//
//  Created by   chironyf on 18/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit
import ESPullToRefresh
import UIKit
import Alamofire
import SwiftyJSON

class DaliyTableView: BaseTableView {

    var currentPostArray: Array<PostReceivedModel> = []
    
    override func addUpdateAndMore() -> Void {
        //自定义下拉刷新控件
        self.es_addPullToRefresh {
            [unowned self] in
            
            let parameters: Parameters = [
                "id": id,
                "student_id": student_id,
                "token": _token,
                "module": self.postModule,
                "article_id": UPDATE_ARTICLE
            ]
            
            Alamofire.request(READ_POST_URL, method: .post, parameters: parameters).responseJSON {
                response in
                guard let dataStream = response.data else {
                    print("网络请求失败")
                    return
                }
                let json = JSON(data: dataStream)
                print(json)
                
                var receviedData: Array<PostReceivedModel> = []
                dailyAndConfessionJsonAssignArray(&receviedData, json)
                self.currentPostArray = receviedData
               
                self.reloadData()
                self.refreshControl?.endRefreshing()
                self.es_stopPullToRefresh(ignoreDate: true)
                /// 设置ignoreFooter来处理不需要显示footer的情况
                self.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            }
        }
        
        //默认加载更多组件
        self.es_addInfiniteScrolling {
            [unowned self] in
            
            let lastArticleId = self.currentPostArray.last?.id
            
            let parameters: Parameters = [
                "id": id,
                "student_id": student_id,
                "token": _token,
                "module": self.postModule,
                "article_id": lastArticleId ?? -1
            ]
            
            Alamofire.request(READ_POST_URL, method: .post, parameters: parameters).responseJSON {
                response in
                guard let dataStream = response.data else {
                    print("网络请求失败")
                    return
                }
                let json = JSON(data: dataStream)
                print(json)
                
                var receviedData: Array<PostReceivedModel> = []
                dailyAndConfessionJsonAssignArray(&receviedData, json)
                self.currentPostArray += receviedData

                self.reloadData()
                self.refreshControl?.endRefreshing()
                //
                //                self.daliyTableView.es_stopPullToRefresh(ignoreDate: true)
                //                /// 设置ignoreFooter来处理不需要显示footer的情况
                //                self.daliyTableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
                /// 在这里做加载更多相关事件
                /// ...
                /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                self.es_stopLoadingMore()
                
                /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                //                self.daliyTableView.es_noticeNoMoreData()
            }
            
        }
    }
    
}
