//
//  EntryDetailViewController.swift
//  Expo1900
//
//  Created by kakao on 2023/01/10.
//

import UIKit

class EntryDetailViewController: UIViewController {
    private enum Constant {
        static let horizontalStackViewSpacing = CGFloat(15)
        static let horizontalStackViewDirectionalLayoutMargin = CGFloat(15)
        static let imageViewHeight = CGFloat(150)
    }
    
    private let scrollView = UIScrollView()
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = Constant.horizontalStackViewSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: Constant.horizontalStackViewDirectionalLayoutMargin,
                                                   leading: Constant.horizontalStackViewDirectionalLayoutMargin,
                                                   bottom: Constant.horizontalStackViewDirectionalLayoutMargin,
                                                   trailing: Constant.horizontalStackViewDirectionalLayoutMargin)
        return stackView
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = .zero
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textAlignment = .justified
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureHierarchy()
        self.configureConstraints()
        self.configureController()
    }
    
}

extension EntryDetailViewController {
    func configureContent(with item: ExpositionItem) {
        self.navigationItem.title = item.name
        self.imageView.image = UIImage(named: item.imageName)
        self.descriptionTextView.text = item.description
    }
    
    private func configureHierarchy() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.horizontalStackView)
        self.horizontalStackView.addArrangedSubview(self.imageView)
        self.horizontalStackView.addArrangedSubview(self.descriptionTextView)
    }
    
    private func configureConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.horizontalStackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.horizontalStackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            self.horizontalStackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            self.horizontalStackView.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: Constant.imageViewHeight)
        ])
    }
    
    private func configureController() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .white
        
    }
}
