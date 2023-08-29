//
//  FontsRes.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import UIKit

extension UIFont {
    static func boldHelveticaNeue(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "HelveticaNeue-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
    
    static func mediumHelveticaNeue(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "HelveticaNeue-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
    
    static func lightHelveticaNeue(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "HelveticaNeue-Light", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
    
    static func regularHelveticaNeue(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "HelveticaNeue", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
