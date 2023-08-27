//
//  NetworkClientProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 26.08.2023.
//

import Foundation

protocol NetworkClientProtocol {
    func sendRequest<T: NetworkRequestProtocol>(_ request: T, completion: @escaping (Result<T.DataModel, NetworkError>) -> ())
}
