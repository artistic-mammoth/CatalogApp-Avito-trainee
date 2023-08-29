//
//  HomeModuleBuilder.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import UIKit

final class HomeModuleBuilder {
    static func build() -> HomeViewController {
        
        let networkClient = NetworkClient()
        let messageService = MessageService()
        
        let interactor = HomeInteractor(networkClient: networkClient)
        let router = HomeRouter()
        let presenter = HomePresenter(router: router, interactor: interactor, messageService: messageService)
        let viewController = HomeViewController()
        
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}
