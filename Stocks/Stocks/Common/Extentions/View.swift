//
//  View.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func addSubviews(_ listofViews: [UIView]) -> Self {
        for view in listofViews {
            self.addSubview(view)
        }
        return self
    }
        
    func addConstraints(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
