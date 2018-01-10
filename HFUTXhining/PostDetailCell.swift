//
//  PostDetailCell.swift
//  HFUTXhining
//
//  Created by   chironyf on 16/09/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit

class PostDetailCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var userHeadImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userPostTime: UILabel!
    
    @IBOutlet weak var userPostContent: UILabel!
    
    @IBOutlet weak var userImgsCollection: UICollectionView!
    
    
    @IBOutlet weak var userLikeImg: UIImageView!
    
    
    @IBOutlet weak var userLikeAmount: UILabel!
    
    
    @IBOutlet weak var userCommentImg: UIImageView!
    
    
    @IBOutlet weak var userCommentAmount: UILabel!
    
    @IBOutlet weak var userImgsCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var userTopLine: UIView!
    
    @IBOutlet weak var userBottomLine: UIView!
    
    //cell中的图片URL集合, 对外的接口
    var imgURLSet: Array<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userName.textColor = BLACK_COLOR
        self.userName.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        self.userPostTime.textColor = TIME_COLOR
        self.userLikeAmount.textColor = SEC_BLACK_COLOR
        self.userCommentAmount.textColor = SEC_BLACK_COLOR
        self.userPostContent.textColor = BLACK_COLOR
        self.userTopLine.backgroundColor = CELL_TOP_LINE_COLOR
        self.userBottomLine.backgroundColor = CELL_TOP_LINE_COLOR
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        //设置代理和数据源
        self.userImgsCollection.delegate = self
        self.userImgsCollection.dataSource = self
        
        let cellNib = UINib(nibName: "CommonCollectionCell", bundle: nil)
        userImgsCollection.register(cellNib, forCellWithReuseIdentifier: CellIdentifier.commonCollectionCell)
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
        return CGSize(width: (SCREEN_RECT.width - 20.0), height: (SCREEN_RECT.width - 20.0))
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.commonCollectionCell, for: indexPath) as! CommonCollectionCell
        
        print("++++++collectionView Cell img URL = \(imgURLSet[indexPath.row])")
        
        let url = URL(string: imgURLSet[indexPath.row])
        cell.img.contentMode = .scaleAspectFill
        cell.img.kf.setImage(with: url, placeholder: UIImage(named: "占位图.png"), options: nil, progressBlock: nil, completionHandler: nil)
        print("第\(indexPath.row)个collectionView Cell 创建")
        return cell
    }
    
    func reloadData(setImgURLSet imgURLSetNew: Array<String>) {
        self.imgURLSet = imgURLSetNew
        print("reloadData called")
        //collectionView重新加载数据
        self.userImgsCollection.reloadData()
        //设置图片区高度自适应
        let contentSize = self.userImgsCollection.collectionViewLayout.collectionViewContentSize
        userImgsCollectionViewHeight.constant = contentSize.height
        self.userImgsCollection.reloadData()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
