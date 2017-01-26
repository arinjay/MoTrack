//
//  MovieTransitioner.swift
//  MoTrack
//
//  Created by Arinjay Sharma on 1/22/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit

class MovieAnimatedTransitioning:NSObject, UIViewControllerAnimatedTransitioning {

    var isPresentation = false   //check if we transitioning the overview or representing it
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {  // time transition will take
        return 0.5
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {     //2 functions for UIViewControllerAnimatedTransitioning
        
        let fromVC = transitionContext.viewController(forKey: .from)    // from and two as we are representing 2 vc
        let fromView = fromVC!.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC!.view
        
        let containerView = transitionContext.containerView   // where above 2 things will be happening (adding 2 vc)
        
        if isPresentation {                                     // if we presenting our overlay or not
            containerView.addSubview(toView!)
        }
        
        let animatingVC = isPresentation ? toVC : fromVC        // which VC is animating
        
        let animatingView = animatingVC!.view
        
        let appearedFrame = transitionContext.finalFrame(for: animatingVC!)
        var dismissedFrame = appearedFrame   // variable
        
        dismissedFrame.origin.y += dismissedFrame.size.height   //adding dismissed frame of same height
        
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame   // if presentation then dismissed frame is initial frame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        
        animatingView?.frame = initialFrame
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300, initialSpringVelocity: 5, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            animatingView?.frame = finalFrame    // setting the animatingview frame to final frame  (always use animating view)
            
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



//creating another class

class MovieTranstionDelegate: NSObject,UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = MoviePresentationController(presenetedViewController: presented, presenting: presenting)
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = MovieAnimatedTransitioning()
        animationController.isPresentation = true
        
        return animationController
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = MovieAnimatedTransitioning()
        animationController.isPresentation = false
        
        return animationController
    }
    
}









