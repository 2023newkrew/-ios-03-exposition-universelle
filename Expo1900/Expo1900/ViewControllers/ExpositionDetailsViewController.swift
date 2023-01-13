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
        setAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.landscapeRotateLock = false
    }
    
    override func viewWillLayoutSubviews() {
        clearHierarchy()
        switch UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
        case true:
            setHierarchyForLandscape()
            setLayoutForLandscape()
        case false:
            setHierarchyForPortrait()
            setLayoutForPortrait()
        }
    }
    
    private func clearHierarchy() {
        view.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        scrollView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        stackView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    private func setHierarchyForPortrait() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        [imageView, descriptionLabel]
            .forEach { subView in
                subView.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(subView)
            }
    }
    
    private func setHierarchyForLandscape() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setLayoutForPortrait() {
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
    
    private func setLayoutForLandscape() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -14).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7, constant: -28).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
    }
    
    private func setAttribute() {
        view.backgroundColor = .systemBackground
        
        title = data.name
        
        imageView.image = UIImage(named: data.imageName)
        
        descriptionLabel.attributedText = NSMutableAttributedString(string: data.description)
            .applyFont(.body)
    }
}
