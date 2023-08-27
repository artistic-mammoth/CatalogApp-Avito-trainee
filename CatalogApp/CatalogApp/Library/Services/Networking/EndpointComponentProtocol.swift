//
//  EndpointComponentProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 27.08.2023.
//

protocol EndpointComponentProtocol {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}
