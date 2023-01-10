//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    enum Text {
        static let visitor = "방문객 : "
        static let place = "개최지 : "
        static let period = "개최기간 : "
        static let seeEntries = "한국의 출품작 보러가기"
        
        static let poster = "poster"
        static let flag = "flag"
        static let mainAssetName = "exposition_universelle_1900"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var visitorLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var leftFlageImageView: UIImageView!
    @IBOutlet weak var seeEntriesButton: UIButton!
    @IBOutlet weak var rightFlagImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
}

extension MainViewController {
    func configure() {
        let expositionIntroduction = fetchExpositionIntroductionData()
        switch expositionIntroduction {
        case .success(let result):
            configureObjects(expositionIntoroduction: result)
        case .failure(let error):
            print(error)
        }
    }
    
    func configureObjects(expositionIntoroduction: ExpositionIntroduction) {
        self.titleLabel.text = expositionIntoroduction.title
        self.titleImageView.image = UIImage(named: Text.poster)
        self.visitorLabel.text = Text.visitor + String(expositionIntoroduction.visitors)
        self.placeLabel.text = Text.place +  expositionIntoroduction.location
        self.periodLabel.text = Text.period + expositionIntoroduction.duration
        self.descriptionTextView.text = expositionIntoroduction.description
        
        self.leftFlageImageView.image = UIImage(named: Text.flag)
        self.seeEntriesButton.setTitle(Text.seeEntries, for: .normal)
        self.rightFlagImageView.image = UIImage(named: Text.flag)
    }
}

extension MainViewController {
    func fetchExpositionIntroductionData() -> Result<ExpositionIntroduction, DecodingError> {
        guard let data = NSDataAsset(name: Text.mainAssetName)?.data else {
            return .failure(.dataAssetConvertingFailure)
        }
        guard let product = try? JSONDecoder().decode(ExpositionIntroduction.self, from: data) else {
            return .failure(.decodingFailure)
        }
        return .success(product)
    }
}
