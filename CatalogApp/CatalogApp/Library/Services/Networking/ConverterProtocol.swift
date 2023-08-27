//
//  ConverterProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 26.08.2023.
//

import Foundation

protocol ConverterProtocol {
    func decode<T>(from data: Data) -> T?  where T: Codable
}
