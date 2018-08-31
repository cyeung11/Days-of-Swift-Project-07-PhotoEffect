//
//  FilterViewController.swift
//  Project 07 PhotoEffect
//
//  Created by Chris on 31/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController{
    
//    var enteringVC = true
    let transitionManager = TransitionManager()
    
    @IBOutlet weak var filter1: UIImageView!
    @IBOutlet weak var filter2: UIImageView!
    @IBOutlet weak var filter3: UIImageView!
    @IBOutlet weak var filter4: UIImageView!
    
    
//    @IBAction func cancel(_ sender: Any) {
//        enteringVC = false
//        dismiss(animated: true, completion: nil)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        transitioningDelegate = transitionManager
    }
    
//    //MARK: Delegate
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//
//    //MARK: Transitioning
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        if let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to){
//
//            container.addSubview(fromVC.view)
//            container.addSubview(toVC.view)
//
//            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [],
//                           animations: {
//                            if let toFilterVC = toVC as? FilterViewController{
////                                fromVC.view.alpha = 0
//                                toFilterVC.filter1.transform = CGAffineTransform.identity
//                                toFilterVC.filter2.transform = CGAffineTransform.identity
//                                toFilterVC.filter3.transform = CGAffineTransform.identity
//                                toFilterVC.filter4.transform = CGAffineTransform.identity
//                            } else if let fromFilterVC = fromVC as? FilterViewController {
////                                fromFilterVC.view.alpha = 0
//                                fromFilterVC.filter1.transform = CGAffineTransform(translationX: -100, y: 0)
//                                fromFilterVC.filter2.transform = CGAffineTransform(translationX: -100, y: 0)
//                                fromFilterVC.filter3.transform = CGAffineTransform(translationX: -200, y: 0)
//                                fromFilterVC.filter4.transform = CGAffineTransform(translationX: -200, y: 0)
//                            }
//            },
//                           completion: {finish in
//                            transitionContext.completeTransition(true)
//                            UIApplication.shared.keyWindow?.addSubview(toVC.view)
//            })
//        }
//    }
}
