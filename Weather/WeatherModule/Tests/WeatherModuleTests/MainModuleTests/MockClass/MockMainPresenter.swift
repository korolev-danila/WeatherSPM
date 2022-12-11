//
//  File.swift
//  
//
//  Created by Данила on 10.12.2022.
//


import XCTest
@testable import WeatherModule

class MockMainPresenter {
    public var countrys: [Country] = []
}
  
extension MockMainPresenter: MainInteractorOutputProtocol {
    
    public func updateTableView() {
        
    }
    
    public func updateCountrysArray(_ array: [Country]) {
        self.countrys = array
    }
    
}

extension MockMainPresenter: MainPresenterDelegate {
    public func save(_ citySearch: CitySearch) {
        
    }
}
