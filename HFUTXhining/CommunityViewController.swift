//
//  CommunityViewController.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit
import pop
import Alamofire
import SwiftyJSON
import Kingfisher
import ESPullToRefresh
import Jelly

class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, PostDetailViewControllerDelegate {
    
    func returnLikeAndCommentData(isLiked: Int, likeAmount: Int, commentAmount: Int, cellLines: Int, module: Int) {
        if  module == UserPostModule.daliyPost.rawValue {
            self.daliyTableView.currentPostArray[cellLines].isLiked = isLiked
            self.daliyTableView.currentPostArray[cellLines].pround_count = likeAmount
            self.daliyTableView.currentPostArray[cellLines].comment_count = commentAmount
            self.daliyTableView.reloadData()
        } else if module == UserPostModule.confessionPost.rawValue {
            self.confessionTableView.currentPostArray[cellLines].isLiked = isLiked
            self.confessionTableView.currentPostArray[cellLines].pround_count = likeAmount
            self.confessionTableView.currentPostArray[cellLines].comment_count = commentAmount
            self.confessionTableView.reloadData()
        } else {
            self.lostAndFoundTableView.currentPostArray[cellLines].isLiked = isLiked
            self.lostAndFoundTableView.currentPostArray[cellLines].pround_count = likeAmount
            self.lostAndFoundTableView.currentPostArray[cellLines].comment_count = commentAmount
            self.lostAndFoundTableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - tablView
    
    @IBOutlet weak var daliyTableView: DaliyTableView!
    
    @IBOutlet weak var confessionTableView: ConfessionTableView!
    
    @IBOutlet weak var lostAndFoundTableView: LostAndFoundTableView!
    
    // MARK: - 导航栏（View代替）

    @IBOutlet weak var daliyLabel: UILabel!

    @IBOutlet weak var confessionLabel: UILabel!
   
    @IBOutlet weak var lostAndFoundLabel: UILabel!
    
    @IBOutlet weak var plateView: UIView!
    
    // MARK: - post按钮

    @IBOutlet weak var postButton: UIImageView!
  
    @IBOutlet weak var daliyPost: UIImageView!
    
    @IBOutlet weak var confessionPost: UIImageView!
    
    @IBOutlet weak var lostPost: UIImageView!
 
    @IBOutlet weak var foundPost: UIImageView!
    
    @IBOutlet weak var slideMenu: UIImageView!
    
    // MARK: - 菜单滑动条
    var scrollLine: UIView?
    
    // MARK: - 用于判断scrollView是否横向滑动
    var lastContentOffSet: CGFloat = CGFloat(0.0)
    
    // MARK: - 标志post是否被按下
    var postTapped: Bool = false
    
    var jellyAnimator: JellyAnimator?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.backgroundColor = CELL_TOP_LINE_COLOR
        self.view.backgroundColor = STATUS_COLOR
        initTableViews()
        initView()
    }
    
    // MARK: - 初始化tableView的相关属性
    func initTableViews() {
        
        daliyTableView.delegate = self
        daliyTableView.dataSource = self
        daliyTableView.estimatedRowHeight = 500
        daliyTableView.rowHeight = UITableViewAutomaticDimension
        daliyTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        daliyTableView.backgroundColor = CELL_TOP_LINE_COLOR
        daliyTableView.addUpdateAndMore()
        
        confessionTableView.delegate = self
        confessionTableView.dataSource = self
        confessionTableView.estimatedRowHeight = 500
        confessionTableView.rowHeight = UITableViewAutomaticDimension
        confessionTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        confessionTableView.postModule = UserPostModule.confessionPost.rawValue
        confessionTableView.backgroundColor = CELL_TOP_LINE_COLOR
        confessionTableView.addUpdateAndMore()
        
        lostAndFoundTableView.delegate = self
        lostAndFoundTableView.dataSource = self
        lostAndFoundTableView.estimatedRowHeight = 500
        lostAndFoundTableView.rowHeight = UITableViewAutomaticDimension
        lostAndFoundTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        lostAndFoundTableView.postModule = UserPostModule.lostPostAndFoundPost.rawValue
        lostAndFoundTableView.backgroundColor = CELL_TOP_LINE_COLOR
        lostAndFoundTableView.addUpdateAndMore()
    }
  
    // MARK: - 初始化界面以及添加交互
    func initView() {
        
        //添加标题栏颜色
        self.daliyLabel.textColor = BLACK_COLOR
        self.confessionLabel.textColor = BLACK_COLOR
        self.lostAndFoundLabel.textColor = BLACK_COLOR
        
        //首次进入默认在日常板块
        daliyLabel.textColor = RED_COLOR
        
        //添加导航栏滑动条
        scrollLine = UIView(frame: CGRect(x: MARGIN, y: NAVIGATION_HEIGHT - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT))
        scrollLine!.backgroundColor = RED_COLOR
        plateView.addSubview(scrollLine!)
        
        //初始化发送按钮
        initButton(button: postButton)
        initButton(button: daliyPost)
        initButton(button: confessionPost)
        initButton(button: lostPost)
        initButton(button: foundPost)
        
        //将发帖按钮置于视图最前端
        self.view.bringSubview(toFront: foundPost)
        self.view.bringSubview(toFront: lostPost)
        self.view.bringSubview(toFront: confessionPost)
        self.view.bringSubview(toFront: daliyPost)
        self.view.bringSubview(toFront: postButton)
        
        addGesture()
     
    }
    

    
    // MARK: - 添加label和post响应事件
    func addGesture() {
        
        //添加label手势, 实现页面横向滑动
        let confessionTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.confessionTap(_:)))
        confessionLabel.isUserInteractionEnabled = true
        confessionLabel.addGestureRecognizer(confessionTapGesture)
        
