//
//  config.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Jelly

//用户类型
enum UserType {
    case normalUser //普通
    case manager    //管理
}
//帖子类型Module
enum UserPostModule: Int {
    case daliyPost  = 0//日常贴
    case confessionPost  = 1//表白帖
    case lostPostAndFoundPost  = 2//失物和寻物帖子
}

//帖子主题
enum UserPostTitle: Int {
    case daliyAndConfession = -1
    case lost = 1   //寻物启事
    case found = 0  //失物招领
}

//失物招领发帖模型
struct LostAndFoundContent {
    var lostTime: String                //
    var lostIn: String
    var lostThing: String
    init(time: String, position: String, thing: String) {
        self.lostTime = time
        self.lostIn = position
        self.lostThing = thing
    }
}
//enum

//enum CollectionCell: String {
//    case confession = "ConfessionReuseCollectionViewCell"
//}

public struct CellIdentifier {
    static let daliyCell = "ReusedDaliyTableViewCell"
    static let confessionCell = "ReusedConfessionTableViewCell"
    static let lostAndFoundCell = "ReusedLostAndFoundTableViewCell"
    static let communityCollectionCell = "ReuseCollectionViewCell"
    static let commonCollectionCell = "CommonCollectionCell"
    static let confessionCollectionCell = "ReuseConfessionCollectionViewCell"
    static let personInfoCell = "ReuseMenuCell"
    static let commentCell = "ReuseCommentCell"
    static let postDetailCell = "ReusePostDetailCell"
    static let lostAndFoundPostDetailCell = "ReusedLostAndFoundPostDetailCell"
}

public struct STBVCIdentifier {
    static let daliyPostID = "STBPostViewController"
    static let lostAndFoundPostID = "STBLostAndFoundViewController"
    static let mainTabBarID = "STBMainTabBarVC"
    static let menuID = "STBMenuVC"
    static let curriculumID = "STBCurriculumVC"
    static let postDetailID = "STBPostDetailVC"
}

public struct MenuIdentifier {
    static let menuHeadName = "MenuHeadName"
}

//导航栏
let SCROLL_LINE_HEIGHT = CGFloat(4.0)
let LABEL_TO_BOTTOM = CGFloat(12.0)
let NAVIGATION_HEIGHT = CGFloat(42.0)
let BUTTON_WIDTH = CGFloat(32.0)
//daliyLabel相对于屏幕的边距
let MARGIN = CGFloat(52.0)

//按钮上弹的步长
let POST_BUTTON_WIDTH = CGFloat(48.0)
let STEP = POST_BUTTON_WIDTH + CGFloat(12.0)

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
let SEC_BLACK_COLOR = UIColor(red: 0x66/255, green: 0x66/255, blue: 0x66/255, alpha: 1)
let STATUS_COLOR = UIColor(red: 0xf6/255, green: 0x7c/255, blue: 0x9c/255, alpha: 1)
let TIME_COLOR = UIColor(red: 0x99/255, green: 0x99/255, blue: 0x99/255, alpha: 1)

//tableViewCell顶线颜色
let CELL_TOP_LINE_COLOR = UIColor(red: 0xf0/255, green: 0xf0/255, blue: 0xf0/255, alpha: 1)

let DALIY_LABEL_MIDX = MARGIN + LINE_WIDTH / 2.0
let CONFESSION_LABEL_MIDX = MARGIN + LINE_WIDTH * 1.5
let LOST_AND_FOUND_LABEL_MIDX = MARGIN + LINE_WIDTH * 2.5


//滑动比例
let PROPORTION = LINE_WIDTH / SCREEN_RECT.width

//服务器URL
let token = "b428cdd0cea5e7d657cca67fdb1a41dc"
//let IP = "http://netzhang.55555.io"
//let IP = "192.168.1.106"
let IP = "http://172.18.220.6:8080"
let TEMP_URL = IP + "/index.php/test/testios"
//登录
let LOGIN_URL = IP + "/index.php/user/login"
//发帖
let POST_URL = IP + "/index.php/article/writeArticle"
//发帖之后继续上传图片
let POST_IMAGE_URL = IP + "/index.php/article/articleImg"
//刷新帖子
let READ_POST_URL = IP + "/index.php/article/readArticle"
//登录成功标志
var LOGIN_FLAG = false
//点赞
let LIKE = IP + "/index.php/comment/pround_add"
//取消点赞
let UN_LIKE = IP + "/index.php/comment/pround_del"
//读取评论数据
let READ_COMMENT = IP + "/index.php/comment/readComment"
//写评论
let WRITE_COMMENT = IP + "/index.php/comment/writeComment"
//请求课表数据
let CURRICULUM = IP + "/index.php/curl_get/get_timetable"

//登录返回信息json
var loginReturnJson: JSON?
var NAME = ""

var id = "14"
var student_id = "2015216820"
var psw = "dfb2524f"
var _token = ""

//用户上传图片的最大数量
let IMG_MAX_MAOUNT = 9

//每次下拉帖子数量
let POST_UPDATE_AMOUNT = 10

//下拉更新文章参数
let UPDATE_ARTICLE = -1

//下拉所有评论
let UPDATE_COMMENT = -1

//tag
let DETAIL_LIKE_TAG = 7000
let DALIY_LIKE_TAG = 1000
let DALIY_COM_TAG = 2000
let CONFESSION_LIKE_TAG = 3000
let CONFESSION_COM_TAG = 4000
let LOST_FOUND_LIKE_TAG = 5000
let LOST_FOUND_COM_TAG = 6000

// MARK: - 转场自定义
let PRESENTATION = JellySlideInPresentation(dismissCurve: .linear,
                                            presentationCurve: .linear,
                                            cornerRadius: 0,
                                            backgroundStyle: .blur(effectStyle: .light),
                                            jellyness: .none,
                                            duration: .normal,
                                            directionShow: .right,
                                            directionDismiss: .right,
                                            widthForViewController: .fullscreen,
                                            heightForViewController: .fullscreen,
                                            horizontalAlignment: .center,
                                            verticalAlignment: .top,
                                            marginGuards: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                                            corners: [.allCorners])
// MARK: - 发帖自定义
let POST_PRESENTATION = JellySlideInPresentation(dismissCurve: .easeInEaseOut,
                                            presentationCurve: .easeInEaseOut,
                                            cornerRadius: 15,
                                            backgroundStyle: .blur(effectStyle: .light),
                                            jellyness: .none,
                                            duration: .normal,
                                            directionShow: .bottom,
                                            directionDismiss: .bottom,
                                            widthForViewController: .fullscreen,
                                            heightForViewController: .fullscreen,
                                            horizontalAlignment: .center,
                                            verticalAlignment: .top,
                                            marginGuards: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0),
                                            corners: [.allCorners])

// MARK: - 侧滑菜单
let MENU_PRESENTATION = JellySlideInPresentation(dismissCurve: .easeInEaseOut,
                                                 presentationCurve: .easeInEaseOut,
                                                 cornerRadius: 15,
                                                 backgroundStyle: .blur(effectStyle: .light),
                                                 jellyness: .none,
                                                 duration: .normal,
                                                 directionShow: .left,
                                                 directionDismiss: .left,
                                                 widthForViewController: .fullscreen,
                                                 heightForViewController: .fullscreen,
                                                 horizontalAlignment: .center,
                                                 verticalAlignment: .top,
                                                 marginGuards: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 56),
                                                 corners: [.allCorners])



