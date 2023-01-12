//
//  Int+Extension.swift
//  Expo1900
//
//  Created by kakao on 2023/01/12.
//

import Foundation

extension Int {
    var decimalExpression: String? {
        guard let decimal = NumberFormatter.decimal.string(from: self as NSNumber) else { return nil }
        return decimal
    }
}
