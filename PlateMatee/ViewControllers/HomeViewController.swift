//
//  HomeViewController.swift
//  PlateMatee
//
//  Created by Chernokoz on 18.04.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let collectionView: UICollectionView
    private let filtersCollectionView: UICollectionView
    private let filters = ["Ingredients", "Meal Type", "Cuisine", "Cook Time"]
    private var selectedFilterIndex = 0
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let itemWidth = (UIScreen.main.bounds.width - 48) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let filtersLayout = UICollectionViewFlowLayout()
        filtersLayout.scrollDirection = .horizontal
        filtersLayout.minimumInteritemSpacing = 12
        filtersLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        filtersLayout.itemSize = CGSize(width: 100, height: 36)
        
        filtersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filtersLayout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "PlateMate"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup search bar
        searchBar.placeholder = "What would you like to cook today?"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        
        // Setup filters collection view
        filtersCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        filtersCollectionView.showsHorizontalScrollIndicator = false
        filtersCollectionView.backgroundColor = .clear
        
        // Setup recipes collection view
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        // Layout
        let stackView = UIStackView(arrangedSubviews: [searchBar, filtersCollectionView, collectionView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            filtersCollectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.collectionView ? 6 : filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as! RecipeCell
            cell.configure()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
            cell.configure(with: filters[indexPath.item], isSelected: selectedFilterIndex == indexPath.item)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != self.collectionView {
            selectedFilterIndex = indexPath.item
            collectionView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Handle search
    }
}

// MARK: - FilterCell
class FilterCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layer.cornerRadius = 18
    }
    
    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        contentView.backgroundColor = isSelected ? .black : .systemGray6
        titleLabel.textColor = isSelected ? .white : .black
    }
}
