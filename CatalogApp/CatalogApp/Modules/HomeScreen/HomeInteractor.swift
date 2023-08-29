//
//  HomeInteractor.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import Foundation

final class HomeInteractor {
    // MARK: - Public properties
    weak var presenter: HomePresenterProtocol?
    
    // MARK: - Private properties
    private let networkClient: NetworkClientProtocol
    
    // MARK: - Init
    init(presenter: HomePresenterProtocol? = nil, networkClient: NetworkClientProtocol) {
        self.presenter = presenter
        self.networkClient = networkClient
    }
}

// MARK: - HomeInteractorProtocol
extension HomeInteractor: HomeInteractorProtocol {
    func loadMainPageData() {
        networkClient.sendRequest(AdvertisementsRequest()) { [weak self] result in
            switch result {
            case .success(let data):
                if let advertisements = data.advertisements {
                    DispatchQueue.main.async {
                        self?.presenter?.mainPageDataDidLoaded(data: advertisements)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.handleError(.noData)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.handleError(error)
                }
            }
        }
    }
}
