//
//  MainController.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/19/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension MainController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return SlideUpTransition(duration: 0.5)
    }
}
