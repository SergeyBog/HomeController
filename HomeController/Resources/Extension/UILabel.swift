//
//  UILabel.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 24.07.2022.
//

import Foundation
import UIKit

extension UILabel {
    func styleLabel(sized: CGFloat, weights: UIFont.Weight, amountOfLines: Int) {
        font = .systemFont(ofSize: sized, weight: weights)
        numberOfLines = amountOfLines
    }
}
