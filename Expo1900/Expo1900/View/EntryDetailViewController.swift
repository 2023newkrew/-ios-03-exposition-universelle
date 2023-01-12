//
//  EntryDetailViewController.swift
//  Expo1900
//
//  Created by kakao on 2023/01/10.
//

import UIKit

class EntryDetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
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
            self.imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureController() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .white
        
    }
    
    func configureContent(with item: ExpositionItem) {
        self.navigationItem.title = item.name
        self.imageView.image = UIImage(named: item.imageName)
        self.descriptionTextView.text = item.description
    }
}
