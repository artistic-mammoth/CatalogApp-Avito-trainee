//
//  MessageService.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class MessageService: MessageServiceProtocol {
    // MARK: - Private properties
    private var messageView: MessageViewProtocol
    
    // MARK: - Init from MessageServiceProtocol
    init(messageView: MessageViewProtocol = MessageView()) {
        self.messageView = messageView
    }
    
    // MARK: - MessageServiceProtocol
    func showErrorMessage(with error: NetworkError, onTap: @escaping (() -> ())) {
        switch error {
        case .noInternetConnection, .timeout:
            showMessageWith(model: .init(title: "Отсутвует подключение к сети", buttonTitle: "Попробовать снова", onButtonTapped: {
                onTap()
            }))
        case .noData:
            showMessageWith(model: .init(title: "Ошибка в загрузке данных", buttonTitle: "Попробовать снова", onButtonTapped: {
                onTap()
            }))
        default:
            showMessageWith(model: .init(title: "Неизвестная ошибка", buttonTitle: "Попробовать снова", onButtonTapped: {
                onTap()
            }))
        }
    }
    
    func showMessageWith(model: MessageModel) {
        messageView.update(with: model)
        showView()
    }
}

// MARK: - Private extension
private extension MessageService {
    func showView() {
        guard let keyWindow = UIApplication.shared.windows.first else { return }
        messageView.modalPresentationStyle = .fullScreen
        keyWindow.rootViewController?.present(messageView, animated: true)
    }
}
