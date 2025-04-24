//
//  CartViewController.swift
//  PlateMatee
//
//  Created by Chernokoz on 18.04.2025.
//

import UIKit

class CartViewController: UIViewController {
    
    private let segmentedControl = UISegmentedControl(items: ["Grocery", "My Pantry"])
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var sections = [
        ListSection(title: "Meat & Seafood", items: ["Squid"]),
        ListSection(title: "Herbs & Spices", items: ["Ground Coriander", "Dried Oregano", "Paprika"]),
        ListSection(title: "Fruits & Vegetables", items: ["Lemons"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup segmented control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = .black
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }
        
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        // Layout
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        // Switch between grocery and pantry lists
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = sections[indexPath.section].items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item
        cell.contentConfiguration = content
        
        // Add checkbox accessory
        let checkbox = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        checkbox.setImage(UIImage(systemName: "square"), for: .normal)
        checkbox.tintColor = .systemGray
        cell.accessoryView = checkbox
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}

// MARK: - UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Toggle checkbox
        if let cell = tableView.cellForRow(at: indexPath),
           let checkbox = cell.accessoryView as? UIButton {
            let isChecked = checkbox.currentImage == UIImage(systemName: "checkmark.square.fill")
            checkbox.setImage(UIImage(systemName: isChecked ? "square" : "checkmark.square.fill"), for: .normal)
        }
    }
}

