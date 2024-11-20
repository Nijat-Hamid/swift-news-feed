//
//  UITextField+Extension.swift
//  news-feed
//
//  Created by Nijat Hamid on 11/20/24.
//  Copyright © 2024 Nijat Hamid. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable
    var placeholderColor: UIColor? {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        }
        set {
            guard let placeholderText = placeholder else { return }
            attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [.foregroundColor: newValue ?? UIColor.lightGray]
            )
        }
    }
}
