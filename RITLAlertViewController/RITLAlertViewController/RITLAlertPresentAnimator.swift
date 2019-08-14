//
//  RITLAlertPresentAnimator.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/13.
//  Copyright © 2019 YueWen. All rights reserved.
//

import Foundation
import UIKit

final class RITLAlertPresentAnimator: NSObject,UIViewControllerAnimatedTransitioning  {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        /// 如果不存在，取消即可
        guard let alertController = transitionContext.viewController(forKey: .to) as? RITLAlertController else {
            transitionContext.cancelInteractiveTransition(); return
        }
        
        alertController.backgroundView.alpha = 0
        alertController.alertView.alpha = 0
        alertController.alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(alertController.view)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            
            alertController.backgroundView.alpha = CGFloat(RITLAlertController.defaultBackgrondAlpha)
            alertController.alertView.alpha = 1
            alertController.alertView.transform = .identity
            
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
