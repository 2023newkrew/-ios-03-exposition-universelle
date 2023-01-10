//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class Expo1900ViewController: UIViewController {
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
    
    private lazy var titleLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var visitorLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var durationLabel = UILabel()
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
        
        [titleLabel, imageView, visitorLabel,
         locationLabel, durationLabel, descriptionLabel].forEach { subView in
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
        
        imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setAttribute() {
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        descriptionLabel.numberOfLines = 0
    }
}

