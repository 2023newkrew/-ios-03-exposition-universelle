//
//  DynamicTitleButton.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/13.
//

import UIKit

class DynamicTitleButton: UIButton {

    override var intrinsicContentSize: CGSize {
        print("intrinsicContentSize")
        guard let label = self.titleLabel else {
            return CGSize()
        }
        return label.sizeThatFits(CGSize(width: label.preferredMaxLayoutWidth, height: .greatestFiniteMagnitude))
    }

    override func layoutSubviews() {
        print("layoutSubviews")
        self.titleLabel?.preferredMaxLayoutWidth = self.frame.size.width
        super.layoutSubviews()
    }
    
    init(string: String, font: UIFont.TextStyle) {
        super.init(frame: CGRect())
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(UIColor.systemBlue, for: .normal)
        setAttributedTitle(NSMutableAttributedString(string: string)
            .applyFont(font), for: .normal)
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontForContentSizeCategory = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
