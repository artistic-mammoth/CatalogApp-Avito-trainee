//
//  CatalogCellPlaceholder.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

class CatalogCellPlaceholder: UIView {
    // MARK: - Views
    private lazy var imageView = ShimmerView()
    private lazy var titleLabel = ShimmerView()
    private lazy var priceLabel = ShimmerView()
    private lazy var locationLabel = ShimmerView()
    private lazy var createdDateLabel = ShimmerView()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
}

// MARK: - Private extension
private extension CatalogCellPlaceholder {
    func setupView() {
        addViews(imageView, titleLabel, priceLabel, locationLabel, createdDateLabel)
        
        backgroundColor = Config.backgroundColor
        clipsToBounds = true
        
        imageView.layer.cornerRadius = Config.imageCornerRadius
        imageView.clipsToBounds = true
        
        [titleLabel, priceLabel, locationLabel, createdDateLabel].forEach { view in
            view.layer.cornerRadius = Config.labelCornerRadius
            view.clipsToBounds = true
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            locationLabel.heightAnchor.constraint(equalToConstant: 13),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 7),
            createdDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            createdDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            createdDateLabel.heightAnchor.constraint(equalToConstant: 13),
        ])
    }
}

// MARK: - Config
fileprivate enum Config {
    static let backgroundColor: UIColor = .clear
    static let imageCornerRadius: CGFloat = 11
    static let labelCornerRadius: CGFloat = 5
}
