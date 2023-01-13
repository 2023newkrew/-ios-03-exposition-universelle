//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private enum Text {
        static let visitor = "방문객 : "
        static let personnel = " 명"
        static let unfoundPersonnel = "-"
        static let place = "개최지 : "
        static let period = "개최기간 : "
        static let seeEntries = "한국의 출품작 보러가기"
        static let poster = "poster"
        static let flag = "flag"
        static let mainAssetName = "exposition_universelle_1900"
        static let navigationControllerTitle = "메인"
    }
    
    @IBAction private func entryButtonDidTap(_ sender: Any) {
        self.presentEntryListViewController()
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleImageView: UIImageView!
    @IBOutlet private weak var visitorLabel: UILabel!
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var periodLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var leftFlageImageView: UIImageView!
    @IBOutlet private weak var seeEntriesButton: UIButton!
    @IBOutlet private weak var rightFlagImageView: UIImageView!
    
    private let expositionService: ExpositionService = ExpositionService()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureController()
    }
}

extension MainViewController {
    private func configureContent() {
        let result = self.expositionService.fetchExpositionIntroductionData()
        switch result {
        case .success(let introduction):
            self.configureObjects(expositionIntoroduction: introduction)
        case .failure(let error):
            print(error)
        }
    }
    
    func configureObjects(expositionIntoroduction: ExpositionIntroduction) {
        self.titleLabel.text = expositionIntoroduction.title
        self.titleImageView.image = UIImage(named: Text.poster)
        self.visitorLabel.text = Text.visitor + (expositionIntoroduction.visitors.decimalExpression ?? Text.unfoundPersonnel) + Text.personnel
        self.placeLabel.text = Text.place +  expositionIntoroduction.location
        self.periodLabel.text = Text.period + expositionIntoroduction.duration
        self.descriptionTextView.text = expositionIntoroduction.description
        
        self.leftFlageImageView.image = UIImage(named: Text.flag)
        self.seeEntriesButton.setTitle(Text.seeEntries, for: .normal)
        self.rightFlagImageView.image = UIImage(named: Text.flag)
    }
    
    private func configureController() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.title = Text.navigationControllerTitle
    }
    
    private func presentEntryListViewController() {
        let entryListViewController = EntryListViewController()
        self.navigationController?.pushViewController(entryListViewController, animated: true)
    }
}
