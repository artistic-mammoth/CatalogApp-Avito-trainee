//
//  NetworkError.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

public enum NetworkError: Error {
    case noInternetConnection
    case badURL
    case decodeFailure
    case noData
    case timeout
    case unknown
}
