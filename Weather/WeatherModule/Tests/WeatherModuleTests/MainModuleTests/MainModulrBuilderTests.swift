//
//  File.swift
//  
//
//  Created by Данила on 09.12.2022.
//

import XCTest
@testable import WeatherModule

final class MainModuleBuilderTests: XCTestCase {
    
    func testExample() throws {
        
        let vc = MainModulBuider.build()
        
        XCTAssertNotNil(vc)
    }
}
