//
//  BaseViewController.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/26/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

     lazy var progress:UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView()
        progress.hidesWhenStopped = true
        progress.color = .brandLight
        progress.style = .large
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(progress)
        NSLayoutConstraint.activate([
            progress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progress.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
