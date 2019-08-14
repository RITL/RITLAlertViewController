//
//  RITLAlertDismissAnimator.swift
//  RITLAlertViewController
//
//  Created by YueWen on 2019/8/13.
//  Copyright © 2019 YueWen. All rights reserved.
//

import UIKit

final class RITLAlertDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.15
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromViewController?.view.alpha = 0
            
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
