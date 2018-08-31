//
//  TransitionManager.swift
//  Project 07 PhotoEffect
//
//  Created by Chris on 31/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning  {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        if let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to){
            
            if let toFilterVC = toVC as? FilterViewController{
                container.addSubview(fromVC.view)
                container.addSubview(toVC.view)
                toFilterVC.view.alpha = 0
                toFilterVC.filter1.transform = CGAffineTransform(translationX: 0, y: -100)
                toFilterVC.filter2.transform = CGAffineTransform(translationX: 0, y: -100)
                toFilterVC.filter3.transform = CGAffineTransform(translationX: 0, y: -200)
                toFilterVC.filter4.transform = CGAffineTransform(translationX: 0, y: -200)
            } else if let fromFilterVC = fromVC as? FilterViewController{
                container.addSubview(toVC.view)
                container.addSubview(fromVC.view)
                fromFilterVC.view.alpha = 1
                fromFilterVC.filter1.transform = CGAffineTransform.identity
                fromFilterVC.filter2.transform = CGAffineTransform.identity
                fromFilterVC.filter3.transform = CGAffineTransform.identity
                fromFilterVC.filter4.transform = CGAffineTransform.identity
            }
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [],
                           animations: {
                            if let toFilterVC = toVC as? FilterViewController{
                                toFilterVC.view.alpha = 1
                                toFilterVC.filter1.transform = CGAffineTransform.identity
                                toFilterVC.filter2.transform = CGAffineTransform.identity
                                toFilterVC.filter3.transform = CGAffineTransform.identity
                                toFilterVC.filter4.transform = CGAffineTransform.identity
                            } else if let fromFilterVC = fromVC as? FilterViewController {
                                fromFilterVC.view.alpha = 0
                                fromFilterVC.filter1.transform = CGAffineTransform(translationX: 0, y: 100)
                                fromFilterVC.filter2.transform = CGAffineTransform(translationX: 0, y: 100)
                                fromFilterVC.filter3.transform = CGAffineTransform(translationX: 0, y: 200)
                                fromFilterVC.filter4.transform = CGAffineTransform(translationX: 0, y: 200)
                            }
            },
                           completion: {finish in
                            transitionContext.completeTransition(true)
                            UIApplication.shared.keyWindow?.addSubview(toVC.view)
            })
        }
    }
}
