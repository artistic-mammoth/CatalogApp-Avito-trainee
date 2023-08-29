//
//  ShimmerDisplayable.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

protocol ShimmerDisplayable { }

extension ShimmerDisplayable {
    func getShimmerLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let animation = CABasicAnimation(keyPath: "locations")
        
        let color: UIColor = UIColor.systemGray5
        let animationSpeed: CFTimeInterval = 1.5
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        let colorOne = color.withAlphaComponent(0.5).cgColor
        let colorTwo = color.withAlphaComponent(0.8).cgColor
        gradientLayer.colors = [colorOne, colorTwo, colorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = animationSpeed
        gradientLayer.add(animation, forKey: animation.keyPath)
        
        return gradientLayer
    }
}
