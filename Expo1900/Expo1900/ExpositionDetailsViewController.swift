//
//  ExpositionDetailsViewController.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

class ExpositionDetailsViewController: UIViewController {
    var data: ExpositionItem?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var imageView = UIImageView()
    private lazy var descriptionLabel = UILabel()
    
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
        self.view.backgroundColor = .systemBackground
        
        guard let data = self.data else {
            return
        }
        
        self.title = data.name
        
        imageView.image = UIImage(named: data.imageName)
        imageView.contentMode = .scaleAspectFit
        
        descriptionLabel.attributedText = NSMutableAttributedString(string: data.description)
            .applyFont(.body)
        descriptionLabel.numberOfLines = 0
    }
}
