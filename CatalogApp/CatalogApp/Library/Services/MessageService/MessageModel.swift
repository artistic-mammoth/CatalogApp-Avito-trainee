//
//  MessageModel.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

struct MessageModel {
    let title: String
    let description: String
    let buttonTitle: String
    let onButtonTapped: () -> ()
    
    init(title: String, description: String = "", buttonTitle: String, onButtonTapped: @escaping () -> ()) {
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.onButtonTapped = onButtonTapped
    }
}
