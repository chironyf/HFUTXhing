//
//  Animation.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/20.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import Foundation
import pop

class Animation {
    
    //scrollView动画
    static func springPOPScrollViewContentOffset(point: CGPoint) -> POPAnimation {
        let animation = POPSpringAnimation(propertyNamed: kPOPScrollViewContentOffset)!
        animation.toValue = point
        animation.springBounciness = SPRING_BOUNCE //[0-20] 弹力 越大则震动幅度越大
        animation.springSpeed = SPRING_SPEED //[0-20] 速度 越大则动画结束越快
        return animation
    }
    
    //scrollLine动画
    static func springPOPViewFrame(frame: CGRect) -> POPAnimation {
        let lineAnimation = POPSpringAnimation(propertyNamed: kPOPViewFrame)!
        lineAnimation.toValue = frame
        lineAnimation.springBounciness = SPRING_BOUNCE
        lineAnimation.springSpeed = SPRING_SPEED
        return lineAnimation
    }
    
    //label颜色切换动画
    static func springPOPLabelTextColor(color: UIColor) -> POPAnimation {
        let labelColorAnim = POPSpringAnimation(propertyNamed: kPOPLabelTextColor)!
        labelColorAnim.toValue = color
        labelColorAnim.springBounciness = SPRING_BOUNCE
        labelColorAnim.springSpeed = SPRING_SPEED
        return labelColorAnim
    }
    
    
    
}


