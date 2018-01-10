//
//  CommunityViewController.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit
import pop


class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private struct CellIdentifier {
        static let daliyCell = "ReusedDaliyTableViewCell"
        static let confessionCell = "ReusedConfessionTableViewCell"
        static let lostAndFoundCell = "ReusedLostAndFoundTableViewCell"
    }
//    var lineWidth: CGFloat?

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var daliyTableView: UITableView!
    
    @IBOutlet weak var confessionTableView: UITableView!
    
    @IBOutlet weak var lostAndFoundTableView: UITableView!
    
    //导航栏（View代替）

    @IBOutlet weak var daliyLabel: UILabel!

    @IBOutlet weak var confessionLabel: UILabel!
   
    @IBOutlet weak var lostAndFoundLabel: UILabel!
    
    @IBOutlet weak var plateView: UIView!
    //滑动条
    var scrollLine: UIView?
    
    //数据接口
    var daliydatas: [DaliyTableViewCellModel] = daliyData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daliyTableView.delegate = self
        daliyTableView.dataSource = self
        
        scrollView.delegate = self
        

//
//        confessionTableView.delegate = self
//        confessionTableView.dataSource = self
//        
//        lostAndFoundTableView.delegate = self
//        lostAndFoundTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        daliyTableView.backgroundView = UIImageView(image: UIImage(named: "tablebgc.jpg")!)
        daliyTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //设置daliyTable高度自适应
        daliyTableView.estimatedRowHeight = 340
        daliyTableView.rowHeight = UITableViewAutomaticDimension
        
        daliyLabel.textColor = RED_COLOR
        let origin = daliyLabel.frame
        scrollLine = UIView(frame: CGRect(x: origin.midX - origin.width / 2, y: origin.maxY + LABEL_TO_BOTTOM - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT))
        scrollLine!.backgroundColor = RED_COLOR
        plateView.addSubview(scrollLine!)
        print("\(origin.width)")
        print("line width = \(scrollLine!.frame.size.width)")
        //添加手势
        let confessionTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.confessionTap(_:)))
        confessionLabel.isUserInteractionEnabled = true
        confessionLabel.addGestureRecognizer(confessionTapGesture)
        
        let daliyTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.daliyTap(_:)))
        daliyLabel.isUserInteractionEnabled = true
        daliyLabel.addGestureRecognizer(daliyTapGesture)
        
        let lostAndFoundTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.lostAndFoundTap(_:)))
        lostAndFoundLabel.isUserInteractionEnabled = true
        lostAndFoundLabel.addGestureRecognizer(lostAndFoundTapGesture)
    }
    
    
    //顶部标签添加响应动作
    func confessionTap(_ sender: UITapGestureRecognizer) {
        let origin = confessionLabel.frame
        print("___________confession tapped")
        
        scrollView.pop_add(Animation.springPOPScrollViewContentOffset(point: CGPoint(x: SCREEN_RECT.width, y: 0)), forKey: "x")
        
        let newLineFrame = CGRect(x: origin.midX - origin.width / 2, y: origin.maxY + LABEL_TO_BOTTOM - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT)
        
        scrollLine?.pop_add(Animation.springPOPViewFrame(frame: newLineFrame), forKey: "y")
        
        confessionLabel.pop_add(Animation.springPOPLabelTextColor(color: RED_COLOR), forKey: "c")
        
        daliyLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "d")
        
        lostAndFoundLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "l")
    }
    
    func daliyTap(_ sender: UITapGestureRecognizer) {
        let origin = daliyLabel.frame

        scrollView.pop_add(Animation.springPOPScrollViewContentOffset(point: CGPoint(x: 0, y: 0)), forKey: "x2")
        
        let newLineFrame = CGRect(x: origin.midX - origin.width / 2, y: origin.maxY + LABEL_TO_BOTTOM - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT)

        scrollLine?.pop_add(Animation.springPOPViewFrame(frame: newLineFrame), forKey: "y2")

        confessionLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "c2")

        daliyLabel.pop_add(Animation.springPOPLabelTextColor(color: RED_COLOR), forKey: "d2")
        
        lostAndFoundLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "l2")
    }
    
    func lostAndFoundTap(_ sender: UITapGestureRecognizer) {
        let origin = lostAndFoundLabel.frame
        scrollView.pop_add(Animation.springPOPScrollViewContentOffset(point: CGPoint(x: SCREEN_RECT.width * 2, y: 0)), forKey: "x3")
        
        let newLineFrame = CGRect(x: origin.midX - origin.width / 2, y: origin.maxY + LABEL_TO_BOTTOM - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT)
        scrollLine?.pop_add(Animation.springPOPViewFrame(frame: newLineFrame), forKey: "y3")
        
        confessionLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "c3")

        lostAndFoundLabel.pop_add(Animation.springPOPLabelTextColor(color: RED_COLOR), forKey: "l3")
        
        daliyLabel.pop_add(Animation.springPOPLabelTextColor(color: BLACK_COLOR), forKey: "d3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //tableView设置
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(daliydatas.count)
        return daliydatas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch tableView {
//            case
//        }
        if tableView == self.daliyTableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.daliyCell, for: indexPath) as! DaliyTableViewCell
            cell.userHeadImage?.image = UIImage(named: "头像")
            cell.userNameLabel?.text = daliydatas[indexPath.row].userName
            cell.userPostTime?.text = daliydatas[indexPath.row].userPostTime
            cell.userPostContent?.text = daliydatas[indexPath.row].userPostContentURL
            cell.userLikeAmount?.text = "\(daliydatas[indexPath.row].userLikeAmount)"
            cell.userCommentAmount?.text = "\(daliydatas[indexPath.row].userCommentAmount)"
            cell.userForwardAmount?.text = "\(daliydatas[indexPath.row].userForwardAmount)"
            cell.userShareAmount?.text = "\(daliydatas[indexPath.row].userShareAmount)"
            cell.backgroundColor = UIColor.clear
            
            print(daliydatas[indexPath.row].userName)
            print(daliydatas[indexPath.row].userPostTime)
            print(daliydatas[indexPath.row].userPostContentURL)
            return cell
        }
         else if tableView == self.confessionTableView {
            let newCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifier.confessionCell)
            return newCell
        } else {
            let new = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifier.lostAndFoundCell)
            return new
        }
    }
    
    //scrollView 滑动时多次调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let origin = daliyLabel.frame
        //两个滑动之间的长度比例
        let proportion = LINE_WIDTH / SCREEN_RECT.width
        //实现滑动中scrollLine的滑动
        scrollLine?.frame = CGRect(x: origin.minX + scrollView.contentOffset.x * proportion, y: origin.maxY + LABEL_TO_BOTTOM - SCROLL_LINE_HEIGHT, width: LINE_WIDTH, height: SCROLL_LINE_HEIGHT)
        //实现滑动label颜色过渡
        if ((scrollLine?.frame.midX)! > daliyLabel.frame.midX && (scrollLine?.frame.midX)! < confessionLabel.frame.midX) {
            let value = ((scrollLine?.frame.midX)! - daliyLabel.frame.midX) / daliyLabel.frame.width
            daliyLabel.textColor = Tools.gapColor(startColor: RED_COLOR, endColor: BLACK_COLOR, value: value)
            confessionLabel.textColor = Tools.gapColor(startColor: BLACK_COLOR, endColor: RED_COLOR, value: value)
        } else if ((scrollLine?.frame.midX)! > confessionLabel.frame.midX && (scrollLine?.frame.midX)! < lostAndFoundLabel.frame.midX) {
            let value = ((scrollLine?.frame.midX)! - confessionLabel.frame.midX) / daliyLabel.frame.width
            confessionLabel.textColor = Tools.gapColor(startColor: RED_COLOR, endColor: BLACK_COLOR, value: value)
            lostAndFoundLabel.textColor = Tools.gapColor(startColor: BLACK_COLOR, endColor: RED_COLOR, value: value)
        }
    }
}
