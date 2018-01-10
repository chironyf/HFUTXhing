//
//  CurriculumViewController.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/26.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ZLPhotoBrowser
import SpreadsheetView

class CurriculumViewController: UIViewController, SpreadsheetViewDataSource {
    
    @IBOutlet weak var curriculumView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cv = SpreadsheetView(frame: curriculumView.frame)
        cv.dataSource = self
        cv.gridStyle = .solid(width: 1, color: SEC_BLACK_COLOR)
        curriculumView.clipsToBounds = true
        curriculumView.addSubview(cv)
        // Do any additional setup after loading the view.
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 8
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 12
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return self.curriculumView.frame.width / 8
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return self.curriculumView.frame.height / 12
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
//    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
//        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.communityCollectionCell, for: indexPath) as! CommunityCollectionViewCell
//        let view = Cell(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
//        view.backgroundColor = RED_COLOR
//        return view
//    }

    func curriculumTap(_ sender: UITapGestureRecognizer) {
        
        let parameters: Parameters = [
            "student_id": student_id,
            "password": psw
        ]
        
        Alamofire.request(CURRICULUM, method: .post, parameters: parameters).responseJSON {
            response in
            guard let dataStream = response.data else {
                print("网络请求失败")
                return
            }
            let json = JSON(data: dataStream)
            print(json)

        }
    }
    
    func test(_ sender: UITapGestureRecognizer) {
        let ac = ZLPhotoActionSheet()
        ac.maxPreviewCount = 20
        ac.maxSelectCount = 9
        ac.sender = self
        ac.selectImageBlock = {(_ images: [UIImage], assets: [PHAsset], isOriginal: Bool) -> Void in
            for img in images {
                print("iiiiiiiiiiiimmmmmmmmmmmmmgggggggggggg: \(img)")
            }
        }
        ac.showPreview(animated: true, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
