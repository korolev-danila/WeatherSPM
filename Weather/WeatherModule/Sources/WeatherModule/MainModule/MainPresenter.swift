//
//  MainPresenter.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import Foundation

struct HeaderCellViewModel {
    let name: String
    let imgData: Data
}

struct MainCellViewModel {
    let name: String
    let temp: String?
    let time: String
}

protocol MainPresenterDelegate: AnyObject  {
    func save(_ citySearch: CitySearch)
}

final class MainPresenter {
    weak var view: MainViewInputProtocol?
    private let router: MainRouterProtocol
    private let interactor: MainInteractorInputProtocol
    
    private var countrys: [Country] = []
    private var timer: Timer?
    
    init(interactor: MainInteractorInputProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Update properties
    private func startTimer() {
        if timer == nil {
            let timer = Timer(timeInterval: 60.0, target: self,
                              selector: #selector(reloadTable),
                              userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    @objc private func reloadTable() {
        view?.reloadTableView()
    }
    
    private func updateAllTemp() {
        DispatchQueue.main.async {
            for country in self.countrys {
                for city in country.citysArray {
                    self.interactor.requestWeaher(forCity: city)
                }
            }
        }
    }
}

// MARK: - MainViewOutputProtocol
extension MainPresenter: MainViewOutputProtocol {
    func viewDidLoad() {
        interactor.fetchCountrys()
        startTimer()
        updateAllTemp()
    }
    
    // MARK: - Actions
    func didTapButton() {
        router.pushSearchView(delegate: self)
    }
    
    func showDetails(index: IndexPath) {
        if let city = countrys[safe: index.section]?.citysArray[safe: index.row] {
            router.pushDetailsView(city: city)
        }
    }
    
    func deleteCity(for index: IndexPath) -> Int {
        let count = countrys[safe: index.section]?.citysArray.count
        
        if let city = countrys[safe: index.section]?.citysArray[safe: index.row] {
            interactor.deleteCity(city)
        }
        return count ?? 0
    }
    
    func deleteAll() {
        countrys = []
        interactor.resetAllRecords()
    }
    
    // MARK: - UI Update
    func countrysCount() -> Int {
        return countrys.count
    }
    
    func sectionArrayCount(_ section: Int) -> Int {
        return countrys[safe: section]?.citysArray.count ?? 0
    }
    
    func createHeaderViewModel(_ section: Int) -> HeaderCellViewModel {
        var data = Data()
        
        if let flagData = countrys[safe: section]?.flagData {
            /// checking for the correct picture
            if flagData == data {
                updateFlag(forSection: section)
            } else {
                data = flagData
            }
        } else {
            updateFlag(forSection: section)
        }
        return HeaderCellViewModel(name: countrys[safe: section]?.name ?? "",
                                   imgData: data)
    }
    
    func createCellViewModel(for index: IndexPath) -> MainCellViewModel {
        let name = countrys[safe: index.section]?.citysArray[safe: index.row]?.name ?? ""
        var temp: String? = nil
        var timeString = ""
        
        if let bool = countrys[safe: index.section]?.citysArray[safe: index.row]?.timeAndTemp.isNil {
            /// checking whether the temperature of the new city has been updated
            if !bool {
                let time = Date() + (countrys[safe: index.section]?.citysArray[safe: index.row]?.timeAndTemp.utcDiff ?? 0.0)
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                timeString = formatter.string(from: time)
                temp = "\(Int(countrys[safe: index.section]?.citysArray[safe: index.row]?.timeAndTemp.temp ?? 0))"
            }
        }
        return MainCellViewModel(name: name, temp: temp, time: timeString)
    }
    
    func updateFlag(forSection section: Int) {
        if let country = countrys[safe: section] {
            DispatchQueue.main.async {
                self.interactor.requestFlagImg(country: country)
            }
        }
    }
}

// MARK: - MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func updateTableView() {
        view?.reloadTableView()
    }
    
    func updateCountrysArray(_ array: [Country]) {
        countrys = array
    }
}

// MARK: - MainPresenterDelegate
extension MainPresenter: MainPresenterDelegate {
    func save(_ citySearch: CitySearch) {
        interactor.save(citySearch)
    }
}
