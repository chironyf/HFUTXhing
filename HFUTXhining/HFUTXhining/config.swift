//
//  config.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import Foundation
import UIKit

//用户类型
enum UserType {
    case normalUser //普通
    case manager    //管理
}
//帖子类型
enum UserPostType {
    case originPost //原帖
    case modifyPost //修改贴
}

//导航栏
let SCROLL_LINE_HEIGHT = CGFloat(4.0)
let LABEL_TO_BOTTOM = CGFloat(12.0)
let NAVIGATION_HEIGHT = CGFloat(42.0)
let BUTTON_WIDTH = CGFloat(32.0)

//数值
let SCREEN_RECT = UIScreen.main.bounds.size
//
let SPRING_BOUNCE = CGFloat(10.0)
let SPRING_SPEED = CGFloat(10.0)

//划线宽度
let LINE_WIDTH = (SCREEN_RECT.width - 104) / 3.0

//颜色
let RED_COLOR = UIColor(red: 0xe7/255, green: 0x34/255, blue: 0x62/255, alpha: 1)
let BLACK_COLOR = UIColor(red: 0x33/255, green: 0x33/255, blue: 0x33/255, alpha: 1)

//tableViewCell顶线颜色
let CELL_TOP_LINE_COLOR = UIColor(red: 0x33/255, green: 0x33/255, blue: 0x33/255, alpha: 0.5)



