//
//  TabBarCustomTransition.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/19/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

class SlideUpTransition: NSObject,UIViewControllerAnimatedTransitioning {
    let transitionDuration: TimeInterval
    
    init(duration:TimeInterval) {
        self.transitionDuration = duration
    }
    
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard
            let toView = transitionContext.viewController(forKey: .to),
            let fromView = transitionContext.viewController(forKey: .from)
        else {return}
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView.view)
        
        let initialFrameFrom = transitionContext.initialFrame(for: fromView)
        
        var initialFrameTo = initialFrameFrom
        initialFrameTo.origin.y = containerView.bounds.maxY
            
        var finalFrameFrom = initialFrameFrom
        finalFrameFrom.origin.y = -containerView.bounds.height
                
        let finalFrameTo = initialFrameFrom
            
        toView.view.frame = initialFrameTo
                
        UIView.animate(withDuration: transitionDuration){
            fromView.view.frame = finalFrameFrom
            toView.view.frame = finalFrameTo
         } completion: { finished in
             transitionContext.completeTransition(finished)
            }
        }
    }
    
