//
//  ProductModuleBuilder.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class ProductModuleBuilder {
    static func build(for id: String) -> ProductViewController {
        
        let networkClient = NetworkClient()
        let messageService = MessageService()
        
        let interactor = ProductInteractor(networkClient: networkClient)
        let router = ProductRouter()
        let presenter = ProductPresenter(router: router, interactor: interactor, messageService: messageService, productId: id)
        let viewController = ProductViewController()
        
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}
