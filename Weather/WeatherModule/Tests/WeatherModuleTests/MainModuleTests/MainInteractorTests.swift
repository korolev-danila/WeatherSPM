//
//  File.swift
//  
//
//  Created by Данила on 10.12.2022.
//

import XCTest
@testable import WeatherModule


final class MainInteractorTests: XCTestCase {
    
    var coreDataManager: CoreDataProtocol!
    var interactor: MainInteractor!
    var mockPresenter: MockMainPresenter!
    var cityMock: CitySearch!
    
    override func setUp() {
        super.setUp()
        
        mockPresenter = MockMainPresenter()
        coreDataManager = CoreDataManager()
        interactor = MainInteractor(coreData: coreDataManager)
        interactor.presenter = mockPresenter
        cityMock = CitySearch(name: "Foo", latitude: 0.0, longitude: 0.0, country: "Boo", isoA2: "EN", population: 0, isCapital: true)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataManager = nil
        interactor = nil
        mockPresenter = nil
        cityMock = nil
    }
    

    func testFetchCountrys() {
        
        XCTAssertNoThrow(interactor.fetchCountrys())
    }
    
    func testResetAllRecods() {
        
        
        XCTAssertNoThrow(interactor.resetAllRecords())
        XCTAssertEqual(mockPresenter.countrys.count, 0)
    }
    
    func testDeletCity() {
        interactor.resetAllRecords()
        interactor.save(cityMock)
        let city = mockPresenter.countrys[0].citysArray[0]
        
        XCTAssertNoThrow(interactor.deleteCity(city))
        XCTAssertEqual(mockPresenter.countrys.count, 0)
    }
    
    func testSaveMethod() {
        interactor.resetAllRecords()
        

        XCTAssertNoThrow(interactor.save(cityMock))
        XCTAssertEqual(mockPresenter.countrys.count, 1)

    }
    
}

