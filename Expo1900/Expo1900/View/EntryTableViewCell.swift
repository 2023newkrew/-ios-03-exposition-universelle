//
//  EntryTableViewCell.swift
//  Expo1900
//
//  Created by kakao on 2023/01/10.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    private enum Constant {
        static let numberOfShortDescriptionLabelLines = 0
        static let entryImageViewLeadingDifference = CGFloat(10)
        static let entryImageViewWidth = CGFloat(60)
        static let descriptionStackViewMargin = CGFloat(10)
    }
    
    private let entryImageView: UIImageView = UIImageView(frame: .zero)
    private let descriptionVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = Constant.numberOfShortDescriptionLabelLines
        return label

    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifer: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifer)
        self.configureHierarchy()
        self.configureConstraints()
        self.configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureContent(with item: ExpositionItem) {
        self.entryImageView.image = UIImage(named: "\(item.imageName)")
        self.titleLabel.text = item.name
        self.shortDescriptionLabel.text = item.shortDescription
    }
    
    private func configureCell() {
        self.accessoryType = .disclosureIndicator
    }
    
    private func configureHierarchy() {
        self.contentView.addSubview(self.entryImageView)
        self.contentView.addSubview(self.descriptionVerticalStackView)
 
        self.descriptionVerticalStackView.addArrangedSubview(self.titleLabel)
        self.descriptionVerticalStackView.addArrangedSubview(self.shortDescriptionLabel)
    }
    
    private func configureConstraints() {
        self.entryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.entryImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constant.entryImageViewLeadingDifference),
            self.entryImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.entryImageView.widthAnchor.constraint(equalToConstant: Constant.entryImageViewWidth),
            self.entryImageView.heightAnchor.constraint(equalTo: self.entryImageView.widthAnchor),
            self.descriptionVerticalStackView.leadingAnchor.constraint(equalTo: self.entryImageView.trailingAnchor, constant: Constant.descriptionStackViewMargin),
            self.descriptionVerticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constant.descriptionStackViewMargin),
            self.descriptionVerticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constant.descriptionStackViewMargin),
            self.descriptionVerticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constant.descriptionStackViewMargin)
        ])
    }
}
