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
    
    
    init(coreData: CoreDataManagerProtocol, network: NetworkManagerProtocol){
        self.coreDataManager = coreData
        self.networkManager = network
    }
    
    private func updateImg(image: Data, in country: Country) {

        country.flagData = image
        
        coreDataManager.saveContext()
        fetchCountrys()
        presenter?.updateTableView()
        
    }
    
    private func updateWeather(with weather: Weather, in city: City) {
        if weather.fact?.temp != nil {
            city.timeAndTemp.isNil = false 
            city.timeAndTemp.temp = weather.fact!.temp!
        }
        if weather.info?.tzinfo?.offset != nil {
            city.timeAndTemp.utcDiff = weather.info!.tzinfo!.offset!
        }
        
        coreDataManager.saveContext()
        presenter?.updateTableView()

    }
}



// MARK: - MainInteractorInputProtocol
extension MainInteractor: MainInteractorInputProtocol {
    

    public func fetchCountrys() {
        
        presenter?.updateCountrysArray(coreDataManager.fetchCountrys())
    }
    
    public func resetAllRecords() {
        
        coreDataManager.resetAllRecords()
        fetchCountrys()
    }
    
    public func deleteCity(_ city: City) {
        coreDataManager.deleteCity(city)
        fetchCountrys()
    }
    
    
    public func save(_ citySearch: CitySearch) {
        if let city = coreDataManager.save(citySearch) {
            fetchCountrys()
            presenter?.updateTableView()
            DispatchQueue.main.async {
                self.requestWeaher(forCity: city)
            }
        }
    }
    
    
    // MARK: - Request
    public func requestFlagImg(country: Country) {
        
        let iso = country.isoA2.lowercased()
        
        networkManager.requestFlagImg(iso: iso) { [weak self] imgData in
            self?.updateImg(image: imgData, in: country)
        }
    }
    
    public func requestWeaher(forCity city: City) {

        networkManager.requestWeaher(lat: city.latitude, long: city.longitude, limit: 1) { [weak self] weather in
            self?.updateWeather(with: weather, in: city)
        }
    }
}
