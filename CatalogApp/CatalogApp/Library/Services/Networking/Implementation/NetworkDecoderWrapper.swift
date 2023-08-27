//
//  NetworkDecoderWrapper.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 26.08.2023.
//

import Foundation

final class NetworkDecoderWrapper<DataModel>: NetworkDecoderProtocol where DataModel: Codable {
    // MARK: - Private properties
    private let decoder: ConverterProtocol
    
    // MARK: - Init
    init(decoder: ConverterProtocol = ConverterFromJSON()) {
        self.decoder = decoder
    }
    
    // MARK: - NetworkDecoderProtocol
    func decode(from data: Data) -> DataModel? {
        decoder.decode(from: data)
    }
}
