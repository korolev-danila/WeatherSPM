//
//  File.swift
//  
//
//  Created by Данила on 11.12.2022.
//

import XCTest
@testable import WeatherModule


final class MainRouterTests: XCTestCase {
    
    var router: MainRouter!
    var coredata: CoreDataProtocol!
    var mockPresenter: MainPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        
        coredata = CoreDataManager()
        router = MainRouter(coreData: coredata)
        mockPresenter = MockMainPresenter()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        coredata = nil
        router = nil
        mockPresenter = nil
    }
    
    func TestPushSearchViewNoThrow() {
        
        XCTAssertNoThrow(router?.pushSearchView(delegate: mockPresenter))
    }
    
    func TestPushDetailsViewNoThrow() {

        XCTAssertNoThrow(router?.pushDetailsView(city: <#T##City#>)
    }
}
