//
//  KoreanExpositionViewController.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

class KoreanExpositionViewController: UIViewController {
    private var expositionTableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private var expositionItems: [ExpositionItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    
        self.setAttribute()
        self.setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        self.loadJson()
    }
    
    private func setLayout() {
        expositionTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        expositionTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        expositionTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        expositionTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setAttribute() {
        self.title = "한국의 출품작"
        
        self.view.addSubview(expositionTableView)
        self.expositionTableView.delegate = self
        self.expositionTableView.dataSource = self
    }
    
    private func loadJson() {
        guard let json = NSDataAsset(name: "items") else {
            return
        }
        let data = json.data
        do {
            self.expositionItems = try JSONDecoder()
                .decode([ExpositionItem].self, from: data)
        }
        catch {
            print(error.localizedDescription)
            return
        }
    }

}

extension KoreanExpositionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expositionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = expositionItems[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(named: item.imageName)
        content.imageProperties.maximumSize.height = 70
        content.imageProperties.maximumSize.width = 70
        content.imageProperties.reservedLayoutSize.width = 70

        content.attributedText = NSMutableAttributedString(string: item.name)
            .applyFont(.title1)
        content.secondaryAttributedText = NSMutableAttributedString(string: item.shortDescription)
            .applyFont(.body)
        cell.contentConfiguration = content
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
