//
//  File.swift
//  
//
//  Created by Данила on 30.11.2022.
//


final class SearchModulBuider {
    static func build(delegate: MainPresenterDelegate) -> SearchViewController {
        let interctor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interctor, delegate: delegate)
        let viewController = SearchViewController(presenter: presenter)
        presenter.view = viewController
        interctor.presenter = presenter

        return viewController
    }
}
