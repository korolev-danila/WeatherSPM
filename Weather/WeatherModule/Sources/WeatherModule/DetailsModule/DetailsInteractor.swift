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
    
    init(coreData: CoreDataManagerProtocol, network: NetworkManagerProtocol){
        self.coreDataManager = coreData
        self.networkManager = network
    }
    
    deinit {
        print("deinit DetailsInteractor")
    }
    
    private func  fetchIcons(weather: Weather) {
        
        var weatherLocal = weather
        
        if weatherLocal.forecasts != nil {
            var index = 0
            var counte = 0
            for _ in weatherLocal.forecasts! {
                
                if let icon = weatherLocal.forecasts![index].parts?.dayShort?.icon {
                    requestIcon(icon,index: index) { [weak self] (i,svg) in
                        if weatherLocal.forecasts!.count > i {
                            weatherLocal.forecasts![i].svgStr = svg
                        }
                        counte += 1
                        if counte == weatherLocal.forecasts?.count {
                            self?.presenter?.updateViewWeather(weatherLocal)
                        }
                    }
                }
                index += 1
            }
        }
    }
    
    private func requestIcon(_ icon: String, index: Int, completion: @escaping (_ i: Int,_ svg: String) -> ()) {
        
        networkManager.requestIcon(icon, index: index) { i, svg in
            completion(i, svg)
        }
    }
    
    private func updateAndSaveCityWeather(city: City, weather: Weather) {
        
        if weather.fact?.temp != nil {
            city.timeAndTemp.isNil = false
            city.timeAndTemp.temp = weather.fact!.temp!
        }
        if weather.info?.tzinfo?.offset != nil {
            city.timeAndTemp.utcDiff = weather.info!.tzinfo!.offset!
        }
        
        coreDataManager.saveContext()
    }
}



// MARK: - DetailsInteractorInputProtocol
extension DetailsInteractor: DetailsInteractorInputProtocol {
    
    // MARK: Api request layer
    public func requestWeaher(forCity city: City) {
        
        networkManager.requestWeaher(lat: city.latitude, long: city.longitude, limit: 7) {[weak self] weather in
            self?.presenter?.updateViewWeather(weather)
            self?.updateAndSaveCityWeather(city: city, weather: weather)
            DispatchQueue.main.async {
                self?.fetchIcons(weather: weather)
            }
        }
    }
    
    public func getNewsForCity(_ cityName: String) {
        
        let name = cityName.replacingOccurrences(of: " ", with: "+")
        
        let removeOneWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        var timeString = formatter.string(from: Date())
        let dateNow = formatter.string(from: Date())
        if let date = removeOneWeek {
            timeString = formatter.string(from: date)
        }
        
        let url =  "https://newsapi.org/v2/everything?q=\(name)&from=\(timeString)&to=\(dateNow)&sortBy=popularity&language=en&searchIn=title"
        
        networkManager.getNewsForCity(url) { [weak self] news in
            self?.presenter?.updateNews(news)
        }
    }
}
