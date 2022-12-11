//
//  File.swift
//  
//
//  Created by Данила on 11.12.2022.
//

import XCTest
@testable import WeatherModule


final class MainPresenterTests: XCTestCase {
    
    var presenter: MainPresenter?
    var mockRouter: MockMainRouter?
    var mockInteractor: MockMainInteractor?
    
    override func setUp() {
        super.setUp()
        
        mockRouter = MockMainRouter()
        mockInteractor = MockMainInteractor()
    
        presenter = MainPresenter(interactor: mockInteractor, router: mockRouter)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        presenter = nil
        mockRouter = nil
        mockInteractor = nil
    }
}
