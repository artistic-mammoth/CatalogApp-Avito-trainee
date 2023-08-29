//
//  MessageServiceProtocol.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

protocol MessageServiceProtocol {
    func showMessageWith(model: MessageModel)
    func showErrorMessage(with error: NetworkError, onTap: @escaping (() -> ()))
    
    init(messageView: MessageViewProtocol)
}
