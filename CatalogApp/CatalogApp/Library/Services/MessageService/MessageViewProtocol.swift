//
//  MessageViewProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

protocol MessageViewProtocol: UIViewController {
    func update(with model: MessageModel)
}
