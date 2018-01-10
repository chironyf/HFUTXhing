//
//  PostDetailViewController.swift
//  HFUTXhining
//
//  Created by   chironyf on 16/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var returnImg: UIImageView!


    @IBOutlet weak var otherImg: UIImageView!
    
    
    @IBOutlet weak var postDetailTableView: UITableView!
    
    // MARK: - 标志帖子详情类型
    var isNormal: Bool = true
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var commentPostButton: UIButton!
    
    @IBOutlet weak var commentBottomArea: UIView!
    
    @IBOutlet weak var commentBottomConstraint: NSLayoutConstraint!
    //当前帖子数据暂存区
    var postCell: PostReceivedModel = PostReceivedModel()
    
    var lostAndFoundPostCell: LostAndFoundPostReceivedModel = LostAndFoundPostReceivedModel()
    
    //当前帖子评论数据暂存区
    var commentArray: Array<CommentModel> = []
    
    //反向数据传递附带数据
    var cellLindes: Int = 0
    
    var module: Int = UserPostModule.daliyPost.rawValue
    
    //数据传递代理
    var delegate: PostDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = STATUS_COLOR
        self.initTableView()
        self.registerNib()
        self.commentInit()
        self.addGesture()
        self.updateComment()
    }
    
    // MARK: - 帖子初始化
    func initTableView() {
        self.postDetailTableView.delegate = self
        self.postDetailTableView.dataSource = self
        self.postDetailTableView.estimatedRowHeight = 100
        self.postDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.postDetailTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.postDetailTableView.backgroundColor = CELL_TOP_LINE_COLOR
    }
    
	// MARK: - cell初始化
    func registerNib() {
        let cellNib = UINib(nibName: "PostDetailCell", bundle: nil)
        postDetailTableView.register(cellNib, forCellReuseIdentifier: CellIdentifier.postDetailCell)
        
        let lfCellNib = UINib(nibName: "LostAndFoundPostDetailCell", bundle: nil)
        postDetailTableView.register(lfCellNib, forCellReuseIdentifier: CellIdentifier.lostAndFoundPostDetailCell)
    }
    
    // MARK: - 评论控件初始化
    func commentInit() {
        self.commentTextField.placeholder = "评论一波..."
        self.commentTextField.delegate = self
        self.commentPostButton.addTarget(self, action: #selector(commmentPostTap), for: .touchUpInside)
        self.commentPostButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    // MARK: - 键盘通知
    func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            //self.view.setNeedsLayout()
            //改变下约束
            self.commentBottomConstraint.constant = intersection.height
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve), animations: {
                            _ in
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    // MARK: - 控件手势初始化
    func addGesture() {
        let returnTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.returnTap(_:)))
        returnImg.isUserInteractionEnabled = true
        returnImg.addGestureRecognizer(returnTapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        updateComment()
    }

    // MARK: - 更新帖子评论数据
    func updateComment() {
        var parameters: Parameters = [
            "id": id,
            "student_id": student_id,
            "token": _token,
            "article_id": postCell.id,
            "comment_id": UPDATE_COMMENT
        ]
        if self.isNormal == false {
            parameters["article_id"] = self.lostAndFoundPostCell.id
        }
        Alamofire.request(READ_COMMENT, method: .post, parameters: parameters).responseJSON {
            response in
            guard let dataStream = response.data else {
                print("nil")
                return
            }
            let json = JSON(data: dataStream)
            print(json)
            self.commentArray.removeAll()
            
            for commentItem in json["value"][0].arrayValue {
                let newItem = CommentModel()
                newItem.commentContent = commentItem["content"].stringValue
                newItem.commenterName = commentItem["comment_name"].stringValue
                newItem.commentTime = commentItem["comment_time"].stringValue
                self.commentArray.append(newItem)
            }
            self.postDetailTableView.reloadData()
        }
    }
    
    // MARK: - 评论发送
    func commmentPostTap() {
        guard let newComment = commentTextField.text else {
            print("unvalid comment data")
            return
        }
        if newComment != "" {
            var parameters: Parameters = [
                "id": id,
                "student_id": student_id,
                "token": _token,
                "article_id": lostAndFoundPostCell.id,
                "content": newComment
            ]
            if self.isNormal {
                parameters["article_id"] = self.postCell.id
            }
            
            Alamofire.request(WRITE_COMMENT, method: .post, parameters: parameters).responseJSON {
                response in
                guard let dataStream = response.data else {
                    print("nil")
                    return
                }
                let json = JSON(data: dataStream)
                print(json)
                self.commentTextField.text = ""
                self.commentTextField.resignFirstResponder()
                self.commentPostButton.isEnabled = false
                if self.isNormal == false {
                    self.lostAndFoundPostCell.comment_count += 1
                } else {
                    self.postCell.comment_count += 1
                }
                self.updateComment()
            }
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = commentTextField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        self.commentPostButton.isEnabled = newText.characters.count > 0
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return commentArray.count
        }
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if self.isNormal {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.postDetailCell, for: indexPath) as! PostDetailCell
                cell.userHeadImg.image = UIImage(named: "头像")
                
                cell.reloadData(setImgURLSet: postCell.imageURL)
                
                if postCell.isLiked == 1 {
                    cell.userLikeImg.image = UIImage(named: "点赞了")
                } else if postCell.isLiked == 0 {
                    cell.userLikeImg.image = UIImage(named: "点赞")
                }
                
                cell.userName?.text = postCell.user_name
                cell.userPostTime?.text = postCell.latest_time
                cell.userPostContent?.text = postCell.content
                cell.userLikeAmount?.text = "\(postCell.pround_count)"
                cell.userCommentAmount?.text = "\(postCell.comment_count)"
                cell.backgroundColor = UIColor.clear
                
                cell.userLikeImg.tag = DETAIL_LIKE_TAG + indexPath.row
                let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.detailLikeTap(_:)))
                cell.userLikeImg.isUserInteractionEnabled = true
                cell.userLikeImg.addGestureRecognizer(likeTapGesture)
                
                if postCell.isAnonymous == 1 {
                    cell.userName.text = "匿名童鞋"
                    cell.userHeadImg.image = UIImage(named: "匿名头像")
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.lostAndFoundPostDetailCell, for: indexPath) as! LostAndFoundPostDetailCell
                
                cell.userLikeImage.tag = DETAIL_LIKE_TAG + indexPath.row
                let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.detailLikeTap(_:)))
                cell.userLikeImage.isUserInteractionEnabled = true
                cell.userLikeImage.addGestureRecognizer(likeTapGesture)
                
                cell.userLikeAmount.text = "\(self.lostAndFoundPostCell.pround_count)"
                cell.userCommentAmount.text = "\(self.lostAndFoundPostCell.comment_count)"
                
                cell.userHeadImage.image = UIImage(named: "头像")
                if lostAndFoundPostCell.isLiked == 1 {
                    cell.userLikeImage.image = UIImage(named: "点赞了")
                } else if postCell.isLiked == 0 {
                    cell.userLikeImage.image = UIImage(named: "点赞")
                }
                
                if lostAndFoundPostCell.title == UserPostTitle.found.rawValue {
                    cell.lostAndFound.text = "#失物招领"
                } else {
                    cell.lostAndFound.text = "#寻物启事"
                }
                
                cell.userName?.text = lostAndFoundPostCell.user_name
                cell.userPostTime?.text = lostAndFoundPostCell.latest_time
                cell.lostIn?.text = lostAndFoundPostCell.lostIn
                cell.lostTime?.text = lostAndFoundPostCell.lostTime
                cell.lostThing?.text = lostAndFoundPostCell.lostThing
                if lostAndFoundPostCell.isAnonymous == 1 {
                    cell.userName.text = "匿名童鞋"
                    cell.userHeadImage.image = UIImage(named: "匿名头像")
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.commentCell, for: indexPath) as! CommentTableViewCell
            cell.commentContent.text = commentArray[indexPath.row].commentContent
            cell.commenterHead.image = UIImage(named: "头像")
            cell.commenterName.text = commentArray[indexPath.row].commenterName
            cell.commentTime.text = commentArray[indexPath.row].commentTime
            return cell
        }
    }
    
    func detailLikeTap(_ sender: UITapGestureRecognizer) {
        if self.isNormal {
            if self.postCell.isLiked == 0 {
                self.postCell.isLiked = 1
                self.postCell.pround_count += 1
                likeTapPost(LIKE, self.postCell.id)
            } else {
                self.postCell.isLiked = 0
                self.postCell.pround_count -= 1
                likeTapPost(UN_LIKE, self.postCell.id)
            }
        } else {
            if self.lostAndFoundPostCell.isLiked == 0 {
                self.lostAndFoundPostCell.isLiked = 1
                self.lostAndFoundPostCell.pround_count += 1
                likeTapPost(LIKE, self.lostAndFoundPostCell.id)
            } else {
                self.lostAndFoundPostCell.isLiked = 0
                self.lostAndFoundPostCell.pround_count -= 1
                likeTapPost(UN_LIKE, self.lostAndFoundPostCell.id)
            }
        }
        self.postDetailTableView.reloadData()
    }
    
    func returnTap(_ sender: UITapGestureRecognizer) {
        if self.isNormal == false {
            self.delegate?.returnLikeAndCommentData(isLiked: self.lostAndFoundPostCell.isLiked, likeAmount: self.lostAndFoundPostCell.pround_count, commentAmount: self.lostAndFoundPostCell.comment_count, cellLines: self.cellLindes, module: self.module)
        } else {
            self.delegate?.returnLikeAndCommentData(isLiked: self.postCell.isLiked, likeAmount: self.postCell.pround_count, commentAmount: self.postCell.comment_count, cellLines: self.cellLindes, module: self.module)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// MARK: - 反向传值
protocol PostDetailViewControllerDelegate {
    func returnLikeAndCommentData(isLiked: Int, likeAmount: Int, commentAmount: Int, cellLines: Int, module: Int)
}
