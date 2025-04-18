//
//  SearchViewController.swift
//  PlateMatee
//
//  Created by Chernokoz on 18.04.2025.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - UI Elements
    private let searchController = UISearchController(searchResultsController: nil)
    private let filterSegmentedControl = UISegmentedControl()
    private let recommendationsLabel = UILabel()
    private let recommendationsCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Data
    private let filters = ["Ingredients", "Meal Type", "Cuisine", "Cook Time"]
    private var recommendations: [String] = ["Pasta", "Salad", "Soup", "Steak", "Sushi"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Search"
        view.backgroundColor = .systemBackground
        
        // Настройка поисковой строки
        searchController.searchBar.placeholder = "Search recipes"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Настройка сегментированного контрола
        filterSegmentedControl.removeAllSegments()
        for (index, filter) in filters.enumerated() {
            filterSegmentedControl.insertSegment(withTitle: filter, at: index, animated: false)
        }
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        
        // Настройка заголовка рекомендаций
        recommendationsLabel.text = "We Think You'll Like These"
        recommendationsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        // Настройка коллекции рекомендаций
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 180)
        layout.minimumLineSpacing = 12
        
        recommendationsCollectionView.collectionViewLayout = layout
        recommendationsCollectionView.showsHorizontalScrollIndicator = false
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: "RecommendationCell")
        recommendationsCollectionView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        [filterSegmentedControl, recommendationsLabel, recommendationsCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            filterSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            recommendationsLabel.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 24),
            recommendationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recommendationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            recommendationsCollectionView.topAnchor.constraint(equalTo: recommendationsLabel.bottomAnchor, constant: 12),
            recommendationsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recommendationsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendationsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Actions
    @objc private func filterChanged(_ sender: UISegmentedControl) {
        print("Selected filter: \(filters[sender.selectedSegmentIndex])")
        // Здесь можно обновить результаты поиска
    }
}

// MARK: - Collection View Data Source & Delegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
        cell.configure(with: recommendations[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(recommendations[indexPath.item])")
    }
}

// MARK: - Custom Cell
class RecommendationCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // Настройка изображения
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray5
        
        // Настройка текста
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        // Иерархия представлений
        [imageView, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
        // Здесь можно загрузить изображение
        imageView.image = UIImage(systemName: "photo")?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
    }
}
