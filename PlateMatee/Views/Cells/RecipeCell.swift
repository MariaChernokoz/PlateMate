import UIKit

class RecipeCell: UICollectionViewCell {
    static let reuseIdentifier = "RecipeCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        timeLabel.font = .systemFont(ofSize: 13)
        timeLabel.textColor = .systemGray
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, timeLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    func configure(title: String = "Recipe Name", time: String = "25 minutes") {
        titleLabel.text = title
        timeLabel.text = time
    }
} 