        let daliyTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.daliyTap(_:)))
        daliyLabel.isUserInteractionEnabled = true
        daliyLabel.addGestureRecognizer(daliyTapGesture)
        
        let lostAndFoundTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.lostAndFoundTap(_:)))
        lostAndFoundLabel.isUserInteractionEnabled = true
        lostAndFoundLabel.addGestureRecognizer(lostAndFoundTapGesture)
        
        //添加post手势实现不同类型post动画
        let postTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.postTap(_:)))
        postButton.isUserInteractionEnabled = true
        postButton.addGestureRecognizer(postTapGesture)
        
        //添加日常post手势
        let daliyPostTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.daliyPostTap(_:)))
        daliyPost.isUserInteractionEnabled = true
        daliyPost.addGestureRecognizer(daliyPostTapGesture)
        
        //添加表白墙post手势
        let confessionPostTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.confessionPostTap(_:)))
        confessionPost.isUserInteractionEnabled = true
        confessionPost.addGestureRecognizer(confessionPostTapGesture)
        
        //添加寻物启事post手势
        let foundPostTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.foundPostTap(_:)))
        foundPost.isUserInteractionEnabled = true
        foundPost.addGestureRecognizer(foundPostTapGesture)
        
        //添加失物招领post手势
        let lostPostTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.lostPostTap(_:)))
        lostPost.isUserInteractionEnabled = true
        lostPost.addGestureRecognizer(lostPostTapGesture)
        
        //添加菜单侧滑手势
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.menuTap(_:)))
        slideMenu.isUserInteractionEnabled = true
        slideMenu.addGestureRecognizer(menuTapGesture)
    }
    
    // MARK: - daliyPost按钮
    func menuTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.menuID) as! PersonInfoViewController
        self.jellyAnimator = JellyAnimator(presentation: MENU_PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - daliyPost按钮
    func daliyPostTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.daliyPostID) as! PostViewController
        vc.currentModule = UserPostModule.daliyPost.rawValue
        vc.currentTitle = UserPostTitle.daliyAndConfession.rawValue
        self.jellyAnimator = JellyAnimator(presentation: POST_PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - confession post
    func confessionPostTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.daliyPostID) as! PostViewController
        vc.currentModule = UserPostModule.confessionPost.rawValue
        vc.currentTitle = UserPostTitle.daliyAndConfession.rawValue
        self.jellyAnimator = JellyAnimator(presentation: POST_PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - found post
    func foundPostTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.lostAndFoundPostID) as! LostAndFoundPostViewController
        vc.isFound = true
        vc.currentModule = UserPostModule.lostPostAndFoundPost.rawValue
        vc.currentTitle = UserPostTitle.found.rawValue
        self.jellyAnimator = JellyAnimator(presentation: POST_PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - lost post
    func lostPostTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.lostAndFoundPostID) as! LostAndFoundPostViewController
        vc.isFound = false
        vc.currentModule = UserPostModule.lostPostAndFoundPost.rawValue
        vc.currentTitle = UserPostTitle.lost.rawValue
        self.jellyAnimator = JellyAnimator(presentation: POST_PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - 初始化发帖按钮,按默认值
    func initButton(button: UIImageView) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize(width: 0, height: 0) //API中默认 y = -3
        button.layer.shadowOpacity = 0.5
    }
    
    // MARK: - post响应按钮
    func postTap(_ sender: UITapGestureRecognizer) {
        if (postTapped == false) {
            postButton.image = UIImage(named: "发送取消")
            if (postButton.image == nil) {
                print("图片更换失败")
            }
            daliyPost.pop_add(Animation.springPOPViewFrame(frame: CGRect(x: postButton.frame.minX, y: postButton.frame.minY - STEP, width: postButton.frame.width, height: postButton.frame.height)), forKey: "daliyPostKeyUp")
            
            confessionPost.pop_add(Animation.springPOPViewFrame(frame: CGRect(x: postButton.frame.minX, y: postButton.frame.minY - 2 * STEP, width: postButton.frame.width, height: postButton.frame.height)), forKey: "confessionPostKeyUp")
            
            foundPost.pop_add(Animation.springPOPViewFrame(frame: CGRect(x: postButton.frame.minX, y: postButton.frame.minY - 3 * STEP, width: postButton.frame.width, height: postButton.frame.height)), forKey: "foundPostKeyUp")
            
            lostPost.pop_add(Animation.springPOPViewFrame(frame: CGRect(x: postButton.frame.minX, y: postButton.frame.minY - 4 * STEP, width: postButton.frame.width, height: postButton.frame.height)), forKey: "lostAndFoundPostKeyUp")
            postTapped = true
            print("false up")
        } else {
            postButton.image = UIImage(named: "填写信息完成")
            let sameAnimation = Animation.springPOPViewFrame(frame: CGRect(x: postButton.frame.minX, y: postButton.frame.minY, width: postButton.frame.width, height: postButton.frame.height))
            daliyPost.pop_add(sameAnimation, forKey: "daliyPostKeyDown")
            
            confessionPost.pop_add(sameAnimation, forKey: "confessionPostKeyDown")
            foundPost.pop_add(sameAnimation, forKey: "foundPostKeyDown")
            lostPost.pop_add(sameAnimation, forKey: "lostAndFoundPostKeyDown")
            postTapped = false
            print("true down")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = PostDetailViewController()
        vc.delegate = self
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        scrollLine?.removeFromSuperview()
    }
    
    // MARK: - 顶部标签添加响应动作
    func confessionTap(_ sender: UITapGestureRecognizer) {
        
        scrollView.pop_add(Animation.springPOPScrollViewContentOffset(point: CGPoint(x: SCREEN_RECT.width, y: 0)), forKey: "x")
        
        confessionLabel.pop_add(Animation.springPOPLabelTextColor(color: RED_COLOR), forKey: "c")
        
        daliyLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "d")
        
        lostAndFoundLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "l")
    }
    
    func daliyTap(_ sender: UITapGestureRecognizer) {

        scrollView.pop_add(Animation.springPOPScrollViewContentOffset(point: CGPoint(x: 0, y: 0)), forKey: "x2")

        confessionLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "c2")

        daliyLabel.pop_add(Animation.springPOPLabelTextColor(color: RED_COLOR), forKey: "d2")
        
        lostAndFoundLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "l2")
    }
    
    func lostAndFoundTap(_ sender: UITapGestureRecognizer) {
        
        scrollView.pop_add(Animation.springPOPScrollViewContentOffset(point: CGPoint(x: SCREEN_RECT.width * 2, y: 0)), forKey: "x3")

        confessionLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "c3")

        lostAndFoundLabel.pop_add(Animation.springPOPLabelTextColor(color: RED_COLOR), forKey: "l3")
        
        daliyLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "d3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tableViewDataSource设置
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView is DaliyTableView {
            let tempTable = tableView as! DaliyTableView
            return tempTable.currentPostArray.count
        } else if tableView is ConfessionTableView {
            let tempTable = tableView as! ConfessionTableView
            return tempTable.currentPostArray.count
        } else if tableView is LostAndFoundTableView {
            let tempTable = tableView as! LostAndFoundTableView
            return tempTable.currentPostArray.count
        } else {
            return 0
        }
    }
    
    // MARK: - 点击某个cell时的响应事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("当前选中的行数是\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView is DaliyTableView {
            let tempTable = tableView as! DaliyTableView
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.daliyCell, for: indexPath) as! DaliyTableViewCell
            cell.userHeadImage.image = UIImage(named: "头像")
            
            if tempTable.currentPostArray[indexPath.row].isLiked == 1 {
                cell.userLikeImage.image = UIImage(named: "点赞了")
            } else {
                cell.userLikeImage.image = UIImage(named: "点赞")
            }
            
            cell.userNameLabel?.text = tempTable.currentPostArray[indexPath.row].user_name
            if tempTable.currentPostArray[indexPath.row].isAnonymous == 1 {
                cell.userNameLabel?.text = "匿名童鞋"
                cell.userHeadImage.image = UIImage(named: "匿名头像")
            }
            cell.userPostTime?.text = tempTable.currentPostArray[indexPath.row].latest_time
            cell.userPostContent?.text = tempTable.currentPostArray[indexPath.row].content
            cell.userLikeAmount?.text = "\(tempTable.currentPostArray[indexPath.row].pround_count)"
            cell.userCommentAmount?.text = "\(tempTable.currentPostArray[indexPath.row].comment_count)"
            cell.backgroundColor = UIColor.clear
            
            //给点赞按钮添加点击事件
            cell.userLikeImage.tag = DALIY_LIKE_TAG + indexPath.row
            let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.daliyLikeTap(_:)))
            cell.userLikeImage.isUserInteractionEnabled = true
            cell.userLikeImage.addGestureRecognizer(likeTapGesture)
            
            //给评论按钮添加点击事件
            cell.userCommentImage.tag = DALIY_COM_TAG + indexPath.row
            let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.daliyCommentTap(_:)))
            cell.userCommentImage.isUserInteractionEnabled = true
            cell.userCommentImage.addGestureRecognizer(commentTapGesture)
            cell.userImagesCollectionViewWidth.constant = SCREEN_RECT.width
            cell.reloadData(setImgURLSet: tempTable.currentPostArray[indexPath.row].imageURL)
            return cell
            
        } else if tableView is ConfessionTableView {
            let temp = tableView as! ConfessionTableView
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.confessionCell, for: indexPath) as! ConfessionTableViewCell
            
            cell.reloadData(setImgURLSet: temp.currentPostArray[indexPath.row].imageURL)
            cell.userHeadImage.image = UIImage(named: "头像")
            
            if temp.currentPostArray[indexPath.row].isLiked == 1 {
                cell.userLikeImage.image = UIImage(named: "点赞了")
            } else {
                cell.userLikeImage.image = UIImage(named: "点赞")
            }
            
            cell.userNameLabel?.text = temp.currentPostArray[indexPath.row].user_name
            cell.userPostTimeLabel?.text = temp.currentPostArray[indexPath.row].latest_time
            cell.userPostContentLabel?.text = temp.currentPostArray[indexPath.row].content
            cell.userLikeAmount?.text = "\(temp.currentPostArray[indexPath.row].pround_count)"
            cell.userCommentAmount?.text = "\(temp.currentPostArray[indexPath.row].comment_count)"
            cell.backgroundColor = UIColor.clear
            
            if temp.currentPostArray[indexPath.row].isAnonymous == 1 {
                cell.userNameLabel?.text = "匿名童鞋"
                cell.userHeadImage.image = UIImage(named: "匿名头像")
            }
            
            cell.userLikeImage.tag = CONFESSION_LIKE_TAG + indexPath.row
            let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.confessionLikeTap(_:)))
            cell.userLikeImage.isUserInteractionEnabled = true
            cell.userLikeImage.addGestureRecognizer(likeTapGesture)
            
            cell.userCommentImage.tag = CONFESSION_COM_TAG + indexPath.row
            let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.confessionCommentTap(_:)))
            cell.userCommentImage.isUserInteractionEnabled = true
            cell.userCommentImage.addGestureRecognizer(commentTapGesture)
            
            return cell
            
        } else {
            let temp  = tableView as! LostAndFoundTableView
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.lostAndFoundCell, for: indexPath) as! LostAndFoundTableViewCell
            cell.userHeadImage?.image = UIImage(named: "头像")
            
            if temp.currentPostArray[indexPath.row].title == UserPostTitle.found.rawValue {
                cell.resLabel?.text = "#失物招领"
            } else {
                cell.resLabel?.text = "#寻物启事"
            }
            
            if temp.currentPostArray[indexPath.row].isLiked == 1 {
                cell.userLikeImage.image = UIImage(named: "点赞了")
            } else {
                cell.userLikeImage.image = UIImage(named: "点赞")
            }
            
            cell.userNameLabel?.text = temp.currentPostArray[indexPath.row].user_name
            cell.postTime?.text = temp.currentPostArray[indexPath.row].latest_time
            cell.lostTime?.text = temp.currentPostArray[indexPath.row].lostTime
            cell.lostIn?.text = temp.currentPostArray[indexPath.row].lostIn
            cell.lostThing?.text = temp.currentPostArray[indexPath.row].lostThing
            cell.userLikeAmount?.text = "\(temp.currentPostArray[indexPath.row].pround_count)"
            cell.userCommentAmount?.text = "\(temp.currentPostArray[indexPath.row].comment_count)"

            if temp.currentPostArray[indexPath.row].isAnonymous == 1 {
                cell.userNameLabel?.text = "匿名童鞋"
                cell.userHeadImage.image = UIImage(named: "匿名头像")
            }
            
            cell.backgroundColor = UIColor.clear
            
            cell.userLikeImage.tag = LOST_FOUND_LIKE_TAG + indexPath.row
            let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.lostAndFoundLikeTap(_:)))
            cell.userLikeImage.isUserInteractionEnabled = true
            cell.userLikeImage.addGestureRecognizer(likeTapGesture)
            
            cell.userCommentImage.tag = LOST_FOUND_COM_TAG + indexPath.row
            let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.lostAndFoundCommentTap(_:)))
            cell.userCommentImage.isUserInteractionEnabled = true
            cell.userCommentImage.addGestureRecognizer(commentTapGesture)

            return cell
        }
    }
    
    
    // MARK: - cell的like点击事件
    func daliyLikeTap(_ sender: UITapGestureRecognizer) {
        if daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].isLiked == 0 {
            daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].isLiked = 1
            daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].pround_count += 1
            likeTapPost(LIKE, daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].id)
        } else {
            daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].isLiked = 0
            daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].pround_count -= 1
            likeTapPost(UN_LIKE, daliyTableView.currentPostArray[sender.view!.tag - DALIY_LIKE_TAG].id)
        }
        daliyTableView.reloadData()
    }
    
    func confessionLikeTap(_ sender: UITapGestureRecognizer) {
        if confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].isLiked == 0 {
            confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].isLiked = 1
            confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].pround_count += 1
            likeTapPost(LIKE, confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].id)
        } else {
            confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].isLiked = 0
            confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].pround_count -= 1
            likeTapPost(UN_LIKE, confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_LIKE_TAG].id)
        }
        confessionTableView.reloadData()
    }
    
    func lostAndFoundLikeTap(_ sender: UITapGestureRecognizer) {
        if lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].isLiked == 0 {
            lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].isLiked = 1
            lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].pround_count += 1
            likeTapPost(LIKE, lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].id)
        } else {
            lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].isLiked = 0
            lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].pround_count -= 1
            likeTapPost(UN_LIKE, lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_LIKE_TAG].id)
        }
        lostAndFoundTableView.reloadData()
    }
    
    // MARK: - cell的comment点击事件
    func daliyCommentTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.postDetailID) as! PostDetailViewController
        vc.delegate = self
        vc.cellLindes = sender.view!.tag - DALIY_COM_TAG
        vc.module = UserPostModule.daliyPost.rawValue
        vc.postCell = daliyTableView.currentPostArray[sender.view!.tag - DALIY_COM_TAG]
        self.jellyAnimator = JellyAnimator(presentation: PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    func confessionCommentTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.postDetailID) as! PostDetailViewController
        vc.delegate = self
        vc.cellLindes = sender.view!.tag - CONFESSION_COM_TAG
        vc.module = UserPostModule.confessionPost.rawValue
        vc.postCell = confessionTableView.currentPostArray[sender.view!.tag - CONFESSION_COM_TAG]
        self.jellyAnimator = JellyAnimator(presentation: PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    func lostAndFoundCommentTap(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.postDetailID) as! PostDetailViewController
        vc.delegate = self
        vc.cellLindes = sender.view!.tag - LOST_FOUND_COM_TAG
        vc.module = UserPostModule.lostPostAndFoundPost.rawValue
        vc.lostAndFoundPostCell = lostAndFoundTableView.currentPostArray[sender.view!.tag - LOST_FOUND_COM_TAG]
        vc.isNormal = false
        self.jellyAnimator = JellyAnimator(presentation: PRESENTATION)
        self.jellyAnimator?.prepare(viewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - ScrollView属性设置
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffSet = scrollView.contentOffset.x
    }
    
    // MARK: - scrollView 滑动时调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是横向滑动
        if (lastContentOffSet != scrollView.contentOffset.x) {
            //实现滑动中scrollLine的滑动
            scrollLine?.frame = CGRect(x: MARGIN + scrollView.contentOffset.x * PROPORTION, y: NAVIGATION_HEIGHT - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT)
            //实现滑动label颜色过渡
            if ((scrollLine?.frame.midX)! > DALIY_LABEL_MIDX && (scrollLine?.frame.midX)! < CONFESSION_LABEL_MIDX) {
                let value = ((scrollLine?.frame.midX)! - DALIY_LABEL_MIDX) / LINE_WIDTH
                daliyLabel.textColor = Tools.gapColor(startColor: RED_COLOR, endColor: BLACK_COLOR, value: value)
                confessionLabel.textColor = Tools.gapColor(startColor: BLACK_COLOR, endColor: RED_COLOR, value: value)
            } else if ((scrollLine?.frame.midX)! > CONFESSION_LABEL_MIDX && (scrollLine?.frame.midX)! < LOST_AND_FOUND_LABEL_MIDX) {
                let value = ((scrollLine?.frame.midX)! - CONFESSION_LABEL_MIDX) / LINE_WIDTH
                confessionLabel.textColor = Tools.gapColor(startColor: RED_COLOR, endColor: BLACK_COLOR, value: value)
                lostAndFoundLabel.textColor = Tools.gapColor(startColor: BLACK_COLOR, endColor: RED_COLOR, value: value)
            }
        }
    }
}
