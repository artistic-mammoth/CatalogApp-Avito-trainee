//
//  ProductRouter.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class ProductRouter {
    // MARK: - Public properties
    weak var viewController: ProductViewController?
}

// MARK: - HomeRouterProtocol
extension ProductRouter: ProductRouterProtocol {
    func openContactView(phone: String, email: String) {
        let contactViewController = ContactViewController()
        contactViewController.configureWith(phoneNumber: phone, email: email)
        
        // TODO: - Add custom bottom sheet for iOS under 15.0
        if #available(iOS 15.0, *) {
            if let sheetController = contactViewController.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheetController.detents = [.custom(resolver: { context in
                        0.25 * context.maximumDetentValue
                    })]
                } else {
                    sheetController.detents = [.medium()]
                }
                sheetController.preferredCornerRadius = 30
                sheetController.prefersGrabberVisible = true
            }
            viewController?.present(contactViewController, animated: true)
        } else {
            viewController?.present(contactViewController, animated: true)
        }
    }
}
