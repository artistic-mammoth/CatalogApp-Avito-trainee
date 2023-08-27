//
//  HomeViewController.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Public properties
        var presenter: HomePresenterProtocol?
    
    // MARK: - Lifecycle
        override func loadView() {
            super.loadView()
            setupView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            presenter?.viewDidLoaded()
        }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {

}

// MARK: - Private extension
private extension HomeViewController {
    func setupView() {
        view.backgroundColor = .cyan
    }
}
