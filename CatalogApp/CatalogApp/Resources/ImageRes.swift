//
//  ImageRes.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 30.08.2023.
//

import UIKit

extension UIImage {
    
    static let placeholderMegaphone: UIImage = {
        guard let icon = UIImage(systemName: "megaphone.fill")?
            .withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            .applyingSymbolConfiguration(.init(font: .boldHelveticaNeue(size: 30), scale: .large)) else {
            return UIImage()
        }
        return icon
    }()
    
    static let placeholderError: UIImage = {
        guard let icon = UIImage(systemName: "x.circle")?
            .withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            .applyingSymbolConfiguration(.init(font: .boldHelveticaNeue(size: 30), scale: .large)) else {
            return UIImage()
        }
        return icon
    }()
}
