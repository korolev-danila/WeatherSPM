//
//  SearchPresenter.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation

struct SearchViewModel {
    let name: String
    let country: String
}


final class SearchPresenter {
    
    weak var view: SearchViewInputProtocol?
    private let interactor: SearchInteractorInputProtocol
    unowned private var delegate: MainPresenterDelegate
    
    private var citys: [CitySearch] = []
    
    private var timer = Timer()
    
    init(interactor: SearchInteractorInputProtocol, delegate: MainPresenterDelegate){
        self.interactor = interactor
        self.delegate = delegate
    }
    
    deinit {
        print("deinit SearchPresenter")
    }
}



// MARK: - SearchViewOutputProtocol
extension SearchPresenter: SearchViewOutputProtocol {
    
    public func viewModel(_ index: IndexPath) -> SearchViewModel {

        return SearchViewModel(name: citys[safe: index.row]?.name ?? "",
                               country: citys[safe: index.row]?.country ?? "")
    }
    
    public func citysCount() -> Int {
        return citys.count
    }
    
    public func save(_ index: IndexPath) {
        if let city = citys[safe: index.row] {
            delegate.save(city)
        }
    }
    
    public func requestCities(_ string: String) {
        if !string.trimmingCharacters(in: .whitespaces).isEmpty {
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
                self?.view?.startAnimation()
                self?.interactor.getCitysArray(forName: string)
            })
        } 
    }
}



// MARK: - SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {
    public func showCitys(_ citys: [CitySearch]) {
        self.citys = citys
        view?.reloadTableView()
        view?.stopAnimation()
    }
}
