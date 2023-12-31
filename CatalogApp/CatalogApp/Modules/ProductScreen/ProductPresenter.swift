//
//  ProductPresenter.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import Foundation

final class ProductPresenter {
    // MARK: - Public properties
    weak var view: ProductViewProtocol?
    var router: ProductRouterProtocol
    var interactor: ProductInteractorProtocol
    
    // MARK: - Private properties
    private let messageService: MessageServiceProtocol
    private let productId: String
    private var productData: ProductData?
    
    // MARK: - Init
    init(router: ProductRouterProtocol, interactor: ProductInteractorProtocol, messageService: MessageServiceProtocol, productId: String) {
        self.router = router
        self.interactor = interactor
        self.messageService = messageService
        self.productId = productId
    }
}

// MARK: - HomePresenterProtocol
extension ProductPresenter: ProductPresenterProtocol {
    func viewDidLoaded() {
        interactor.loadProductData(for: productId)
    }
    
    func ProductDataDidLoaded(data: ProductDetailsResponse) {
        if let id = data.id,
           let title = data.title,
           let price = data.price,
           let imageURL = data.imageURL,
           let description = data.description,
           let email = data.email,
           let phoneNumber = data.phoneNumber,
           let createdDate = data.createdDate,
           let location = data.location,
           let address = data.address {
            
            let productData = ProductData(id: id,
                                          title: title,
                                          price: price,
                                          imageURL: imageURL,
                                          description: description,
                                          email: email,
                                          phoneNumber: phoneNumber,
                                          createdDate: createdDate,
                                          location: location,
                                          address: address)
            
            self.productData = productData
            view?.updateWith(productData)
            
        } else {
            handleError(.noData)
        }
    }
    
    func handleError(_ error: NetworkError) {
        messageService.showErrorMessage(with: error) { [weak self] in
            guard let self = self else { return }
            self.interactor.loadProductData(for: self.productId)
        }
    }
    
    func contactButtonDidTap() {
        guard let data = productData else { return }
        router.openContactView(phone: data.phoneNumber, email: data.email)
    }
}
