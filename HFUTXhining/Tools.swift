//
//  Tools.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/21.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Tools {
    //用于两个颜色之间的过渡，value值从0 - 1
    static func gapColor(startColor: UIColor, endColor: UIColor, value: CGFloat) -> UIColor {
        let gapRed = CIColor(color: endColor).red - CIColor(color: startColor).red
        let gapGreen = CIColor(color: endColor).green - CIColor(color: startColor).green
        let gapBlue = CIColor(color: endColor).blue - CIColor(color: startColor).blue
        let gapAlpha = CIColor(color: endColor).alpha - CIColor(color: startColor).alpha
        
        let currentRed = CIColor(color: startColor).red + gapRed * value
        let currentGreen = CIColor(color: startColor).green + gapGreen * value
        let currentBlue = CIColor(color: startColor).blue + gapBlue * value
        let currentAlpha = CIColor(color: startColor).alpha + gapAlpha * value
        
        let currentColor = UIColor(red: currentRed, green: currentGreen, blue: currentBlue, alpha: currentAlpha)
        return currentColor
    }
    
    //core Data 方便获取context
    static func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    //存储UserInfo
    static func storeUserInfo(userID: String, userName: String, userPassword: String){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: context)
        
        let userInfo = NSManagedObject(entity: entity!, insertInto: context)
        
        userInfo.setValue(userID, forKey: "userID")
        userInfo.setValue(userName, forKey: "userName")
        userInfo.setValue(userPassword, forKey: "userPassword")
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }

}
