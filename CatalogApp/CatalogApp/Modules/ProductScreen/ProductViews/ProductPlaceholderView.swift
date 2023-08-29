//
//  ProductPlaceholderView.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//


import UIKit

final class ProductPlaceholderView: UIView {
    // MARK: - Views
    private lazy var scrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private lazy var contentView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var imageView = ShimmerView()
    private lazy var titleLabel = ShimmerView()
    private lazy var priceView = ShimmerView()
    private lazy var locationAndAdressLabel = ShimmerView()
    private lazy var contactView = ShimmerView()
    private lazy var createdDateLabel = ShimmerView()
    private lazy var descriptionTitleLabel = ShimmerView()
    private lazy var descriptionTextView = ShimmerView()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
}

// MARK: - Private extension
private extension ProductPlaceholderView {
    func setupView() {
        addViews(scrollView)
        scrollView.addViews(contentView)
        contentView.addViews(imageView, titleLabel, priceView, contactView, locationAndAdressLabel, createdDateLabel, descriptionTitleLabel, descriptionTextView)
        
        backgroundColor = Config.backgroundColor
        
        imageView.layer.cornerRadius = Config.imageCornerRadius
        imageView.clipsToBounds = true
        
        [titleLabel, priceView, contactView, locationAndAdressLabel, createdDateLabel, descriptionTitleLabel, descriptionTextView].forEach { view in
            view.layer.cornerRadius = Config.labelCornerRadius
            view.clipsToBounds = true
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            priceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            priceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            priceView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            priceView.heightAnchor.constraint(equalToConstant: 50),
            
            contactView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            contactView.leadingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: 10),
            contactView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contactView.heightAnchor.constraint(equalToConstant: 50),
            
            locationAndAdressLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 20),
            locationAndAdressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationAndAdressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            locationAndAdressLabel.heightAnchor.constraint(equalToConstant: 25),

            createdDateLabel.topAnchor.constraint(equalTo: locationAndAdressLabel.bottomAnchor, constant: 10),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            createdDateLabel.heightAnchor.constraint(equalToConstant: 25),

            descriptionTitleLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 15),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 30),

            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 300),
            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

// MARK: - Config
fileprivate enum Config {
    static let backgroundColor: UIColor = .systemBackground
    static let imageCornerRadius: CGFloat = 15
    static let labelCornerRadius: CGFloat = 10
    static let mainTextColor: UIColor = .label
}
