//
//  NumberFormatter+Extensions.swift
//  Expo1900
//
//  Created by kakao on 2023/01/12.
//

import Foundation

extension NumberFormatter {
    static let decimal: NumberFormatter = {
        let numberFomatter = NumberFormatter()
        numberFomatter.numberStyle = .decimal
        return numberFomatter
    }()
}
