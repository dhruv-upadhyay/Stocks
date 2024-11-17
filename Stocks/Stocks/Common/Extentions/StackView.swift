//
//  StackView.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 17/11/24.
//

import Foundation
import UIKit

extension UIStackView {
    func addAddArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview(view)
        }
    }
}
