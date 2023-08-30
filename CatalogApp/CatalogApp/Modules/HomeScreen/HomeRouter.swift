//
//  HomeRouter.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import UIKit

final class HomeRouter {
    // MARK: - Public properties
    weak var viewController: HomeViewController?
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    func openProductDetailsFor(id: String) {
        let productViewController = ProductModuleBuilder.build(for: id)
        viewController?.navigationController?.pushViewController(productViewController, animated: true)
    }
}
