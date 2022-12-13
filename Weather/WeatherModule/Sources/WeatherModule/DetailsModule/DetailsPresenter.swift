//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation

struct CityViewModel {
    let cityName: String
    let countryFlag: Data?
    let isCapital: Bool
    let populationOfCity: String
}

struct FactViewModel {
    let season: String
    let dayTemp: String
    let nightTemp: String
    let condition: String
    let humidity: String
    let pressureMm: String
    let windSpeed: String
    let windDir: String
}

struct ForecastViewModel {
    let dayTemp: String
    let nightTemp: String
    let date: String
    let week: String
    let svgStr: String
}

struct NewsViewModel {
    let title: String
    let description: String
    let date: String
}


final class DetailsPresenter {
    
    private let interactor: DetailsInteractorInputProtocol
    private let router: DetailsRouterProtocol
    weak var view: DetailsViewInputProtocol?
    
    private var selectCellIndex: IndexPath = [0,0]
    
    private let city: City
    private var weather: Weather? {
        didSet {
            view?.reloadCollection()
        }
    }
    
    private var news: News? {
        didSet {
            view?.reloadTableView()
        }
    }
    
    init(interactor: DetailsInteractorInputProtocol, router: DetailsRouterProtocol, city: City){
        self.interactor = interactor
        self.router = router
        self.city = city
        
    }
    
    deinit {
        print("deinit DetailsPresenter")
    }
}
    


    // MARK: - DetailsViewOutputProtocol
extension DetailsPresenter: DetailsViewOutputProtocol {
    
    public func viewDidLoad() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.view?.reloadTableView()
//        }
//
        
        
        DispatchQueue.main.async {
            self.interactor.requestWeaher(forCity: self.city)
        }

        view?.configureCityView()

        DispatchQueue.main.async {
            self.interactor.getNewsForCity(self.city.name)
        }
    }
    
//    public func popVC() {
//        router.popVC()
//    }
    
    public func createCityViewModel() -> CityViewModel {
        var population = ""
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let string = formatter.string(for: Int(city.population)){
            population = string
        }
        
        return CityViewModel(cityName: city.name,
                             countryFlag: city.country.flagData,
                             isCapital: city.isCapital,
                             populationOfCity: population)
    }
    
    public func createFactViewModel() -> FactViewModel {
        
        var dayTemp = ""
        var nightTemp = ""
        var windSpeed = ""
        var dir = ""
        var pressur = ""
        var humidity = ""
        let condition = weather?.forecasts?[safe: selectCellIndex.row]?.parts?.dayShort?.condition ?? ""
        
        if let dTemp = weather?.forecasts?[safe: selectCellIndex.row]?.parts?.dayShort?.feelsLike {
            dayTemp = "\(Int(dTemp))"
        }
        if let nTemp = weather?.forecasts?[safe: selectCellIndex.row]?.parts?.nightShort?.feelsLike {
            nightTemp = "\(Int(nTemp))"
        }
        if let speed = weather?.forecasts?[safe: selectCellIndex.row]?.parts?.dayShort?.windSpeed {
            windSpeed = "\(speed) m/c"
        }
        if let double = weather?.forecasts?[safe: selectCellIndex.row]?.parts?.dayShort?.pressureMm {
            pressur = "\(Int(double)) mm"
        }
        if let humi = weather?.forecasts?[safe: selectCellIndex.row]?.parts?.dayShort?.humidity {
            humidity = "\(Int(humi))%"
        }
        
        switch weather?.forecasts?[safe: selectCellIndex.row]?.parts?.dayShort?.windDir  {
        case "nw": dir = "north-west"
        case "n": dir = "north"
        case "ne": dir = "northeast"
        case "e": dir = "eastern"
        case "se": dir = "south-eastern"
        case "s": dir = "southern"
        case "sw": dir = "southwest"
        case "w": dir = "western"
        case "c": dir = "windless"
        case .none: dir = "windless"
        case .some(_): dir = ""
        }
        
        return FactViewModel(season: weather?.fact?.season ?? "", dayTemp: dayTemp,
                             nightTemp: nightTemp, condition: condition,
                             humidity: humidity, pressureMm: pressur,
                             windSpeed: windSpeed, windDir: dir)
    }
    
    
    
    public func changeSelectCellIndex(_ index: IndexPath?) -> IndexPath {
        let oldInd = selectCellIndex
        if index != nil {
            selectCellIndex = index!
        }
        return oldInd
    }
    
    public func forecastCount() -> Int {
        if let count = weather?.forecasts?.count {
            return count
        }
        return 0
    }
    
    
    
    public func forecastViewModel(heightOfCell: Double, index: IndexPath) -> ForecastViewModel {
        var dayTemp = ""
        var nightTemp = ""
        var date = ""
        var week = ""
        var svgStr = ""

        if let  day = weather?.forecasts?[safe: index.row] {
            if let temp = day.parts?.dayShort?.temp {
                dayTemp = "\(Int(temp))"
            }
            if let temp = day.parts?.nightShort?.temp {
                nightTemp = "\(Int(temp))"
            }
            if day.date != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                
                if let dateSelf = dateFormatter.date(from: day.date!) {
                    dateFormatter.dateFormat = "dd.MM"
                    date = dateFormatter.string(from: dateSelf)
                    dateFormatter.dateFormat = "EEEE"
                    let weekOld = dateFormatter.string(from: dateSelf)
                    week = String(weekOld.prefix(3))
                }
            }
            
            if let svg = day.svgStr {
                let svgOld = String(svg.dropFirst(84))
                let svgNew = """
    <svg xmlns="https://www.w3.org/2000/svg" width="\(heightOfCell*2)" height="\(heightOfCell*2)" viewBox="0 2 28 28">
    """
                svgStr = svgNew + svgOld
            }
        }
 
        return ForecastViewModel(dayTemp: dayTemp, nightTemp: nightTemp,
                                 date: date, week: week, svgStr: svgStr)
    }

    public func newsCount() -> Int {
        if let count = news?.articles?.count {
            return count
        }
        return 0
    }
     
    
    public func createNewsViewModel(index: IndexPath) -> NewsViewModel {
        
        var title = ""
        var description = ""
        var date = ""
        
        if let item = news?.articles?[safe: index.row] {
            if item.title != nil && item.articleDescription != nil {
                title = item.title!
                description = item.articleDescription!
            }
            
            if item.publishedAt != nil {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let datePublished = dateFormatter.date(from: item.publishedAt!)
                dateFormatter.dateFormat = "dd.MM"
                if datePublished != nil {
                    date = dateFormatter.string(from: datePublished!)
                }
            }
        }
        
        return NewsViewModel(title: title, description: description, date: date)
    }
    
    /// when u tap at newsCell
    public func printItem(_ index: IndexPath) {
        print(news?.articles?[safe: index.row] ?? "nil")
    }
}



// MARK: - DetailsInteractorOutputProtocol
extension DetailsPresenter: DetailsInteractorOutputProtocol {
    
    public func updateViewWeather(_ weather: Weather) {
        self.weather = weather
        view?.configureWeatherView(indexCell: selectCellIndex)
        view?.stopShimmer()
    }
    
    public func updateNews(_ news: News) {
        self.news = news
    }
}


