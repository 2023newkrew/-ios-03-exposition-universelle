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
    
    private lazy var bottomTapStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private lazy var bottomLeftFlagImageView = {
        let imageView = UIImageView(image: UIImage(named: "flag"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var bottomCenterButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("한국의 출품작 보러가기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    private lazy var bottomRightFlagImageView = {
        let imageView = UIImageView(image: UIImage(named: "flag"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var expositionUniverselle: ExpositionUniverselle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setLayout()
        setAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        loadJson()
        applyData()
    }
    
    private func setHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        [bottomLeftFlagImageView, bottomCenterButton, bottomRightFlagImageView]
            .forEach { subView in
                bottomTapStackView.addArrangedSubview(subView)
            }
        
        [titleLabel, imageView, visitorLabel,
         locationLabel, durationLabel, descriptionLabel, bottomTapStackView]
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
        
        imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true
        
        bottomRightFlagImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bottomRightFlagImageView.heightAnchor.constraint(equalTo: bottomRightFlagImageView.widthAnchor, multiplier: 2/3).isActive = true
        bottomLeftFlagImageView.widthAnchor.constraint(equalTo: bottomRightFlagImageView.widthAnchor).isActive = true
        bottomLeftFlagImageView.heightAnchor.constraint(equalTo: bottomLeftFlagImageView.widthAnchor, multiplier: 2/3).isActive = true
    }
    
    private func setAttribute() {
//        self.navigationController?.navigationBar.topItem?.title = "메인"
        self.title = "메인"
        
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        descriptionLabel.numberOfLines = 0
        
        bottomCenterButton.addTarget(self, action: #selector(presentKoreanExposition), for: .touchUpInside)
    }
    
    private func loadJson() {
        guard let json = NSDataAsset(name: "exposition_universelle_1900") else {
            return
        }
        let data = json.data
        do {
            self.expositionUniverselle = try JSONDecoder()
                .decode(ExpositionUniverselle.self, from: data)
        }
        catch {
            print(error.localizedDescription)
            return
        }
    }
    
    private func applyData() {
        guard let expositionData = self.expositionUniverselle else {
            return
        }
        
        titleLabel.text = expositionData.title
        imageView.image = UIImage(named: "poster")
        
        let visitorText = NSMutableAttributedString(string: "방문객 : ")
            .applyFont(.title3) + NSMutableAttributedString(string: "\(expositionData.visitors) 명")
            .applyFont(.body)
        let locationText = NSMutableAttributedString(string: "개최지 : ")
            .applyFont(.title3) + NSMutableAttributedString(string: expositionData.location)
            .applyFont(.body)
        let durationText = NSMutableAttributedString(string: "개최 기간 : ")
            .applyFont(.title3) + NSMutableAttributedString(string: expositionData.duration)
            .applyFont(.body)
        let descriptionText = NSMutableAttributedString(string: expositionData.description)
            .applyFont(.body)
        
        visitorLabel.attributedText = visitorText
        locationLabel.attributedText = locationText
        durationLabel.attributedText = durationText
        descriptionLabel.attributedText = descriptionText
    }
    
    @objc private func presentKoreanExposition(){
        let vc = KoreanExpositionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NSAttributedString {
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let mutableString = NSMutableAttributedString()
        mutableString.append(lhs)
        mutableString.append(rhs)
        return mutableString
    }
}

extension NSMutableAttributedString {
    func applyFont(_ font: UIFont.TextStyle) -> NSAttributedString {
        let range = NSRange(location: 0, length: self.string.count)
        self.addAttribute(.font,
                          value: UIFont.preferredFont(forTextStyle: font),
                          range: range)
        return self
    }
    
}
