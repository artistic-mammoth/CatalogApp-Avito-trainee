//
//  CatalogDataModel.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import UIKit

typealias CatalogDataModel = [CatalogSections]
typealias CatalogCell = UICollectionViewCell & CatalogCellProtocol

struct CatalogSections {
    let items: [CatalogItemData]
}

struct CatalogItemData {
    let id: String?
    let title: String?
    let imageURL: String?
    let price: String?
    let location: String?
    let createdDate: Date?
}

protocol CatalogCellProtocol {
    func configureWith(data: CatalogItemData)
}
