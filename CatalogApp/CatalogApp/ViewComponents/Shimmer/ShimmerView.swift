//
//  ShimmerView.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class ShimmerView: UIView, ShimmerDisplayable {
    // MARK: - Private properties
    private lazy var shimmerLayer: CAGradientLayer = getShimmerLayer()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(shimmerLayer)
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        shimmerLayer.frame = bounds
    }
}
