//
//  EntryListViewController.swift
//  Expo1900
//
//  Created by kakao on 2023/01/10.
//

import UIKit

final class EntryListViewController: UIViewController {
    private enum Text {
        static let navigationControllerName = "한국의 출품작"
        static let cellName = "cell"
    }
    
    private let entryListTableView: UITableView = UITableView()
    private var items: [ExpositionItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureController()
        self.configureContent()
        self.configureHierarchy()
        self.configureConstraints()
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.entryListTableView.reloadData()
    }
    
    private func configureController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = .white
        self.title = Text.navigationControllerName
    }
    
    private func configureContent() {
        let result = ExpositionService.shared.fetchExpositionItemsData()
        switch result {
        case .success(let success):
            self.items = success
        case .failure(let failure):
            print(failure)
        }
    }

    private func configureHierarchy() {
        self.view.addSubview(self.entryListTableView)
    }
    
    private func configureConstraints() {
        self.entryListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.entryListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.entryListTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.entryListTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.entryListTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureTableView() {
        self.entryListTableView.delegate = self
        self.entryListTableView.dataSource = self
        self.entryListTableView.register(EntryTableViewCell.self, forCellReuseIdentifier: Text.cellName)
    }
}

extension EntryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Text.cellName) as? EntryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureContent(with: self.items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entryDetailViewController = EntryDetailViewController()
        entryDetailViewController.configureContent(with: items[indexPath.row])
        self.navigationController?.pushViewController(entryDetailViewController, animated: true)
    }
}

