//
//  KoreanExpositionViewController.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

class KoreanExpositionViewController: UIViewController {
    private let expositionTableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "expositionCell")
        
        return tableView
    }()
    
    private var expositionItems: [ExpositionItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setHierarchy()
        setAttribute()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.landscapeRotateLock = false
        navigationController?.isNavigationBarHidden = false
        
        loadJson()
    }
    
    private func setHierarchy() {
        view.addSubview(expositionTableView)
    }
    
    private func setLayout() {
        expositionTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        expositionTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        expositionTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        expositionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setAttribute() {
        view.backgroundColor = .systemBackground
        title = "한국의 출품작"
        
        expositionTableView.delegate = self
        expositionTableView.dataSource = self
    }
    
    private func loadJson() {
        guard let json = NSDataAsset(name: "items") else {
            return
        }
        let data = json.data
        do {
            expositionItems = try JSONDecoder()
                .decode([ExpositionItem].self, from: data)
        }
        catch {
            print(error.localizedDescription)
            return
        }
    }

}

extension KoreanExpositionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expositionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expositionCell",
                                                 for: indexPath)
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

extension KoreanExpositionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ExpositionDetailsViewController(expositionItems[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        expositionTableView.deselectRow(at: indexPath, animated: true)
    }
}
