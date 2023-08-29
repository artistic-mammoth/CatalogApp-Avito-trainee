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
    
    // MARK: - Views
    private lazy var catalogView = CatalogCollectionView()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func updateCollectionDataWith(_ data: CatalogDataModel) {
        catalogView.dataModel = data
    }
}

// MARK: - CatalogCollectionViewDelegate
extension HomeViewController: CatalogCollectionViewDelegate {
    func wantToRefresh() {
        presenter?.wantToRefresh()
    }
    
    func didSelectItemAt(id: String) {
        presenter?.didSelectItemAt(id: id)
    }
}

// MARK: - Private extension
private extension HomeViewController {
    func setupView() {
        view.addViews(catalogView)
        
        catalogView.delegate = self
        
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            catalogView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            catalogView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            catalogView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            catalogView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
