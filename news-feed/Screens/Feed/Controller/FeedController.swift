//
//  FeedController.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/19/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

class FeedController: UIViewController {

        
    @IBAction func menuButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MenuView", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() else {return}
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        present(vc,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
}

extension FeedController:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SlideRightPresenter(presentedViewController: presented, presenting: presenting)
    }
    
    
}
