//
//  HomePresenter.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

final class HomePresenter {
    // MARK: - Public properties
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol
    var interactor: HomeInteractorProtocol
        
    // MARK: - Init
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func viewDidLoaded() {

    }
}
