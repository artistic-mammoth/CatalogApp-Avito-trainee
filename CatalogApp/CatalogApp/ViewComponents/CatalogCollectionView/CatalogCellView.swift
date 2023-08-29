//
//  CatalogCellView.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import UIKit

class CatalogCellView: CatalogCell {
    // MARK: - Public properties
    static let reuseIdentifier = "CatalogCellView"
    
    // MARK: - Views
    private lazy var imageView: LazyImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Config.imageCornerRadius
        $0.clipsToBounds = true
        return $0
    }(LazyImageView())
    
    private lazy var titleLabel: UILabel = {
        $0.textColor = Config.mainTextColor
        $0.font = .mediumHelveticaNeue(size: 17)
        $0.numberOfLines = 2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var priceLabel: UILabel = {
        $0.textColor = Config.mainTextColor
        $0.font = .boldHelveticaNeue(size: 19)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var locationLabel: UILabel = {
        $0.textColor = Config.footerTextColor
        $0.font = .regularHelveticaNeue(size: 14)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var createdDateLabel: UILabel = {
        $0.textColor = Config.footerTextColor
        $0.font = .regularHelveticaNeue(size: 14)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var messageView: CellMessage = {
        $0.layer.cornerRadius = Config.imageCornerRadius
        return $0
    }(CellMessage())
    
    private var catalogCellPlaceholder: CatalogCellPlaceholder?
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        createdDateLabel.text = nil
    }
    
    // MARK: - CatalogCell
    func configureWith(data: CatalogItemData) {
        if let title = data.title,
           let price = data.price,
           let location = data.location,
           let createdDate = data.createdDate,
           let imageURL = data.imageURL {
            
            imageView.fetchImage(from: imageURL, errorHandler: { error in
                // TODO: Handle image error
                if let error = error {
                    switch error {
                    case .noImage:
                        print("noImage")
                    case .badURL:
                        print("badURL")
                    }
                }
            })
            
            hidePlaceholder()
            
            titleLabel.text = title
            priceLabel.text = price
            locationLabel.text = location
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let formattedDate = dateFormatter.string(from: createdDate)
            
            createdDateLabel.text = formattedDate
        } else {
            imageView.image = nil
            showPlaceholder(messange: "Невозможно загрузить товар")
        }
    }
    
    func showPlaceholderCell() {
        showPlaceholder()
    }
}

// MARK: - Private extension
private extension CatalogCellView {
    func setupView() {
        addViews(imageView, titleLabel, priceLabel, locationLabel, createdDateLabel, messageView)
        
        backgroundColor = Config.backgroundColor
        clipsToBounds = true
        messageView.isHidden = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 2),
            createdDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            createdDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            messageView.topAnchor.constraint(equalTo: topAnchor),
            messageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func showPlaceholder(messange: String? = nil) {
        if let messange = messange {
            messageView.showErrorMessange(messange: messange)
            isUserInteractionEnabled = false
            messageView.isHidden = false
            catalogCellPlaceholder?.removeFromSuperview()
            catalogCellPlaceholder = nil
            return
        }
        
        messageView.isHidden = true
        catalogCellPlaceholder = CatalogCellPlaceholder()
        if let catalogCellPlaceholder = catalogCellPlaceholder {
            addViews(catalogCellPlaceholder)
            
            NSLayoutConstraint.activate([
                catalogCellPlaceholder.topAnchor.constraint(equalTo: topAnchor),
                catalogCellPlaceholder.bottomAnchor.constraint(equalTo: bottomAnchor),
                catalogCellPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor),
                catalogCellPlaceholder.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        }
    }
    
    func hidePlaceholder() {
        catalogCellPlaceholder?.removeFromSuperview()
        catalogCellPlaceholder = nil
        isUserInteractionEnabled = true
        messageView.isHidden = true
    }
}

// MARK: - Config
fileprivate enum Config {
    static let backgroundColor: UIColor = .clear
    static let imageCornerRadius: CGFloat = 11
    static let footerTextColor: UIColor = .systemGray
    static let mainTextColor: UIColor = .label
}
