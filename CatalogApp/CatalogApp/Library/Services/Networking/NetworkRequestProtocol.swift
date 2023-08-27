//
//  NetworkRequestProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import Foundation

protocol NetworkRequestProtocol where DataModel: Codable {
    associatedtype DataModel
    
    var component: EndpointComponentProtocol { get }
    var decoder: NetworkDecoderWrapper<DataModel> { get }
}
