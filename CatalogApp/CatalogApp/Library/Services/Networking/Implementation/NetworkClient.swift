//
//  NetworkClient.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import Foundation

final class NetworkClient {
    // MARK: - Private properties
    private let session: URLSession
    private let requestBuilder: RequestBuilderProtocol

    // MARK: - Init
    init(session: URLSession = URLSession.shared, requestBuilder: RequestBuilderProtocol = RequestBuilder()) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
}

// MARK: - NetworkClientProtocol
extension NetworkClient: NetworkClientProtocol {
    func sendRequest<T>(_ request: T, completion: @escaping (Result<T.DataModel, NetworkError>) -> ()) where T : NetworkRequestProtocol {
        switch getRequest(from: request) {
        case let .success(urlRequest):
            
            let handler: (Data?, URLResponse?, Error?) -> Void = { [weak self] data, response, error in
                guard let self = self else {
                    completion(.failure(.unknown))
                    return
                }

                guard error == nil else {
                    let networkError = self.getNetworkError(from: error)
                    completion(.failure(networkError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                if let decodedData = request.decoder.decode(from: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.decodeFailure))
                    return
                }
            }
            
            session.dataTask(with: urlRequest, completionHandler: handler).resume()
            
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

// MARK: - Private extentions
private extension NetworkClient {
    func getRequest<T>(from request: T) -> Result<URLRequest, NetworkError> where T : NetworkRequestProtocol {
        switch requestBuilder.buildRequest(request) {
        case let .success(urlRequest):
            return .success(urlRequest)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func getNetworkError(from error: Error?) -> NetworkError {
        switch (error as? URLError)?.code {
        case .some(.notConnectedToInternet):
            return .noInternetConnection
        case .some(.timedOut):
            return .timeout
        default:
            return .unknown
        }
    }
}
