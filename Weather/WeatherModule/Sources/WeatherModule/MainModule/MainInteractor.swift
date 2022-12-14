//
//  MainInteractor.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import CoreData
import Alamofire

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
    
    private var countrys: [Country] = []
    
    init(coreData: CoreDataManagerProtocol){
        self.coreDataManager = coreData
    }
    
    private func updateImg(image: Data, in country: Country) {

        country.flagData = image
        
        coreDataManager.saveContext()
        fetchCountrys()
        presenter?.updateTableView()
        
    }
    
    private func updateWeather(with weather: WeatherSimple, in city: City) {
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
        
        countrys = coreDataManager.fetchCountrys()
        presenter?.updateCountrysArray(countrys)
    }
    
    public func resetAllRecords() {
        
        coreDataManager.resetAllRecords()
        fetchCountrys()
    }
    
    public func deleteCity(_ city: City) {
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
    
    
    // MARK: - Request
    public func requestFlagImg(country: Country) {

        let iso = country.isoA2.lowercased()
        
        guard let url = URL(string: "https://flagcdn.com/w640/\(iso).jpg") else { return }
        
        AF.request(url).responseData { [unowned self] response in
            switch response.result {
            case .success(let data):
                
                self.updateImg(image: data, in: country)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func requestWeaher(forCity city: City) {
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        let parameters: Parameters = [
            "lat" : city.latitude,
            "lon" : city.longitude,
            "lang" : "en_US",
            "limit" : 1,
            "hours" : "false",
            "extra" : "false"
        ]
        
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?") else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { [unowned self] response in
            switch response.result {
            case .success(let data):
                
                guard let parsedResult: WeatherSimple = try? JSONDecoder().decode(WeatherSimple.self, from: data) else {
                    return
                }
                
                self.updateWeather(with: parsedResult, in: city)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
