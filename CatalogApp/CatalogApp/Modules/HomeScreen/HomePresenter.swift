//
//  HomePresenter.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import Foundation

final class HomePresenter {
    // MARK: - Public properties
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol
    var interactor: HomeInteractorProtocol
    
    // MARK: - Private properties
    private let messageService: MessageServiceProtocol
    
    // MARK: - Init
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol, messageService: MessageServiceProtocol) {
        self.router = router
        self.interactor = interactor
        self.messageService = messageService
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func mainPageDataDidLoaded(data: [Advertisement]) {
        let sectionData: [CatalogItemData] = data.map({ item in
            CatalogItemData(id: item.id,
                            title: item.title,
                            imageURL: item.imageURL,
                            price: item.price,
                            location: item.location,
                            createdDate: item.createdDate)
        })
        view?.updateCollectionDataWith([CatalogSections(items: sectionData)])
    }
    
    func handleError(_ error: NetworkError) {
        messageService.showErrorMessage(with: .noInternetConnection) { [weak self] in
            self?.interactor.loadMainPageData()
        }
    }
    
    func viewDidLoaded() {
        interactor.loadMainPageData()
    }
    
    func didSelectItemAt(id: String) {
        router.openProductDetailsFor(id: id)
    }
    
    func wantToRefresh() {
        interactor.loadMainPageData()
    }
}
