//
//  MoviePresentationController.swift
//  MoTrack
//
//  Created by Arinjay Sharma on 1/22/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit

class MoviePresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {

    var dimmingView = UIView()
    
    override var shouldPresentInFullscreen: Bool{
        return true
    }
    
    init(presenetedViewController: UIViewController, presenting presentingViewController: UIViewController?){
        super.init(presentedViewController: presenetedViewController, presenting: presentingViewController)
        
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.8)   //white 0-- black  0.8 for shine
        dimmingView.alpha = 0   // invisible initially
        
        
    }
    override func presentationTransitionWillBegin() {
        dimmingView.frame = self.containerView!.bounds
        dimmingView.alpha = 0
        containerView?.insertSubview(dimmingView, at: 0)  // makes the base vc dimmer
        
        if let coordinator = presentedViewController.transitionCoordinator//return active transition cordinator onject 
        {
            coordinator.animate(alongsideTransition: { (context:UIViewControllerTransitionCoordinatorContext) in
            self.dimmingView.alpha = 1
          }, completion: nil)
        }else{
            dimmingView.alpha = 1
        }
    }
    
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context:UIViewControllerTransitionCoordinatorContext) in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }else{
            self.dimmingView.alpha = 0
        }
    }
    
    
    override func containerViewDidLayoutSubviews() {
        if let containerBounds = containerView?.bounds {
            dimmingView.frame = containerBounds
            presentedView?.frame = containerBounds
        }
    }
    
    
    override func adaptivePresentationStyle(for traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .overFullScreen
    }
    
    
}
