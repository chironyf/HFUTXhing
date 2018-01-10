//
//  DaliyTableViewCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/18.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DaliyTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    //用户头像
    @IBOutlet weak var userHeadImage: UIImageView!
    //用户昵称
    @IBOutlet weak var userNameLabel: UILabel!
    //用户发帖时间
    @IBOutlet weak var userPostTime: UILabel!
    //用户发帖内容
    @IBOutlet weak var userPostContent: UILabel!
    //用户上传的图片
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    //功能区，包括点赞、评论、转发和分享
    @IBOutlet weak var userFunctionArea: UIView!
    
    //点赞
    @IBOutlet weak var userLikeArea: UIView!
    
    @IBOutlet weak var userLikeImage: UIImageView!
    
    @IBOutlet weak var userLikeAmount: UILabel!
    
    //评论
    @IBOutlet weak var userCommentArea: UIView!
    
    @IBOutlet weak var userCommentImage: UIImageView!
    
    @IBOutlet weak var userCommentAmount: UILabel!

    @IBOutlet weak var userTopLine: UIView!
    
    @IBOutlet weak var userImagesCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var userImagesCollectionViewWidth: NSLayoutConstraint!
    //标识是否点赞
    var liked: Bool = false
    
    //cell中的图片URL集合, 对外的接口
    var imgURLSet: Array<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        
        self.userNameLabel.textColor = BLACK_COLOR
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        self.userPostTime.textColor = TIME_COLOR
        
        self.userLikeAmount.textColor = SEC_BLACK_COLOR
        self.userCommentAmount.textColor = SEC_BLACK_COLOR
        
        self.userPostContent.textColor = BLACK_COLOR
        
        let functionAreaTopLine = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_RECT.width, height: 2))
        functionAreaTopLine.backgroundColor = CELL_TOP_LINE_COLOR
        self.userFunctionArea.addSubview(functionAreaTopLine)
        
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        userFunctionArea.backgroundColor = UIColor.clear
        userTopLine.backgroundColor = CELL_TOP_LINE_COLOR
        
//        userHeadImage.isUserInteractionEnabled = true
        
        //设置代理和数据源
        self.userImagesCollectionView.delegate = self
        self.userImagesCollectionView.dataSource = self
        self.userImagesCollectionView.isScrollEnabled = false
        userImagesCollectionViewWidth.constant = SCREEN_RECT.width
        print("~~~~~~~~~~~~看看新的width\(userImagesCollectionViewWidth.constant)")
        
        print("cell的func awakeFromNib() called")
    }

    //实现collectionView的数据源设置，行，列
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView numberOfItemsInSection = \(imgURLSet.count)")
        return imgURLSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.userImagesCollectionView.bounds.width - CGFloat(4.0)) / CGFloat(3.0)
        return CGSize(width: width, height: width)
    }
    
    //同一行的水平边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2.0)
    }
    
    //同一列的竖直边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.communityCollectionCell, for: indexPath) as! CommunityCollectionViewCell
        print("++++++collectionView Cell img URL = \(imgURLSet[indexPath.row])")
        
        let url = URL(string: imgURLSet[indexPath.row])
        cell.communityImage.contentMode = .scaleAspectFill
        cell.clipsToBounds = true
        cell.communityImage.kf.setImage(with: url, placeholder: UIImage(named: "占位图.png"), options: nil, progressBlock: nil, completionHandler: nil)
        
        print("第\(indexPath.row)个collectionView Cell 创建")
        
        if cell.communityImage != nil {
            print("collection cell created")
        }

        return cell
    }
    
    func reloadData(setImgURLSet imgURLSetNew: Array<String>) {
        self.imgURLSet = imgURLSetNew
        print("img reloadData called")
        //collectionView重新加载数据
        
        //设置图片区高度自适应
        
        self.userImagesCollectionView.reloadData()
        
        userImagesCollectionViewWidth.constant = SCREEN_RECT.width
        
        let contentSize = self.userImagesCollectionView.collectionViewLayout.collectionViewContentSize
        userImagesCollectionViewHeight.constant = contentSize.height
        
        print("&&&&&&&&&&&&&&collectionView width = \(contentSize.width)")
        print("&&&&&&&&&&&&&&screen width = \(SCREEN_RECT.width)")
//        self.userImagesCollectionView.reloadData()
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
