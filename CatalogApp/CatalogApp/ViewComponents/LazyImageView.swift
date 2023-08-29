//
//  LazyImageView.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import UIKit

final class LazyImageView: UIImageView {
    // MARK: - ImageFetchError
    public enum ImageFetchError {
        case noImage
        case badURL
    }
    
    // MARK: - Image Cache
    private static let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1000 * 1000
        return cache
    }()
    
    // MARK: - Public properties
    var imagePlaceholder: UIImage?
    
    // MARK: - Private properties
    private var placeholderView: UIImageView = {
        $0.image = UIImage(systemName: "megaphone.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(.init(font: .boldHelveticaNeue(size: 30), scale: .large))
        return $0
    }(UIImageView())
    
    private var session: URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init(imagePlaceholder: UIImage? = nil, session: URLSession = URLSession.shared) {
        self.imagePlaceholder = imagePlaceholder
        self.session = session
        super.init(frame: .zero)
        setupView()
    }
    
    // MARK: - Public methods
    func fetchImage(from imageURL: String, errorHandler: ((ImageFetchError?) -> ())? = nil) {
        showPlaceholder()
        
        guard let url = URL(string: imageURL) else { errorHandler?(.badURL); return }
        
        if let cachedImage = LazyImageView.imageCache.object(forKey: imageURL as NSString) {
            hidePlaceholder()
            self.image = cachedImage
            return
        }
        
        let handler: (Data?, URLResponse?, Error?) -> Void = { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                // FIXME: - fix canceled task
                //                errorHandler?(.noImage)
                return
            }
            
            if let imageFromData = UIImage(data: data) {
                LazyImageView.imageCache.setObject(imageFromData, forKey: imageURL as NSString)
                DispatchQueue.main.async {
                    self.hidePlaceholder()
                    self.image = imageFromData
                }
            } else {
                errorHandler?(.noImage)
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        task = session.dataTask(with: request, completionHandler: handler)
        self.task?.resume()
    }
}

// MARK: - Private extension
private extension LazyImageView {
    private func showPlaceholder() {
        task?.cancel()
        image = nil
        placeholderView.isHidden = false
        backgroundColor = .systemGray5
    }
    
    private func hidePlaceholder() {
        placeholderView.isHidden = true
        backgroundColor = .clear
    }
    
    private func setupView() {
        addViews(placeholderView)
        
        placeholderView.contentMode = .center
        
        NSLayoutConstraint.activate([
            placeholderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
