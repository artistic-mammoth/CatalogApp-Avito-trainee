//
//  HomeScreenProtocols.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 25.08.2023.
//

protocol HomeViewProtocol: AnyObject {
    func updateCollectionDataWith(_ data: CatalogDataModel)
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didSelectItemAt(id: String)
    func mainPageDataDidLoaded(data: [Advertisement])
    func handleError(_ error: NetworkError)
    func wantToRefresh()
}

protocol HomeInteractorProtocol: AnyObject {
    func loadMainPageData()
}

protocol HomeRouterProtocol: AnyObject {
    func openProductDetailsViewFor(id: String)
}
