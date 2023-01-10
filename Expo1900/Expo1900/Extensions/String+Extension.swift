//
//  String+Extension.swift
//  Expo1900
//
//  Created by kakao on 2023/01/10.
//

import Foundation

extension String {
    var exposition: String {
        let sepa = self.split(separator: "(").map { String($0) }
        if sepa.count != 2 { return self }
        return sepa[0] + "\n(" + sepa[1]
    }
}
