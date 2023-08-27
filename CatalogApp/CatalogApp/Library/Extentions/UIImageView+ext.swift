//
//  UIImageView+ext.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 27.08.2023.
//

import UIKit

extension UIImageView {
    /**
     Fetch image from url.

     Additional check for cache.
     - Parameters:
        - urlString: A full url of image
        - completion: Escaping block returns data of image if sucsess or failure
    */
    static func fetchImage(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else { completion(.failure(.badURL)); return }
        
        if let cachedData = CacheStorage.shared.getData(key: urlString) {
            completion(.success(cachedData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            CacheStorage.shared.addData(key: urlString, data: data)
            completion(.success(data))
        }
        
        dataTask.resume()
    }
}
