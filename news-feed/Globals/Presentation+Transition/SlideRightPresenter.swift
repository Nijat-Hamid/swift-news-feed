//
//  SlideRightPresenter.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/20/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

class SlideRightPresenter: UIPresentationController {
    
    private lazy var screenSize: CGRect = {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { return .zero }
        return window.bounds
    }()
    
    
    override var frameOfPresentedViewInContainerView: CGRect{
        return .init(x: 0, y: 0, width: screenSize.width * 0.7, height: screenSize.height)
    }
    
    private var initialFrameForPresentedView: CGRect {
        return CGRect(x: -screenSize.width * 0.7, y: 0, width: screenSize.width * 0.7, height: screenSize.height)
    }
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var isDismissing = false
    
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView, let presentedView else {return}
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        containerView.addGestureRecognizer(gesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        presentedView.addGestureRecognizer(panGesture)
        panGestureRecognizer = panGesture
        
        containerView.addSubview(presentedView)
        presentedView.frame = initialFrameForPresentedView
        presentedView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else {return}
            presentedView.frame = frameOfPresentedViewInContainerView
        }
        
    }
    
    @objc private func handlePanGesture(_ gesture:UIPanGestureRecognizer){
        guard let presentedView else { return }
        let translation = gesture.translation(in: presentedView)
        
        switch gesture.state {
        case .changed:
            let newX = min(0, max(-frameOfPresentedViewInContainerView.width, translation.x))
            presentedView.frame.origin.x = newX
        case .ended:
            let velocity = gesture.velocity(in: presentedView).x
            if velocity > 500 || presentedView.frame.origin.x > -frameOfPresentedViewInContainerView.width / 2 {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    guard let self else { return }
                    presentedView.frame = frameOfPresentedViewInContainerView
                }
            } else {
                dismissMenu()
            }
        default:
            break
        }
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: containerView)
        
        guard let presentedView, !presentedView.frame.contains(location), !isDismissing  else { return }
        
        dismissMenu()
    }

    private func dismissMenu() {
        guard let presentedView else { return }
        guard !isDismissing else { return }
        
        isDismissing = true
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            presentedView.frame = initialFrameForPresentedView
        } completion: { [weak self] _ in
            guard let self else { return }
            presentedViewController.dismiss(animated: true)
            isDismissing = false
        }
    }
    
}
