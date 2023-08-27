//
//  RequestBuilder.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import Foundation

final class RequestBuilder: RequestBuilderProtocol {
    func buildRequest(_ request: any NetworkRequestProtocol) -> Result<URLRequest, NetworkError> {
        guard let url = getURLFrom(request) else {
            return .failure(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.component.method.rawValue
        urlRequest.timeoutInterval = 10

        return .success(urlRequest)
    }
}

// MARK: - Private extentions
private extension RequestBuilder {
    func getURLFrom(_ request: any NetworkRequestProtocol) -> URL? {
        var urlComponents: URLComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = request.component.host
        urlComponents.path = request.component.path
        return urlComponents.url
    }
}
