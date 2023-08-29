//
//  MessageView.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class MessageView: UIViewController {
    // MARK: - Callback
    private var buttonDidTapped: (() -> ())?
    
    // MARK: - Views
    let messangeLabel: UILabel = {
        $0.textColor = .label
        $0.font = .boldHelveticaNeue(size: 21)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let button: UIButton = {
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldHelveticaNeue(size: 17)
        return $0
    }(UIButton())
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupView()
    }
}

// MARK: - MessageViewProtocol
extension MessageView: MessageViewProtocol {
    func update(with model: MessageModel) {
        messangeLabel.text = model.title
        button.setTitle(model.buttonTitle, for: .normal)
        
        buttonDidTapped = {
            model.onButtonTapped()
        }
    }
}

// MARK: - Private extension
private extension MessageView {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addViews(messangeLabel, button)
        
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            messangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messangeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messangeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            button.topAnchor.constraint(equalTo: messangeLabel.bottomAnchor, constant: 21),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func buttonHandler() {
        dismiss(animated: true)
        buttonDidTapped?()
    }
}
