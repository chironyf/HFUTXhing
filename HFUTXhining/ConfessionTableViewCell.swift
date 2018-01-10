//
//  ConfessionTableViewCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/21.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit

class ConfessionTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource {

    //cell顶部分隔线
    @IBOutlet weak var userTopLine: UIView!
   
    //用户头像
    @IBOutlet weak var userHeadImage: UIImageView!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var userPostTimeLabel: UILabel!
    
    
    @IBOutlet weak var userPostContentLabel: UILabel!
    
    
    @IBOutlet weak var userFunctionArea: UIView!
    
    
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var userLikeImage: UIImageView!
    
    
    @IBOutlet weak var userLikeAmount: UILabel!
    
    
    @IBOutlet weak var userCommentImage: UIImageView!
    
    
    @IBOutlet weak var userCommentAmount: UILabel!
    
    
    @IBOutlet weak var userCollectionViewHeight: NSLayoutConstraint!
    
    //标识是否点赞
    var liked: Bool = false
    
    //cell中的图片URL集合, 对外的接口
    var imgURLSet: Array<String> = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        userFunctionArea.backgroundColor = UIColor.clear
        userTopLine.backgroundColor = CELL_TOP_LINE_COLOR
        
        self.userNameLabel.textColor = BLACK_COLOR
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        self.userPostTimeLabel.textColor = TIME_COLOR
        
        self.userLikeAmount.textColor = SEC_BLACK_COLOR
        self.userCommentAmount.textColor = SEC_BLACK_COLOR
        
        self.userPostContentLabel.textColor = BLACK_COLOR
        //设置代理和数据源
        self.userImagesCollectionView.delegate = self
        self.userImagesCollectionView.dataSource = self
        self.userImagesCollectionView.isScrollEnabled = false
        print("cell的func awakeFromNib() called")
        
        //点赞事件
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeTap(_:)))
        userLikeImage.isUserInteractionEnabled = true
        userLikeImage.addGestureRecognizer(likeTapGesture)
    }
    
    //设置点赞响应事件
    func likeTap(_ sender: UITapGestureRecognizer) {
        if liked == false {
            userLikeImage.image = UIImage(named: "点赞了")
            //            userLikeAmount.text
            liked = true
        } else {
            userLikeImage.image = UIImage(named: "点赞")
            liked = false
        }
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.confessionCollectionCell, for: indexPath) as! ConfessionCollectionViewCell
        print("++++++collectionView Cell img URL = \(imgURLSet[indexPath.row])")
        
        let url = URL(string: imgURLSet[indexPath.row])
        cell.confessionCollectionCellImage.contentMode = .scaleAspectFill
        cell.clipsToBounds = true
        cell.confessionCollectionCellImage.kf.setImage(with: url, placeholder: UIImage(named: "占位图.png"), options: nil, progressBlock: nil, completionHandler: nil)
        print("第\(indexPath.row)个collectionView Cell 创建")
        
        if cell.confessionCollectionCellImage != nil {
            print("collection cell created")
        }
        
        return cell
    }
    
    func reloadData(setImgURLSet imgURLSetNew: Array<String>) {
        self.imgURLSet = imgURLSetNew
        print("reloadData called")
        //collectionView重新加载数据
        self.userImagesCollectionView.reloadData()
        //设置图片区高度自适应
        let contentSize = self.userImagesCollectionView.collectionViewLayout.collectionViewContentSize
        userCollectionViewHeight.constant = contentSize.height
        self.userImagesCollectionView.reloadData()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
