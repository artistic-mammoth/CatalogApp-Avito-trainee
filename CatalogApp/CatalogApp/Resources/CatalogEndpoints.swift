//
//  CatalogEndpoints.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 27.08.2023.
//

enum CatalogEndpoints {
    case mainPageInfo
    case productDetails(id: String)
}

// MARK: - EndpointComponentProtocol
extension CatalogEndpoints: EndpointComponentProtocol {
    private var apiPath: String {
        "/s/interns-ios"
    }
    
    var host: String {
        "www.avito.st"
    }
    
    var path: String {
        switch self {
        case .mainPageInfo:
            return apiPath + "/main-page.json"
        case .productDetails(id: let id):
            return apiPath + "/details/\(id).json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .mainPageInfo:
            return .get
        case .productDetails(id: _):
            return .get
        }
    }
}
