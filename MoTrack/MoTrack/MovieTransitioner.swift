//
//  MovieTransitioner.swift
//  MoTrack
//
//  Created by Arinjay Sharma on 1/22/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit

class MovieAnimatedTransitioning:NSObject, UIViewControllerAnimatedTransitioning {

    var isPresentation = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC!.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC!.view
        
        let containerView = transitionContext.containerView
        
        if isPresentation {
            containerView.addSubview(toView!)
        }
        
        let animatingVC = isPresentation ? toVC : fromVC
        
        let animatingView = animatingVC!.view
        
        let appearedFrame = transitionContext.finalFrame(for: animatingVC!)
        var dismissedFrame = appearedFrame
        
        dismissedFrame.origin.y += dismissedFrame.size.height
        
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        
        animatingView?.frame = initialFrame
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300, initialSpringVelocity: 5, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            animatingView?.frame = finalFrame
            
            if !self.isPresentation {
                animatingView?.alpha = 0
            }
            
        }) { (success:Bool) in
            if !self.isPresentation {
                fromView?.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        }
        
    }

    
}
