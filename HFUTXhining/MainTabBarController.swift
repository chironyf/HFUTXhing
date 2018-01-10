//
//  MainTabBarController.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/24.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let barTitle: Array<String> = ["课表", "社区", "查询"]

        for (index, viewController) in self.viewControllers!.enumerated() {
            let img = UIImage(named: "tab\(index)")?.withRenderingMode(.alwaysOriginal)
            let ims = UIImage(named: "tabs\(index)")?.withRenderingMode(.alwaysOriginal)
            
            
            let tabBarItem = UITabBarItem(title: barTitle[index], image: img, selectedImage: ims)
            self.tabBar.tintColor = RED_COLOR
            self.tabBar.unselectedItemTintColor = BLACK_COLOR
            
            
            viewController.tabBarItem = tabBarItem
        }
        // Do any additional setup after loading the view.
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
