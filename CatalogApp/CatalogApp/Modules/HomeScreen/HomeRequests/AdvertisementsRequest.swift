//
//  AdvertisementsRequest.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import Foundation

struct AdvertisementsRequest: NetworkRequestProtocol {
    typealias Response = AdvertisementsResponse
    var component: EndpointComponentProtocol = CatalogEndpoints.mainPageInfo
    var decoder: NetworkDecoderWrapper<Response> = NetworkDecoderWrapper()
}
