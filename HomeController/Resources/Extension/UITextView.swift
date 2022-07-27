//
//  UITextField.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import Foundation
import UIKit

extension UITextView {
    func styleTextView(texts: String) {
        text = texts
        font = UIFont.boldSystemFont(ofSize: 18)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        backgroundColor = .lightGray
        isEditable = false
        isScrollEnabled = false
    }
}

