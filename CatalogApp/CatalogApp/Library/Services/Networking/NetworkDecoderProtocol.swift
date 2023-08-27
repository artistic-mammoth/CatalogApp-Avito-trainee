//
//  NetworkDecoderProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 26.08.2023.
//

import Foundation

protocol NetworkDecoderProtocol<DataModel>: AnyObject where DataModel : Codable {
    associatedtype DataModel
    func decode(from data: Data) -> DataModel?
}
