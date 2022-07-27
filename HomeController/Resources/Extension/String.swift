//
//  String.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 26.07.2022.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
