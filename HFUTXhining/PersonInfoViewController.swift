//
//  PersonInfoViewController.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/24.
//  Copyright © 2017年 chironyf. All rights reserved.
//
//个人信息模块

import UIKit
import Alamofire
import SwiftyJSON

class PersonInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var menuHeadBackground: UIView!
    
    @IBOutlet weak var menuHeadImage: UIImageView!
    
    @IBOutlet weak var menuHeadName: UILabel!
    
    @IBOutlet weak var menuTable: UITableView!
    
    var menucelldatas: [MenuTableViewCellModel] = menuCellData
    
    // 菜单打开后主页在屏幕右侧露出部分的宽度
    let menuViewExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTable.delegate = self
        menuTable.dataSource = self
        
        menuTable.separatorStyle = UITableViewCellSeparatorStyle.none
        self.menuHeadName.textColor = SEC_BLACK_COLOR
       
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - MenuCell Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menucelldatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.personInfoCell, for: indexPath) as! PersonInfoTableViewCell
        cell.menuCellImage?.image = menucelldatas[indexPath.row].titleImage
        cell.menuCellTitle?.text = menucelldatas[indexPath.row].title
        return cell
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // 菜单状态枚举
    enum MenuState {
        case Collapsed  // 未显示(收起)
        case Expanding   // 展开中
        case Expanded   // 展开
    }

}
