//
//  File.swift
//  
//
//  Created by Данила on 10.12.2022.
//


import XCTest
@testable import WeatherModule

class MockMainPresenter: MainInteractorOutputProtocol {
    public var countrys: [Country] = []
    
    public func updateTableView() {
        
    }
    
    public func updateCountrysArray(_ array: [Country]) {
        self.countrys = array
    }
    
}

