//
//  CacheStorage.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 27.08.2023.
//

import Foundation

final class CacheStorage {
    // MARK: - Singleton
    static let shared = CacheStorage()
    private init() {}
    
    // MARK: - Private properties
    private let dataCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1000 * 1000
        return cache
    }()
    
    // MARK: - Public methods
    func addData(key: String, data: Data) {
        dataCache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func getData(key: String) -> Data? {
        dataCache.object(forKey: key as NSString) as? Data
    }
}
