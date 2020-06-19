//
//  UITextField+DoneCancelToolbar.swift
//  WaxUtilities
//
//  Created by Bill Weatherwax on 2/17/20.
//  Copyright © 2020 waxcruz. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    public func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

//        let toolbar: UIToolbar = UIToolbar()
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0,
        y: 0,
        width: 100,
        height: 100))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc public func doneButtonTapped() { self.resignFirstResponder() }
    @objc public func cancelButtonTapped() { self.resignFirstResponder() }
}
