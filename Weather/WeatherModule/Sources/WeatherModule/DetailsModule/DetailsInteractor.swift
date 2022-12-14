//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Alamofire
import CoreData

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

    
    init(coreData: CoreDataManagerProtocol){
        self.coreDataManager = coreData
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
    
    private func requestIcon(_ icon: String,index: Int, completion: @escaping (_ i: Int,_ svg: String) -> ()) {
        
        let url = "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg"
        
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
  
                let str = String(decoding: data, as: UTF8.self)
                completion(index,str)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
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
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        let parameters: Parameters = [
            "lat" : city.latitude,
            "lon" : city.longitude,
            "lang" : "en_US",
            "limit" : 7,
            "hours" : "false",
            "extra" : "false"
        ]
        
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?") else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                
                guard let parsedResult: Weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    return
                }
                self.presenter?.updateViewWeather(parsedResult)
                self.updateAndSaveCityWeather(city: city, weather: parsedResult)
                DispatchQueue.main.async {
                    self.fetchIcons(weather: parsedResult)
                }
  
            case .failure(let error):
                print(error.localizedDescription)
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
        // description
        let headers: HTTPHeaders = [
            "X-Api-Key": "23b8c5c9589346c7afb95b7f4fd8f81d"
        ]
        
        guard let url = URL(string: url) else { return }
        AF.request(url,method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                guard let parsedResult: News = try? JSONDecoder().decode(News.self, from: data) else {
                    return
                }
                self.presenter?.updateNews(parsedResult)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
