//
//  Poptransition.swift
//  HFUTXhining
//
//  Created by   chironyf on 02/10/2017.
//  Copyright © 2017 chironyf. All rights reserved.
//

import UIKit

// MARK: - 实现帖子详情页跳转动画
class Poptransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.5
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 容器视图
        let containerView = transitionContext.containerView
        // 得到toViewController
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        // 得到fromViewController
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        // 将toViewController.view 放到fromViewController.view之上
        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        // 对toViewController.view 进行动画操作
//        toViewController.view.transform = CGAffineTransform(translationX: LGJWidth, y: LGJHeight)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1.0
        }, completion: { (completion) in
            // 转场完成后 transitionWasCancelled
            transitionContext.completeTransition(true)
        })
    }
}
