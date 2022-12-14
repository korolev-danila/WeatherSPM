//
//  File.swift
//  
//
//  Created by Данила on 14.12.2022.
//

import Foundation
import Alamofire



protocol NetworkManagerProtocol: AnyObject {
    
    func getCitysArray(forName string: String, completion: @escaping (_ citys: [CitySearch]) -> ())
    
    func requestFlagImg( iso: String , completion: @escaping (_ imgData: Data) -> ())
    
    func requestIcon(_ icon: String,index: Int, completion: @escaping (_ i: Int,_ svg: String) -> ())
    func requestWeaher( lat: Double, long: Double, limit: Int, completion: @escaping (_ weather: Weather) -> ())
    func getNewsForCity(_ url: String, completion: @escaping (_ news: News) -> ())
}



final class NetworkManager { }



extension NetworkManager: NetworkManagerProtocol {
    
    
    // MARK: - SearchModul
    public func getCitysArray(forName string: String, completion: @escaping (_ citys: [CitySearch]) -> ()) {
        var citys: [CitySearch] = []
        
        let headers: HTTPHeaders = [
            "X-Api-Key": "68RDqAquE3kZPbNHiOWsOA==n1zofIERlsSHI2iB"
        ]
        let parameters: Parameters = [
            "name" : string,
            "limit" : 30
        ]
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/city?") else { return }
        AF.request(url, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] else { return }
                    for dictionary in jsonArray {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
                            var city = try JSONDecoder().decode(CitySearch.self, from: jsonData)
                            
                            for iso in Iso3166_1a2.all {
                                if iso.rawValue == city.country {
                                    city.isoA2 = iso.rawValue
                                    city.country = iso.country
                                }
                            }
                            citys.append(city)
                        }
                    }
                    completion(citys)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    // MARK: - MainModul
    public func requestFlagImg(iso: String , completion: @escaping (_ imgData: Data) -> ()) {
        
        guard let url = URL(string: "https://flagcdn.com/w640/\(iso).jpg") else { return }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                
                completion(data)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    // MARK: - method for DetailsModul
    public func requestIcon(_ icon: String,index: Int, completion: @escaping (_ i: Int,_ svg: String) -> ()) {
        
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
    };
    
    public func requestWeaher( lat: Double, long: Double, limit: Int, completion: @escaping (_ weather: Weather) -> ()) {
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        
        let parameters: Parameters = [
            "lat" : lat,
            "lon" : long,
            "lang" : "en_US",
            "limit" : limit,
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
                
                completion(parsedResult)
  
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getNewsForCity(_ url: String, completion: @escaping (_ news: News) -> ()) {
        
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
                
                completion(parsedResult)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
