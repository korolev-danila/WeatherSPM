//
//  MainInteractor.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

protocol MainInteractorInputProtocol {
    func fetchCountrys()
    func resetAllRecords()
    func deleteCity(_ city: City)
    func save(_ citySearch: CitySearch)
    func requestFlagImg(country: Country)
    func requestWeaher(forCity city: City)
}

protocol MainInteractorOutputProtocol: AnyObject {
    func updateCountrysArray(_ array: [Country])
    func updateTableView()
}

final class MainInteractor {
    weak var presenter: MainInteractorOutputProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    init(coreData: CoreDataManagerProtocol, network: NetworkManagerProtocol) {
        self.coreDataManager = coreData
        self.networkManager = network
    }
    
    // MARK: - Private method
    private func updateImg(image: Data, in country: Country) {
        country.flagData = image
        coreDataManager.saveContext()
        fetchCountrys()
        presenter?.updateTableView()
    }
    
    private func updateWeather(with weather: Weather, in city: City) {
        guard let temp = weather.fact?.temp,
              let offset = weather.info?.tzinfo?.offset else { return }
        
        city.timeAndTemp.isNil = false
        city.timeAndTemp.temp = temp
        city.timeAndTemp.utcDiff = offset
        coreDataManager.saveContext()
        presenter?.updateTableView()
    }
}

// MARK: - MainInteractorInputProtocol
extension MainInteractor: MainInteractorInputProtocol {
    func fetchCountrys() {
        presenter?.updateCountrysArray(coreDataManager.fetchCountrys())
    }
    
    func resetAllRecords() {
        coreDataManager.resetAllRecords()
        fetchCountrys()
    }
    
    func deleteCity(_ city: City) {
        coreDataManager.deleteCity(city)
        fetchCountrys()
    }
    
    func save(_ citySearch: CitySearch) {
        if let city = coreDataManager.save(citySearch) {
            fetchCountrys()
            presenter?.updateTableView()
            DispatchQueue.main.async {
                self.requestWeaher(forCity: city)
            }
        }
    }
    
    func requestFlagImg(country: Country) {
        let iso = country.isoA2.lowercased()
        networkManager.requestFlagImg(iso: iso) { [weak self] imgData in
            guard let _self = self else { return }
            _self.updateImg(image: imgData, in: country)
        }
    }
    
    func requestWeaher(forCity city: City) {
        networkManager.requestWeaher(lat: city.latitude, long: city.longitude, limit: 1) { [weak self] weather in
            guard let _self = self else { return }
            _self.updateWeather(with: weather, in: city)
        }
    }
}
