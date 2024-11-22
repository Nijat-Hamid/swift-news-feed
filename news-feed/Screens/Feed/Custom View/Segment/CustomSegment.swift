//
//  CustomSegment.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/21/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

protocol CustomSegmentDelegate:AnyObject{
    func didSelect(name:String)
}

class CustomSegment: UIView {

    weak var delegate: CustomSegmentDelegate?
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var backgroundCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundWidth: NSLayoutConstraint!
    
    @IBOutlet var tabLabels: [UILabel]! {
        didSet{
            tabLabels.enumerated().forEach { index,label in
                label.textColor = index == 0 ? .brandLight : .cardText
                let gesture = UITapGestureRecognizer(target: self, action: #selector(tabTapped))
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(gesture)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    @objc private func tabTapped(_ sender: UITapGestureRecognizer) {
           guard let view = sender.view as? UILabel,let tabName = view.text else {return}
           align(to: view)
           delegate?.didSelect(name: tabName)
       }
    
    private func align(to view:UIView){
        backgroundCenterX.isActive = false
        backgroundCenterX = background.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        backgroundCenterX.isActive = true
        
        backgroundWidth.isActive = false
        backgroundWidth = background.widthAnchor.constraint(equalTo: view.widthAnchor)
        backgroundWidth.isActive = true
        
        UIView.transition(with: background, duration: 0.2,options: .curveEaseInOut) { [weak self] in
            guard let self else {return}
            layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let selectedLabel = view as? UILabel,let self else { return }
            tabLabels.forEach { label in
                label.textColor = label == selectedLabel ? .brandLight : .cardText
            }
        }
    }
    
    private func setup(){
        guard let view = Bundle.main.loadNibNamed("CustomSegment", owner: self)?.first as? UIView else {return}
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
