//
//  CatalogCollectionView.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import UIKit

protocol CatalogCollectionViewDelegate: UIViewController {
    func didSelectItemAt(id: String)
    func wantToRefresh()
}

final class CatalogCollectionView: UIView {
    // MARK: - Public properties
    weak var delegate: CatalogCollectionViewDelegate?
    
    var dataModel: CatalogDataModel = [] {
        didSet {
            isLoading = false
            refreshControl.endRefreshing()
            collectionView.reloadData()
        }
    }
    
    // MARK: - Private properties
    private var isLoading: Bool = true
    
    // MARK: - Views
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init(delegate: CatalogCollectionViewDelegate? = nil) {
        super.init(frame: .zero)
        
        let layout = createCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.delegate = delegate
        setupView()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CatalogCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        isLoading ? 1 : dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isLoading ? Config.mockupCount : dataModel[section].items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isLoading else { return }
        
        guard let id = dataModel[indexPath.section].items[indexPath.row].id else { return }
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell?.alpha = 0.9
        } completion: { [weak self] _ in
            self?.delegate?.didSelectItemAt(id: id)
            UIView.animate(withDuration: 0.2) {
                cell?.transform = .identity
                cell?.alpha = 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoading {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCellPlaceholder.reuseIdentifier, for: indexPath) as? CatalogCellPlaceholder else { fatalError("Cannot get cell of type CatalogCellPlaceholder") }
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCellView.reuseIdentifier, for: indexPath) as? CatalogCellView else { fatalError("Cannot get cell of type CatalogCellView") }
        
        let item = dataModel[indexPath.section].items[indexPath.row]
        
        cell.configureWith(data: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard !isLoading else { return }
        
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell?.alpha = 0.9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard !isLoading else { return }
        
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = .identity
            cell?.alpha = 1
        }
    }
}

// MARK: - Private extension
private extension CatalogCollectionView {
    func setupView() {
        addViews(collectionView)
        
        configureCollectionView()
        
        backgroundColor = Config.backgroundColor
        collectionView.backgroundColor = Config.backgroundColor
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CatalogCellView.self, forCellWithReuseIdentifier: CatalogCellView.reuseIdentifier)
        collectionView.register(CatalogCellPlaceholder.self, forCellWithReuseIdentifier: CatalogCellPlaceholder.reuseIdentifier)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
    }
    
    @objc
    private func didPullToRefresh() {
        guard !isLoading else { return }
        isLoading = true
        collectionView.reloadData()
        delegate?.wantToRefresh()
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(310)),
            subitem: item, count: 2)
        
        group.contentInsets = .init(top: 0, leading: 11, bottom: 10, trailing: 11)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Config
fileprivate enum Config {
    static let mockupCount: Int = 6
    static let backgroundColor: UIColor = .clear
    static let labelCornerRadius: CGFloat = 5
}
