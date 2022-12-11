//
//  SearchInteractor.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import Foundation
import Alamofire


protocol SearchInteractorInputProtocol {
    func getCitysArray(forName string: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func showCitys(_ citys: [CitySearch])
}


final class SearchInteractor {
    
    weak var presenter: SearchInteractorOutputProtocol?
    
    deinit {
        print("deinit SearchInteractor")
    }
}



// MARK: - SearchInteractorInputProtocol
extension SearchInteractor: SearchInteractorInputProtocol {
    
    public func getCitysArray(forName string: String) {
        var citys: [CitySearch] = []
        
        let headers: HTTPHeaders = [
            "X-Api-Key": "68RDqAquE3kZPbNHiOWsOA==n1zofIERlsSHI2iB"
        ]
        let parameters: Parameters = [
            "name" : string,
            "limit" : 30
        ]
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/city?") else { return }
        AF.request(url, parameters: parameters, headers: headers).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    print(data)
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
                        } catch {
                            print(error)
                        }
                    }

                    self?.presenter?.showCitys(citys)
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
