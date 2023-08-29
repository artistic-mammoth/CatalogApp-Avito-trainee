//
//  ProductDetailsRequest.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import Foundation

struct ProductDetailsRequest: NetworkRequestProtocol {
    typealias Response = ProductDetailsResponse
    var component: EndpointComponentProtocol
    var decoder: NetworkDecoderWrapper<Response> = NetworkDecoderWrapper()
    
    init(id: String) {
        self.component = CatalogEndpoints.productDetails(id: id)
    }
}
