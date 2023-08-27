//
//  RequestBuilderProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 26.08.2023.
//

import Foundation

protocol RequestBuilderProtocol: AnyObject {
    func buildRequest(_ request: any NetworkRequestProtocol) -> Result<URLRequest, NetworkError>
}
