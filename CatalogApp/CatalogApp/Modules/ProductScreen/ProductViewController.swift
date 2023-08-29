//
//  ProductViewController.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class ProductViewController: UIViewController {
    // MARK: - Public properties
    var presenter: ProductPresenterProtocol?
    
    // MARK: - Views
    private lazy var scrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private lazy var contentView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private lazy var imageView: LazyImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Config.imageCornerRadius
        $0.clipsToBounds = true
        return $0
    }(LazyImageView())
    
    private lazy var titleLabel: UILabel = {
        $0.textColor = Config.mainTextColor
        $0.font = .boldHelveticaNeue(size: 23)
        $0.numberOfLines = 2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var priceView: UIView = {
        $0.backgroundColor = .label
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    private lazy var priceLabel: UILabel = {
        $0.textColor = .systemBackground
        $0.font = .boldHelveticaNeue(size: 26)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var locationAndAdressLabel: UILabel = {
        $0.textColor = Config.mainTextColor
        $0.font = .regularHelveticaNeue(size: 17)
        $0.numberOfLines = 2
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var contactView: UIView = {
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    private lazy var contactLabel: UILabel = {
        $0.textColor = .white
        $0.font = .boldHelveticaNeue(size: 20)
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.text = "Связаться"
        return $0
    }(UILabel())
    
    private lazy var createdDateLabel: UILabel = {
        $0.textColor = Config.mainTextColor
        $0.font = .regularHelveticaNeue(size: 17)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var descriptionTitleLabel: UILabel = {
        $0.textColor = Config.mainTextColor
        $0.font = .boldHelveticaNeue(size: 23)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.text = "Описание"
        return $0
    }(UILabel())
    
    private lazy var descriptionTextView: UITextView = {
        $0.textColor = Config.mainTextColor
        $0.font = .regularHelveticaNeue(size: 17)
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        return $0
    }(UITextView())
    
    private lazy var contactViewController = ContactViewController()
    private var productPlaceholderView: ProductPlaceholderView?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
}

// MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    func updateWith(_ data: ProductData) {
        imageView.fetchImage(from: data.imageURL)
        
        hidePlaceholder()
        
        title = data.title
        titleLabel.text = data.title
        priceLabel.text = data.price
        locationAndAdressLabel.text = "\(data.location), \(data.address)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let formattedDate = dateFormatter.string(from: data.createdDate)
        
        createdDateLabel.text = formattedDate
        descriptionTextView.text = data.description
        
        contactViewController.configureWith(phoneNumber: data.phoneNumber, email: data.email)
    }
}

// MARK: - Private extension
private extension ProductViewController {
    func setupView() {
        view.addViews(scrollView)
        scrollView.addViews(contentView)
        contentView.addViews(imageView, titleLabel, priceView, contactView, locationAndAdressLabel, createdDateLabel, descriptionTitleLabel, descriptionTextView)
        priceView.addViews(priceLabel)
        contactView.addViews(contactLabel)
        
        view.backgroundColor = Config.backgroundColor
        
        showPlaceholder()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openContactView))
        contactView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            priceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            priceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            priceView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            priceView.heightAnchor.constraint(equalToConstant: 50),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor),
            
            contactView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            contactView.leadingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: 10),
            contactView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contactView.heightAnchor.constraint(equalToConstant: 50),
            
            contactLabel.topAnchor.constraint(equalTo: contactView.topAnchor),
            contactLabel.bottomAnchor.constraint(equalTo: contactView.bottomAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: contactView.leadingAnchor),
            contactLabel.trailingAnchor.constraint(equalTo: contactView.trailingAnchor),
            
            locationAndAdressLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 20),
            locationAndAdressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationAndAdressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationAndAdressLabel.bottomAnchor, constant: 10),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 15),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    @objc
    func openContactView() {
        // TODO: - Add bottom sheet
//        if #available(iOS 15.0, *) {
//            if let sheetController = contactVC.sheetPresentationController {
//                if #available(iOS 16.0, *) {
//                    sheetController.detents = [.custom(resolver: { context in
//                        0.2 * context.maximumDetentValue
//                    })]
//                } else {
//                    sheetController.detents = [.medium()]
//                }
//                sheetController.preferredCornerRadius = 30
//                sheetController.prefersGrabberVisible = true
//            }
//            present(contactVC, animated: true)
//        } else {
            present(contactViewController, animated: true)
//        }
    }
    
    func showPlaceholder() {
        productPlaceholderView = ProductPlaceholderView()
        if let productPlaceholderView = productPlaceholderView {
            view.addViews(productPlaceholderView)
            
            NSLayoutConstraint.activate([
                productPlaceholderView.topAnchor.constraint(equalTo: view.topAnchor),
                productPlaceholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                productPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                productPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            
        }
    }
    
    func hidePlaceholder() {
        productPlaceholderView?.removeFromSuperview()
        productPlaceholderView = nil
    }
}

// MARK: - Config
fileprivate enum Config {
    static let backgroundColor: UIColor = .systemBackground
    static let imageCornerRadius: CGFloat = 15
    static let mainTextColor: UIColor = .label
}
