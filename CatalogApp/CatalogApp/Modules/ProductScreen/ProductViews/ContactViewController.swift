//
//  ContactViewController.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 29.08.2023.
//

import UIKit

final class ContactViewController: UIViewController {
    // MARK: - Private properties
    private var phone: String = ""
    private var isHiding: Bool = true
    
    // MARK: - Views
    let phoneLabel: UILabel = {
        $0.textColor = .label
        $0.font = .boldHelveticaNeue(size: 21)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let phoneButton: UIButton = {
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 11
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldHelveticaNeue(size: 17)
        return $0
    }(UIButton())
    
    let emailLabel: UILabel = {
        $0.textColor = .label
        $0.font = .boldHelveticaNeue(size: 21)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    // MARK: - Public methods
    func configureWith(phoneNumber: String, email: String) {
        phone = phoneNumber
        emailLabel.text = email
        hidePhoneNumber()
    }
}

// MARK: - Private extension
private extension ContactViewController {
    func setupView() {
        view.addViews(phoneLabel, phoneButton, emailLabel)
        view.backgroundColor = .systemBackground
        
        phoneButton.addTarget(self, action: #selector(handlePhoneButton), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(callPhone))
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            
            phoneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            phoneButton.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 10),
            phoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 15),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc
    func handlePhoneButton() {
        if isHiding {
            phoneButton.setTitle("Скрыть", for: .normal)
            phoneLabel.textColor = .systemBlue
            phoneLabel.attributedText = NSAttributedString(string: phone, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            isHiding = false
        } else {
            hidePhoneNumber()
        }
    }
    
    func hidePhoneNumber() {
        phoneButton.setTitle("Показать", for: .normal)
        let hidingNumber = phone.dropLast(7).description + "**-****"
        phoneLabel.textColor = .label
        phoneLabel.attributedText = NSAttributedString(string: hidingNumber, attributes: [:])
        isHiding = true
    }
    
    @objc
    func callPhone() {
        guard !isHiding else { return }
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        if let url = URL(string: "telprompt://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
