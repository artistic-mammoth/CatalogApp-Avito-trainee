//
//  CellMessage.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import UIKit

// TODO: - Refactor
final class CellMessage: UIView {
    // MARK: - Private properties
    private var imageLogo: UIImage?
    
    // MARK: - Views
    private lazy var messangeLabel: UILabel = {
        $0.textColor = .label
        $0.font = .regularHelveticaNeue(size: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var imageLogoView: UIImageView = {
        contentMode = .center
        return $0
    }(UIImageView())
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - Override
    override func layoutSubviews() {
        super.layoutSubviews()
        imageLogoView.center = center
    }
    
    // MARK: - Public methods
    func showErrorMessange(messange: String) {
        messangeLabel.text = messange
        imageLogoView.isHidden = messange == "" ? false : true
    }
    
    // MARK: - Private methods
    private func setupView() {
        addViews(messangeLabel, imageLogoView)
        
        imageLogo = UIImage(systemName: "megaphone.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(.init(font: .boldHelveticaNeue(size: 30), scale: .large))
        
        imageLogoView.image = imageLogo
        
        NSLayoutConstraint.activate([
            messangeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messangeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            messangeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .systemGray5
    }
}
