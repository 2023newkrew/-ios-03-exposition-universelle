//
//  ExpositionDetailsViewController.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

class ExpositionDetailsViewController: UIViewController {
    private let data: ExpositionItem

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    init(_ data: ExpositionItem) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setLayout()
        setAttribute()
    }
    
    private func setHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        [imageView, descriptionLabel]
            .forEach { subView in
                subView.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(subView)
            }
    }
    
    private func setLayout() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -14).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -28).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setAttribute() {
        view.backgroundColor = .systemBackground
        
        title = data.name
        
        imageView.image = UIImage(named: data.imageName)
        
        descriptionLabel.attributedText = NSMutableAttributedString(string: data.description)
            .applyFont(.body)
    }
}
