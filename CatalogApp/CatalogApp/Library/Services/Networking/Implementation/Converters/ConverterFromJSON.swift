//
//  ConverterFromJSON.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import Foundation

final class ConverterFromJSON: ConverterProtocol {
    func decode<T>(from data: Data) -> T?  where T: Codable {
        try? JSONDecoder().decode(T.self, from: data)
    }
}
