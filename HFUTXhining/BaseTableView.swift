//
//  BaseTableView.swift
//  HFUTXhining
//
//  Created by   chironyf on 18/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    // MARK: - module属性, 默认为日常帖子
    var postModule: Int = UserPostModule.daliyPost.rawValue
    
    // MARK: - 为tableView添加上拉刷新与下拉加载更多事件
    func addUpdateAndMore() -> Void {
        
    }

}
