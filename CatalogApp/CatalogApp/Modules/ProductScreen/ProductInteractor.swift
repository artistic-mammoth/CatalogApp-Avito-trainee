//
//  ProductInteractor.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import Foundation

final class ProductInteractor {
    // MARK: - Public properties
    weak var presenter: ProductPresenterProtocol?
    
    // MARK: - Private properties
    private let networkClient: NetworkClientProtocol
    
    // MARK: - Init
    init(presenter: ProductPresenterProtocol? = nil, networkClient: NetworkClientProtocol) {
        self.presenter = presenter
        self.networkClient = networkClient
    }
}

// MARK: - HomeInteractorProtocol
extension ProductInteractor: ProductInteractorProtocol {
    func loadProductData(for id: String) {
        let request = ProductDetailsRequest(id: id)
        networkClient.sendRequest(request) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.ProductDataDidLoaded(data: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.handleError(error)
                }
            }
        }
    }
}
