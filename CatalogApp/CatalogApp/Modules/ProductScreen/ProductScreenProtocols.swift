//
//  ProductScreenProtocols.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

protocol ProductViewProtocol: AnyObject {
    func updateWith(_ data: ProductData)
}

protocol ProductPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func ProductDataDidLoaded(data: ProductDetailsResponse)
    func handleError(_ error: NetworkError)
}

protocol ProductInteractorProtocol: AnyObject {
    func loadProductData(for id: String)
}

protocol ProductRouterProtocol: AnyObject {
    
}
