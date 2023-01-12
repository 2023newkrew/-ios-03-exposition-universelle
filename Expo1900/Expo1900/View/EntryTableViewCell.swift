//
//  EntryTableViewCell.swift
//  Expo1900
//
//  Created by kakao on 2023/01/10.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
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
        label.numberOfLines = 0
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
            self.entryImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.entryImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.entryImageView.widthAnchor.constraint(equalToConstant: 50),
            self.entryImageView.heightAnchor.constraint(equalTo: self.entryImageView.widthAnchor),
            self.descriptionVerticalStackView.leadingAnchor.constraint(equalTo: self.entryImageView.trailingAnchor, constant: 10),
            self.descriptionVerticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.descriptionVerticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.descriptionVerticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
}
