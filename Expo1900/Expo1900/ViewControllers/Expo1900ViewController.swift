//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class Expo1900ViewController: UIViewController {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let visitorLabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let locationLabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let durationLabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private let bottomStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private let koreanFlagOnLeft = {
        let imageView = UIImageView(image: UIImage(named: "flag"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let seeKoreanExpositionButton = {
        let button = UIButton()
    
        button.setTitle("한국의 출품작 보러가기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        return button
    }()
    private let koreanFlagOnRight = {
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.mainRotateLock = true
        navigationController?.isNavigationBarHidden = true
        loadJson()
        applyData()
    }
    
    private func setHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        [koreanFlagOnLeft, seeKoreanExpositionButton, koreanFlagOnRight]
            .forEach { subView in
                bottomStackView.addArrangedSubview(subView)
            }
        
        [titleLabel, imageView, visitorLabel,
         locationLabel, durationLabel, descriptionLabel, bottomStackView]
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
        
        koreanFlagOnRight.widthAnchor.constraint(equalToConstant: 50).isActive = true
        koreanFlagOnRight.heightAnchor.constraint(equalTo: koreanFlagOnRight.widthAnchor, multiplier: 2/3).isActive = true
        koreanFlagOnLeft.widthAnchor.constraint(equalTo: koreanFlagOnRight.widthAnchor).isActive = true
        koreanFlagOnLeft.heightAnchor.constraint(equalTo: koreanFlagOnLeft.widthAnchor, multiplier: 2/3).isActive = true
    }
    
    private func setAttribute() {
        title = "메인"
        
        seeKoreanExpositionButton.addTarget(self, action: #selector(presentKoreanExposition), for: .touchUpInside)
    }
    
    private func loadJson() {
        guard let json = NSDataAsset(name: "exposition_universelle_1900") else {
            return
        }
        let data = json.data
        do {
            expositionUniverselle = try JSONDecoder()
                .decode(ExpositionUniverselle.self, from: data)
        }
        catch {
            print(error.localizedDescription)
            return
        }
    }
    
    private func applyData() {
        guard let expositionData = expositionUniverselle else {
            return
        }
        
        titleLabel.text = expositionData.title.expositionTitle
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
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension String {
    var expositionTitle: String {
        let sepa = self.split(separator: "(").map { String($0) }
        if sepa.count != 2 { return self }
        return sepa[0] + "\n(" + sepa[1]
    }
}
