//
//  SearchInteractor.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation


protocol SearchInteractorInputProtocol {
    func getCitysArray(forName string: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func showCitys(_ citys: [CitySearch])
}


final class SearchInteractor {
    
    weak var presenter: SearchInteractorOutputProtocol?
    private let networkManager: NetworkManagerProtocol
    
    init( network: NetworkManagerProtocol) {
        self.networkManager = network
    }
    
    deinit {
        print("deinit SearchInteractor")
    }
}



// MARK: - SearchInteractorInputProtocol
extension SearchInteractor: SearchInteractorInputProtocol {
    
    public func getCitysArray(forName string: String) {
        
        networkManager.getCitysArray(forName: string) { [weak self] citys in
            self?.presenter?.showCitys(citys)
        }
    }
}
