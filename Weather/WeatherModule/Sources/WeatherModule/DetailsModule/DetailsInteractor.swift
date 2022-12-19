//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation

protocol DetailsInteractorInputProtocol {
    func requestWeaher(forCity city: City)
    func getNewsForCity(_ cityName: String)
}

protocol DetailsInteractorOutputProtocol: AnyObject {
    func updateViewWeather(_ weather: Weather)
    func updateNews(_ news: News)
}

final class DetailsInteractor {
    weak var presenter: DetailsInteractorOutputProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkManagerProtocol
    
    init(coreData: CoreDataManagerProtocol, network: NetworkManagerProtocol) {
        self.coreDataManager = coreData
        self.networkManager = network
    }
    
    deinit {
        print("deinit DetailsInteractor")
    }
    
    // MARK: - Private method
    private func fetchIcons(weather: Weather) {
        var weatherLocal = weather
        
        if let forecasts = weatherLocal.forecasts {
            var index = 0
            var counte = 0
            for _ in forecasts {
                if let icon = forecasts[index].parts?.dayShort?.icon {
                    requestIcon(icon,index: index) { [weak self] (index,svg) in
                        guard let _self = self,
                              forecasts.count > index else { return }
                        weatherLocal.forecasts?[index].svgStr = svg
                        counte += 1
                        
                        if counte == forecasts.count {
                            _self.presenter?.updateViewWeather(weatherLocal)
                        }
                    }
                }
                index += 1
            }
        }
    }
    
    private func requestIcon(_ icon: String, index: Int, completion: @escaping (_ index: Int,_ svg: String) -> ()) {
        networkManager.requestIcon(icon, index: index) { index, svg in
            completion(index, svg)
        }
    }
    
    private func updateAndSaveCityWeather(city: City, weather: Weather) {
        if let temp = weather.fact?.temp,
           let offset = weather.info?.tzinfo?.offset {
            city.timeAndTemp.isNil = false
            city.timeAndTemp.temp = temp
            city.timeAndTemp.utcDiff = offset
            coreDataManager.saveContext()
        }
    }
}

// MARK: - DetailsInteractorInputProtocol
extension DetailsInteractor: DetailsInteractorInputProtocol {
    func requestWeaher(forCity city: City) {
        networkManager.requestWeaher(lat: city.latitude, long: city.longitude, limit: 7) { [weak self] weather in
            guard let _self = self else { return }
            _self.presenter?.updateViewWeather(weather)
            _self.updateAndSaveCityWeather(city: city, weather: weather)
            DispatchQueue.main.async {
                _self.fetchIcons(weather: weather)
            }
        }
    }
    
    func getNewsForCity(_ cityName: String) {
        let name = cityName.replacingOccurrences(of: " ", with: "+")
        let removeOneWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        var dateOld = formatter.string(from: Date())
        let dateNow = formatter.string(from: Date())
        
        if let date = removeOneWeek {
            dateOld = formatter.string(from: date)
        }
        let url =  "https://newsapi.org/v2/everything?q=\(name)&from=\(dateOld)&to=\(dateNow)&sortBy=popularity&language=en&searchIn=title"
        
        networkManager.getNewsForCity(url) { [weak self] news in
            guard let _self = self else { return }
            _self.presenter?.updateNews(news)
        }
    }
}
