//
//  UIImageView.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func styleImageView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleImageViewWithImage(imageName: String) {
        image = UIImage(named: imageName)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
